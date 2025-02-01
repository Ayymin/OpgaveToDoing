//
//  ToDoView.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 16/04/2024.
//

import SwiftUI
import SwiftData

struct ToDoView: View {
    
    @Environment(\.modelContext) private var context
    @State private var showAddform: Bool = false
    @State private var showDeleteAlert = false
    
    @Query(sort: \ToDo.creationDate, order:.forward) private var todos : [ToDo]
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let todo = todos [index]
            context.delete(todo)
        }
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    NavigationLink {
                        ToDoDetailsView(todo: todo)
                    } label: {
                        Image(uiImage: todo.coverImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:70, height:70)
                            .cornerRadius(7.0)
                            
                        Text(todo.name)
                    }
                     
                }
                .onDelete(perform: { indexSet in
                    delete(indexSet: indexSet)
                })}
            .navigationBarTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddform.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }

        }
        .sheet(isPresented: $showAddform) {
            AddToDo()
        }
    }
}




