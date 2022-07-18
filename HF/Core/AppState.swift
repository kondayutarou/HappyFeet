//
//  AppState.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/10.
//

import Foundation

struct AppState: Equatable {
    let datesOfParticipation: Array<ParticipationDate> = [
        ParticipationDate(id: UUID(), date: "10/08/2022"),
        ParticipationDate(id: UUID(), date: "10/09/2022"),
        ParticipationDate(id: UUID(), date: "10/11/2022"),
        ParticipationDate(id: UUID(), date: "10/12/2022")
    ]
    let pickupPoints: Array<PickupPoint> = [
        PickupPoint(id: UUID(), placeName: "7 Loves"),
        PickupPoint(id: UUID(), placeName: "Kothrud")
    ]
    var formInput: FormInput = FormInput()
}
