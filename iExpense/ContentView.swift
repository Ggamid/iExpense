//
//  ContentView.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 08.05.2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    
    var id: UUID
    var name: String
    var type: String
    var amount: Double
}

@Observable
class Expense{
    var items = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "items"){
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodeItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    var expense = Expense()
    @State var showingAddView = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(expense.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
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
