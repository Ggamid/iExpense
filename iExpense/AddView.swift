//
//  AddView.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 09.05.2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = "Name of Expense"
    @State private var amount: Double = 0.0
    @State private var type: String = "Personal"
    @State private var currency: String = "USD"
    
    
    let types = ["Personal", "Business"]
    let currencies = ["USD", "RUB", "EUR", "KZT", "SSP"]
    
    var expense: Expense
    
    var body: some View {
        NavigationStack{
            
            Form{
                Section("Add new expense"){
//                    TextField("Name", text: $name)
                    
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
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                if (name != "" && amount > 0.0){
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save") {
                            saveWith(type)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    AddView(expense: Expense())
}

extension AddView{
    func saveWith(_ type: String) {
        if type == "Personal"{
            expense.personalItems.append(ExpenseItem(id: UUID(), name: name, type: type, amount: amount, currency: currency))
        } else {
            expense.businessItems.append(ExpenseItem(id: UUID(), name: name, type: type, amount: amount, currency: currency))
        }
    }
}
