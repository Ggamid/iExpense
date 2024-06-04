//
//  Expense.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 04.06.2024.
//

import Foundation

struct ExpenseItem: Identifiable, Codable{
    
    var id: UUID
    var name: String
    var type: String
    var amount: Double
    var currency = "USD"
}

@Observable
class Expense{
    var personalItems = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(personalItems){
                UserDefaults.standard.set(encoded, forKey: "itemsPersonal")
            }
        }
    }
    var businessItems = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(businessItems){
                UserDefaults.standard.set(encoded, forKey: "itemsBusiness")
            }
        }
    }

    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "itemsPersonal"){
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                personalItems = decodeItems
            }
        }
        
        if personalItems.isEmpty {
            personalItems = []
        }
        
        if let savedItems = UserDefaults.standard.data(forKey: "itemsBusiness"){
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                businessItems = decodeItems
                return
            }
        }
        
        businessItems = []
    }
    
    
}
