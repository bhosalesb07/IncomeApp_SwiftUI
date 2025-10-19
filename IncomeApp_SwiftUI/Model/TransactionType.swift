//
//  TransactionType.swift
//  IncomeApp_SwiftUI
//
//  Created by Mac on 18/10/25.
//

import Foundation

enum TransactionType:String,Identifiable,CaseIterable{
    case income,expense
    var id:Self{self}
    
    var title:String{
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
