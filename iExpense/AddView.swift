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
    
    let types = ["Personal", "Business"]
    
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
                
                TextField("amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button(name != "" && amount >= 0.0 ? "Save" : "Cancel") {
                    if name != "" && amount != 0.0{
                        expense.items.append(ExpenseItem(id: UUID(), name: name, type: type, amount: amount))
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
