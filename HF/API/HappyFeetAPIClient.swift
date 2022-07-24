//
//  HappyFeetAPIClient.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/19.
//

import Foundation
import ComposableArchitecture
import Alamofire

// MARK: - API models
typealias ParticipationDateAPIResponse = [String]
extension ParticipationDateAPIResponse {
    func toModel(with uuid: () -> UUID) -> Array<ParticipationDate> {
        self.map { ParticipationDate(id: uuid(), date: $0) }
    }
}

typealias PickupPointAPIResponse = [String]
extension PickupPointAPIResponse {
    func toModel(with uuid: () -> UUID) -> Array<PickupPoint> {
        self.map { PickupPoint(id: uuid(), placeName: $0) }
    }
}

struct ApplicationAPIResponse: Decodable, Equatable {
    let success: Bool
    let number: Int
}

struct HappyFeetAPIClient {
    var datesOfParticipation: () -> Effect<ParticipationDateAPIResponse, ApiError>
    var pickupPoints: () -> Effect<PickupPointAPIResponse, ApiError>
    var application: (FormInput) -> Effect<ApplicationAPIResponse, ApiError>
    
    struct ApiError: Error, Equatable {
        let message: String?
    }
}

extension HappyFeetAPIClient {
    static func live(baseUri: String) -> HappyFeetAPIClient {
        HappyFeetAPIClient(
            datesOfParticipation: {
                return AF.request("\(baseUri)/participationDateList")
                    .validate()
                    .publishDecodable(type: ParticipationDateAPIResponse.self)
                    .value()
                    .mapError { ApiError(message: $0.localizedDescription) }
                    .eraseToEffect()
            },
            pickupPoints: {
                return AF.request("\(baseUri)/pickupPoints")
                    .validate()
                    .publishDecodable(type: PickupPointAPIResponse.self)
                    .value()
                    .mapError { ApiError(message: $0.localizedDescription) }
                    .eraseToEffect()
            },
            application: { form in
                let params: Parameters = [
                    "firstName": form.firstName,
                    "lastName": form.lastName,
                    "email": form.email,
                    "telephone": form.telephone,
                    "address": form.address,
                    "dateOfBirth": form.dateOfBirth,
                    "participationDate": form.pickedDate?.date,
                    "bloodType": form.pickedBloodType?.rawValue,
                    "pastInjuriesAndDisabilities": form.pastInjuriesAndDisabilities,
                    "pickupPoint": form.selectedPickupPoint?.placeName
                ]
                return AF.request("\(baseUri)/applicationResult", method: .post, parameters: params, encoding: JSONEncoding.default)
                    .validate()
                    .publishDecodable(type: ApplicationAPIResponse.self)
                    .value()
                    .mapError { ApiError(message: $0.localizedDescription) }
                    .eraseToEffect()
            }
        )
    }
}

// MARK: - Private helpers

private let jsonDecoder = JSONDecoder()
