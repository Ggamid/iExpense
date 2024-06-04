//
//  AddView.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 09.05.2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = "Name of Expense"
    @State private var amount: Double = 0.0
    @State private var type: String = "Personal"
    @State private var currency: String = "USD"
    
    
    let types = ["Personal", "Business"]
    let currencies = ["USD", "RUB", "EUR", "KZT", "SSP"]
    
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
                    HStack{
                        TextField("amount", value: $amount, format: .currency(code: currency))
                            .keyboardType(.decimalPad)
                        Stepper("", value: $amount)
                    }
                    
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
    AddView()
}

extension AddView{
    func saveWith(_ type: String) {
        if type == "Personal"{
            modelContext.insert(PersonalExpense(id: UUID(), name: name, type: type, amount: amount, currency: currency))
        } else {
            modelContext.insert(BusinessExpense(id: UUID(), name: name, type: type, amount: amount, currency: currency))
        }
    }
}
