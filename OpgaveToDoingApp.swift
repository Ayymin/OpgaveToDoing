//
//  OpgaveToDoingApp.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 16/04/2024.
//

import SwiftUI
import SwiftData

@main
struct OpgaveToDoingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ToDo.self, ToDoType.self])
                .environmentObject(LocationController())

                
            }
    }
}
