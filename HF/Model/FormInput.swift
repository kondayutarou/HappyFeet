//
//  FormInput.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/16.
//

import Foundation

struct FormInput: Equatable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var telephone = ""
    var address = ""
    var dateOfBirth = ""
    var pickedDate: ParticipationDate? = nil
    var pickedBloodType: BloodType? = nil
    var pastInjuriesAndDisabilities = ""
    var selectedPickupPoint: PickupPoint? = nil
    var disclaimerChecked = false

    func nameValidatinWarning() -> String? {
        let emptyFields = [firstName, lastName].filter(\.isEmpty)
        guard emptyFields == [] else { return L10n.Application.notFilled }
        return nil
    }
    
    func emailValidationWarning() -> String? {
        guard !email.isEmpty else { return L10n.Application.notFilled }
        guard email.isValidEmail() else { return L10n.Application.Email.invalidFormat }
        return nil
    }

    func telephoneValidationWarning() -> String? {
        guard !telephone.isEmpty else { return L10n.Application.notFilled }
        guard telephone.isValidPhoneNumber() else { return L10n.Application.Telephone.invalidFormat }
        return nil
    }
    
    func addressValidationWarning() -> String? {
        guard !address.isEmpty else { return L10n.Application.notFilled }
        return nil
    }
    
    func dateOfBirthValidationWarning() -> String? {
        guard !dateOfBirth.isEmpty else { return L10n.Application.notFilled }
        guard dateOfBirth.toDate() != nil else { return L10n.Application.DateOfBirth.invalidFormat }
        return nil
    }
    
    func dateOfParticipationValidationWarning() -> String? {
        guard pickedDate != nil else { return L10n.Application.DateOfParticipation.notPicked }
        return nil
    }
    
    func bloodGroupValidationWarning() -> String? {
        guard pickedBloodType != nil else { return L10n.Application.BloodType.notPicked }
        return nil
    }
    
    func pickupPointValidationWarning() -> String? {
        guard selectedPickupPoint != nil else { return L10n.Application.PickupPoint.notPicked }
        return nil
    }

    func isInputValid() -> Bool {
        let emptyFields = [email, telephone, address, dateOfBirth].filter(\.isEmpty)
        guard emptyFields == [] else { return false }
        guard dateOfBirth.toDate() != nil else { return false }
        guard email.isValidEmail() else { return false }
        guard telephone.isValidPhoneNumber() else { return false }
        guard pickedDate != nil else { return false }
        guard pickedBloodType != nil else { return false }
        guard selectedPickupPoint != nil else { return false }
        guard disclaimerChecked else { return false }
        return true
    }
}
