//
//  AppEnvironment.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/10.
//

import Foundation
import CombineSchedulers

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var happyFeetApiClient: HappyFeetAPIClient
    var uuid: () -> UUID
}
