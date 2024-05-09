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
    var currency = "USD"
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
                        Text(item.amount, format: .currency(code: item.currency))
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding()
                    .background(getColor(by: item.amount))
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
    
    func getColor(by amount: Double) -> Color {
        switch amount{
        case 0...10: return Color.green.opacity(0.7)
        case 10...100: return Color.orange.opacity(0.7)
        default: return Color.red.opacity(0.7)
        }
        
    }
}
