//
//  ContentView.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 16/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ToDoView()
                .tabItem {
                    Label("ToDos", systemImage: "book")
                }
                .tag(1)
            UserView()
                .tabItem {
                    Label("User", systemImage: "person.circle")
                    
                }
                .tag(2)
            TypeView()
                .tabItem {
                    Label("Types", systemImage: "list.bullet.clipboard")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
