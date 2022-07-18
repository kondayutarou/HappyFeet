//
//  DateUtilProvider.swift
//  HappyFeet
//
//  Created by Yutaro on 2022/07/16.
//

import Foundation

struct DateUtilProvider {
    static let dateUtil: DateFormatter = {
        let formatter = DateFormatter()
        let format = DateFormatter.dateFormat(fromTemplate: "ddMMyyyy", options: 0, locale: .current)!
        formatter.setLocalizedDateFormatFromTemplate(format)
        return formatter
    }()
}
