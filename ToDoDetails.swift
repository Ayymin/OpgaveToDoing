//
//  ToDoDetails.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 06/05/2024.
//

import SwiftUI

struct ToDoDetailsView: View {
    var todo: ToDo
    
    @State private var showEditForm: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MapDetailView(todo: todo)
            Text("Name:")
                .font(.headline)
            Text(todo.name)
            
            Text("Description:")
                .font(.headline)
            Text(todo.descriptions)
            
            Text("Location:")
                .font(.headline)
            
            
            Text("Status:")
                .font(.headline)
            Text(todo.status.rawValue)
            
            Text("Creation Date:")
                .font(.headline)
            Text("\(todo.creationDate)")
            
            Text("Types")
                .font (.headline)
            Text("\(todo.toDoType.type)")
        }
            .padding()
            .navigationBarTitle(todo.name)
            Button("Edit") {
                showEditForm.toggle()
            }
            .sheet(isPresented: $showEditForm) {
                EditToDoView(selectedTodo: todo)
            }
        }
    }

