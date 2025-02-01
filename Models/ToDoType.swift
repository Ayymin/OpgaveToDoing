//
//  ToDoType.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 07/05/2024.
//

import Foundation
import SwiftData

@Model
class ToDoType {
    
    @Attribute(.unique) var type: String
    
    @Relationship(deleteRule: .nullify, inverse: \ToDo.toDoType)
    var toDoItems: [ToDo]?
    
    init(type: String) {
        self.type = type
    }
}
