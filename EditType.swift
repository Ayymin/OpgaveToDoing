//
//  EditType.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 08/05/2024.
//

import SwiftUI

struct EditTypeView: View {
    @State var selectedType: ToDoType
   @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Type", text: $selectedType.type )
            
        }; HStack {
            Button("Update Type") {
                context.insert(selectedType)
            }
        }
    }
}


