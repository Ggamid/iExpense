//
//  AddView.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 09.05.2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var amount: Double = 0.0
    @State private var type: String = "Personal"
    @State private var currency: String = "USD"
    
    let types = ["Personal", "Business"]
    let currencies = ["USD", "RUB", "EUR", "KZT", "SSP"]
    
    var expense: Expense
    
    var body: some View {
        NavigationStack{
            
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
                
                Picker("Currency", selection: $currency){
                    ForEach(currencies, id: \.self){
                        Text($0)
                    }
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button(name != "" && amount >= 0.0 ? "Save" : "Cancel") {
                    if name != "" && amount != 0.0{
                        expense.items.append(ExpenseItem(id: UUID(), name: name, type: type, amount: amount, currency: currency))
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expense: Expense())
}
