//
//  EditToDoView.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 06/05/2024.
//

import SwiftUI

struct EditToDoView: View {
    @State var selectedTodo: ToDo
   @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Form {
            TextField("Name", text: $selectedTodo.name)
            TextField("Description", text: $selectedTodo.descriptions)
            Picker("Status", selection: $selectedTodo.status) {
                    ForEach(ToDo.Status.allCases, id: \.rawValue) {status in
                        Text(status.rawValue).tag(status)
                    }
                }
            DatePicker("Start Date",
                       selection: $selectedTodo.creationDate,
                       displayedComponents: [.date]
            )
        }
        HStack {
            Button("Update ToDo") {
                context.insert(selectedTodo)
                dismiss()
            }
        }
    }
}
