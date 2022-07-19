//
//  AppState.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/10.
//

import Foundation

struct AppState: Equatable {
    var datesOfParticipation: Array<ParticipationDate> = []
    var pickupPoints: Array<PickupPoint> = []
    var formInput: FormInput = FormInput()
}
