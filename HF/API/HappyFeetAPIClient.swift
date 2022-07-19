//
//  HappyFeetAPIClient.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/19.
//

import Foundation
import ComposableArchitecture

// MARK: - API models
struct ParticipationDateAPIResponse: Decodable, Equatable {
    var results: [Result]
    
    struct Result: Decodable, Equatable {
        var date: String
    }
    
    func toModel() -> Array<ParticipationDate> {
        results.map { ParticipationDate(id: UUID(), date: $0.date) }
    }
}

struct HappyFeetAPIClient {
    var datesOfParticipation: () -> Effect<ParticipationDateAPIResponse, ApiError>

    struct ApiError: Error, Equatable {}
}

extension HappyFeetAPIClient {
    static let live = HappyFeetAPIClient(
        datesOfParticipation: {
            URLSession.shared.dataTaskPublisher(for: URL(string: "http://localhost:3000/participationDateList")!)
                .map { data, _ in data }
                .decode(type: ParticipationDateAPIResponse.self, decoder: jsonDecoder)
                .mapError { _ in ApiError() }
                .eraseToEffect()
        }
    )
}

// MARK: - Private helpers

private let jsonDecoder: JSONDecoder = {
  let decoder = JSONDecoder()
  return decoder
}()
