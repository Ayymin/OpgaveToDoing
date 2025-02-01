//
//  TypeView.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 07/05/2024.
//

import SwiftUI
import SwiftData

struct TypeView: View {
    @Environment(\.modelContext) private var context
    @State private var TypeText: String = ""
    @Query private var todoTypes: [ToDoType]
    
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let todotype = todoTypes [index]
            context.delete(todotype)
        }
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoTypes) { todotype in
                        NavigationLink {
                            EditTypeView(selectedType: todotype)
                        } label: {
                            Text(todotype.type)
                        }
                    }
                    
                    .onDelete(perform: { indexSet in
                        delete(indexSet: indexSet)
                    })}
                
                .navigationBarTitle("Types")
                
                Spacer()
                VStack {
                    HStack {
                        Text("Type").font(.headline)
                        TextField("Create a type", text: $TypeText)
                    }
                    Button("Create") {
                        if(!TypeText.isEmpty) {
                            let todotype = ToDoType(type: TypeText)
                            context.insert(todotype)
                            
                            do {
                                try context.save()
                            } catch {
                                fatalError(error.localizedDescription)
                            }
                        }
                        print("Field cannot be empty")
                    }
                }
            }
        }
    }
}
