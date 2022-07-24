//
//  HappyFeetAPIClient.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/19.
//

import Foundation
import ComposableArchitecture

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

struct HappyFeetAPIClient {
    var datesOfParticipation: () -> Effect<ParticipationDateAPIResponse, ApiError>
    var pickupPoints: () -> Effect<PickupPointAPIResponse, ApiError>

    struct ApiError: Error, Equatable {
        let message: String?
    }
}

extension HappyFeetAPIClient {
    static func live(baseUri: String) -> HappyFeetAPIClient {
        HappyFeetAPIClient(
            datesOfParticipation: {
                return URLSession.shared.dataTaskPublisher(for: URL(string: "\(baseUri)/participationDateList")!)
                    .map { data, _ in data }
                    .decode(type: ParticipationDateAPIResponse.self, decoder: jsonDecoder)
                    .mapError { error in ApiError(message: error.localizedDescription) }
                    .eraseToEffect()
            },
            pickupPoints: {
                return URLSession.shared.dataTaskPublisher(for: URL(string: "\(baseUri)/pickupPoints")!)
                    .map { data, _ in data }
                    .decode(type: PickupPointAPIResponse.self, decoder: jsonDecoder)
                    .mapError { error in ApiError(message: error.localizedDescription) }
                    .eraseToEffect()
            }
        )
    }
}

// MARK: - Private helpers

private let jsonDecoder = JSONDecoder()
