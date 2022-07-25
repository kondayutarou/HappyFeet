//
//  AppView.swift
//  Shared
//
//  Created by Yutaro on 2022/07/10.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    private let store: Store<AppState, AppAction>
    @ObservedObject private var viewStore: ViewStore<ViewState, AppAction>

    init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: ViewState.init(state:)))
        viewStore.send(AppAction.viewDidLoad)
    }
    
    struct ViewState: Equatable {
        let formInput: FormInput
        var datesOfParticipation: Array<ParticipationDate>
        let pickupPoints: Array<PickupPoint>
        
        init(state: AppState) {
            self.formInput = state.formInput
            self.datesOfParticipation = state.datesOfParticipation
            self.pickupPoints = state.pickupPoints
        }
    }
    
    var body: some View {
        List {
            Group {
                Section {
                    TextField(
                        L10n.Application.Name.firstName,
                        text: viewStore.binding(get: \.formInput.firstName, send: AppAction.firstNameChanged)
                    )
                    .keyboardType(.namePhonePad)
                    .autocapitalization(.allCharacters)
                    TextField(
                        L10n.Application.Name.lastName,
                        text: viewStore.binding(get: \.formInput.lastName, send: AppAction.lastNameChanged)
                    )
                    .keyboardType(.namePhonePad)
                    .autocapitalization(.allCharacters)
                } header: {
                    HStack {
                        Text(L10n.Application.Name.title)
                        if let warning = viewStore.formInput.nameValidatinWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    TextField(
                        "",
                        text: viewStore.binding(get: \.formInput.email, send: AppAction.emailChanged)
                    )
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                } header: {
                    HStack {
                        Text(L10n.Application.Email.title)
                        if let warning = viewStore.formInput.emailValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    TextField(
                        "",
                        text: viewStore.binding(get: \.formInput.telephone, send: AppAction.telephoneChanged)
                    )
                    .keyboardType(.phonePad)
                } header: {
                    HStack {
                        Text(L10n.Application.Telephone.title)
                        if let warning = viewStore.formInput.telephoneValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
            }
            
            Group {
                Section {
                    TextField(
                        "",
                        text: viewStore.binding(get: \.formInput.address, send: AppAction.addressChanged)
                    )
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.words)
                } header: {
                    HStack {
                        Text(L10n.Application.address)
                        if let warning = viewStore.formInput.addressValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    TextField(
                        "",
                        text: viewStore.binding(get: \.formInput.dateOfBirth, send: AppAction.dateOfBirthChanged)
                    )
                    .keyboardType(.numbersAndPunctuation)
                } header: {
                    HStack {
                        Text(L10n.Application.dateOfBirth)
                        if let warning = viewStore.formInput.dateOfBirthValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    Picker("",
                           selection: viewStore.binding(get: \.formInput.pickedDate, send: AppAction.dateOfParticipationPicked)) {
                        ForEach(viewStore.datesOfParticipation) { date in
                            Text(date.date).tag(ParticipationDate?.some(date))
                        }
                    }
                           .pickerStyle(.wheel)
                } header: {
                    HStack {
                        Text(L10n.Application.DateOfParticipation.title)
                        if let warning = viewStore.formInput.dateOfParticipationValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    Picker("",
                           selection: viewStore.binding(get: \.formInput.pickedBloodType, send: AppAction.bloodTypePicked)) {
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(BloodType?.some(type))
                        }
                    }
                           .pickerStyle(.wheel)
                } header: {
                    HStack {
                        Text(L10n.Application.BloodType.title)
                        if let warning = viewStore.formInput.bloodGroupValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
            }
            
            Group {
                Section {
                    TextEditor(text: viewStore.binding(get: \.formInput.pastInjuriesAndDisabilities, send: AppAction.pastInjuriesAndDisabilitiesEdited))
                        .keyboardType(.asciiCapable)
                } header: {
                    Text(L10n.Application.pastInjuries)
                }
                
                Section {
                    Picker("",
                           selection: viewStore.binding(get: \.formInput.selectedPickupPoint, send: AppAction.pickupPointSelected)) {
                        ForEach(viewStore.pickupPoints) { point in
                            Text(point.placeName).tag(PickupPoint?.some(point))
                        }
                    }
                           .pickerStyle(.wheel)
                } header: {
                    HStack {
                        Text(L10n.Application.PickupPoint.title)
                        if let warning = viewStore.formInput.pickupPointValidationWarning() {
                            Text(warning).foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    Toggle(
                        L10n.Application.Disclaimer.title,
                        isOn: viewStore.binding(get: \.formInput.disclaimerChecked, send: AppAction.disclaimerChecked)
                    )
                } header: {
                    Text(L10n.Application.Disclaimer.notPicked).foregroundColor(.red)
                        .opacity(viewStore.formInput.disclaimerChecked ? 0 : 1)
                }

                Button {
                    viewStore.send(.submitTapped)
                } label: {
                    HStack {
                        Spacer()
                        Text(L10n.Application.submit)
                        Spacer()
                    }
                }
                .disabled(!viewStore.formInput.isInputValid())
                .alert(
                    self.store.scope(state: \.alert),
                    dismiss: .alertDismissed
                )
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                    mainQueue: .main,
                    happyFeetApiClient: HappyFeetAPIClient.live(
                        baseUri: Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
                                                               ),
                    uuid: UUID.init
                )
            )
        )
    }
}
