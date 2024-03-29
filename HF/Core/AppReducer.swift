//
//  AppReducer.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/10.
//

import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    Reducer { state, action, environment in
        switch action {
        case .viewDidLoad:
            return .merge(
                environment
                .happyFeetApiClient.datesOfParticipation()
                .catchToEffect(AppAction.datesOfParticipationResponse),
                environment
                .happyFeetApiClient.pickupPoints()
                .catchToEffect(AppAction.pickUpPointsResponse)
            )
        case let .datesOfParticipationResponse(.success(response)):
            state.datesOfParticipation = response.toModel(with: environment.uuid)
            return .none
        case .datesOfParticipationResponse(.failure):
            return .none
        case let .pickUpPointsResponse(.success(response)):
            state.pickupPoints = response.toModel(with: environment.uuid)
            return .none
        case .pickUpPointsResponse(.failure):
            return .none
        case let .firstNameChanged(firstName):
            state.formInput.firstName = firstName
            return .none
        case let .lastNameChanged(lastName):
            state.formInput.lastName = lastName
            return .none
        case let .emailChanged(email):
            state.formInput.email = email
            return .none
        case let .telephoneChanged(telephone):
            state.formInput.telephone = telephone
            return .none
        case let .addressChanged(address):
            state.formInput.address = address
            return .none
        case let .dateOfBirthChanged(dateOfBirth):
            state.formInput.dateOfBirth = dateOfBirth
            return .none
        case let .dateOfParticipationPicked(participationDate):
            state.formInput.pickedDate = participationDate
            return .none
        case let .bloodTypePicked(bloodType):
            state.formInput.pickedBloodType = bloodType
            return .none
        case let .pastInjuriesAndDisabilitiesEdited(details):
            state.formInput.pastInjuriesAndDisabilities = details
            return .none
        case let .pickupPointSelected(point):
            state.formInput.selectedPickupPoint = point
            return .none
        case let .disclaimerChecked(isChecked):
            state.formInput.disclaimerChecked = isChecked
            return .none
        case .submitTapped:
            return environment.happyFeetApiClient.application(state.formInput)
                .catchToEffect(AppAction.applicationResponse)
        case let .applicationResponse(.success(response)):
            state.alert = .init(
                title: .init(L10n.Application.Successful.title),
                message: .init(L10n.Application.Successful.message(response.number)),
                dismissButton: .default(.init(L10n.Application.dismiss), action: .send(.alertDismissed))
            )
            return .none
        case let .applicationResponse(.failure(error)):
            state.alert = .init(
                title: .init(L10n.Application.Error.title),
                message: .init(error.message ?? ""),
                dismissButton: .default(.init(L10n.Application.dismiss), action: .send(.alertDismissed))
            )
            return .none
        case .alertDismissed:
            state.alert = nil
            return .none
        }
    }
        .debug()
)
