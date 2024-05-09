//
//  ContentView.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 08.05.2024.
//

import SwiftUI

struct ExpenseItem: Identifiable{
    
    var id: UUID
    var name: String
    var type: String
    var amount: Double
}

@Observable
class Expense{
    var items = [ExpenseItem]()
}

struct ContentView: View {
    var expense = Expense()
    @State var showingAddView = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(expense.items){ item in
                    Text(item.name)
                }
                .onDelete(perform: removeExtense)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus") {
                    showingAddView = true
                }
            }
        }
        .sheet(isPresented: $showingAddView){
            AddView(expense: expense)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView{
    func removeExtense(offset: IndexSet){
        expense.items.remove(atOffsets: offset)
    }
}
