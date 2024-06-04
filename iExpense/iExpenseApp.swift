//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Gamıd Khalıdov on 08.05.2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [BusinessExpense.self, PersonalExpense.self])
        
    }
}
