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
    var personalItems = [ExpenseItem]()
    var businessItems = [ExpenseItem]()
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "items"){
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodeItems
                personalItems = getExpensesSeparated(from: items, by: "Personal")
                businessItems = getExpensesSeparated(from: items, by: "Business")
                return
            }
        }
        items = []
    }
    
    func getExpensesSeparated(from arr: [ExpenseItem], by type: String) -> [ExpenseItem]{
        var resArr = [ExpenseItem]()
        for i in arr{
            if i.type == type{
                resArr.append(i)
            }
        }
        return resArr
    }
    
}

struct ContentView: View {
    var expense = Expense()
    @State var showingAddView = false

    var body: some View {
        NavigationStack{
            List{
                if !expense.businessItems.isEmpty {
                    Section("Business expenses"){
                        ForEach(expense.businessItems){ item in
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
                        .onDelete(perform: { indexSet in
                            removeExtense(offset: indexSet, type: "Business")
                        })
                    }
                } else {
                    Section("Business expenses"){
                        Text("There is no any Business expenses")
                    }
                }
                if !expense.personalItems.isEmpty {
                    Section("Personal expenses"){
                        ForEach(expense.personalItems){ item in
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
                        .onDelete(perform: { indexSet in
                            removeExtense(offset: indexSet, type: "Personal")
                        })
                    }
                } else {
                    Section("Personal expenses"){
                        Text("There is no any Personal expenses")
                    }
                }
                
                
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
    func removeExtense(offset: IndexSet, type: String){
        if type == "Business"{
            expense.businessItems.remove(atOffsets: offset)
        } else {
            expense.personalItems.remove(atOffsets: offset)
        }
    }
    
    
    func getColor(by amount: Double) -> Color {
        switch amount{
        case 0...10: return Color.green.opacity(0.7)
        case 10...100: return Color.orange.opacity(0.7)
        default: return Color.red.opacity(0.7)
        }
        
    }
}
