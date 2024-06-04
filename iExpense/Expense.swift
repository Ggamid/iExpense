//
//  Expense.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 04.06.2024.
//

import SwiftData
import Foundation


@Model
class BusinessExpense {
    
    var id: UUID
    var name: String
    var type: String
    var amount: Double
    var currency = "USD"
    
    init(id: UUID, name: String, type: String, amount: Double, currency: String = "USD") {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
    
}

@Model
class PersonalExpense {
    
    var id: UUID
    var name: String
    var type: String
    var amount: Double
    var currency = "USD"
    
    init(id: UUID, name: String, type: String, amount: Double, currency: String = "USD") {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
    
}


