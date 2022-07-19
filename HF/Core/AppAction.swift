//
//  AppAction.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/10.
//

import Foundation

enum AppAction: Equatable {
    case viewDidLoad
    case datesOfParticipationResponse(Result<ParticipationDateAPIResponse, HappyFeetAPIClient.ApiError>)
    case pickUpPointsResponse(Result<PickupPointAPIResponse, HappyFeetAPIClient.ApiError>)
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
