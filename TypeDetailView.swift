//
//  TypeDetailView.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 07/05/2024.
//

import SwiftUI

struct TypeDetailView: View {
    var todotype: ToDoType
    
    var body: some View {
        Text("Name:")
            .font(.headline)
        Text(todotype.type)
    }
}

