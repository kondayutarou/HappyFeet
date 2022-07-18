//
//  AppAction.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/10.
//

import Foundation

enum AppAction: Equatable {
    case firstNameChanged(String)
    case lastNameChanged(String)
    case emailChanged(String)
    case telephoneChanged(String)
    case addressChanged(String)
    case dateOfBirthChanged(String)
    case dateOfParticipationPicked(ParticipationDate?)
    case bloodTypePicked(BloodType?)
    case pastInjuriesAndDisabilitiesEdited(String)
    case pickupPointSelected(PickupPoint?)
    case disclaimerChecked(Bool)
    case submitTapped
}
