//
//  HappyFeetApp.swift
//  Shared
//
//  Created by Yutaro on 2022/07/10.
//

import SwiftUI
import ComposableArchitecture

@main
struct HappyFeetApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState(),
                    reducer: appReducer,
                    environment: AppEnvironment(mainQueue: .main)
                )
            )
        }
    }
}
