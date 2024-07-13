//
//  ContentView.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 08.05.2024.
//

import SwiftData
import SwiftUI



struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var businessItems: [BusinessExpense]
    @Query var personalItems: [PersonalExpense]
    
    @State var showingAddView = false

    var body: some View {
        NavigationStack{
            List{
                if !businessItems.isEmpty {
                    Section("Business expenses"){
                        ForEach(businessItems){ item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: item.currency))
                            }
                            .accessibilityElement()
                            .accessibilityLabel(" \(item.name) amount \(String(format: "%.2f", item.amount))")
                            .accessibilityHint("type of expense\(item.type)")
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding()
                            .background(getColor(by: item.amount))
                        }
                        .onDelete(perform: { indexSet in
                            removeExtense(at: indexSet, type: "Business")
                        })
                    }
                } else {
                    Section("Business expenses"){
                        Text("There is no any Business expenses")
                    }
                }
                if !personalItems.isEmpty {
                    Section("Personal expenses"){
                        ForEach(personalItems){ item in
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
                            removeExtense(at: indexSet, type: "Personal")
                        })
                    }
                } else {
                    Section("Personal expenses"){
                        Text("There is no any Personal expenses")
                    }
                }
                
                
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("iExpense")
            .toolbar{
                NavigationLink{
                    AddView()
                } label: {
                    Image(systemName: "plus.app")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView{
    func removeExtense(at offsets: IndexSet, type: String){
        if type == "Business"{
            for offset in offsets{
                let expense = businessItems[offset]
                modelContext.delete(expense)
            }
        } else {
            for offset in offsets{
                let expense = personalItems[offset]
                modelContext.delete(expense)
            }
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
