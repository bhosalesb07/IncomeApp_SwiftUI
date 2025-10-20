//
//  CurrencyModel.swift
//  IncomeApp_SwiftUI
//
//  Created by Mac on 19/10/25.
//

import Foundation


enum Currency: Int, CaseIterable {
    case usd, pounds
    
    var title: String {
        switch self {
        case .usd:
            return "USD"
        case .pounds:
            return "Pounds"
        }
    }
    
    var locale: Locale {
        switch self {
        case .usd:
            return Locale(identifier: "en_US")
        case .pounds:
            return Locale(identifier: "en_GB")
        }
    }
    
}
