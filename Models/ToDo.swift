//
//  ToDo.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 16/04/2024.
//

import Foundation
import SwiftData
import UIKit

@Model
final class ToDo: Identifiable {
    //let id = UUID().uuidString
    var name: String
    var descriptions: String
    var location: Location
    var creationDate: Date
    var status: Status
    @Attribute(.externalStorage) var cover: Data
    var toDoType: ToDoType
    
    enum Status: String, CaseIterable, Codable {
        case deleted = "Deleted", inProgress = "In Progress", finished = "Finished", pending = "Pending"
    }
    
    init(name: String, descriptions: String, location: Location, creationDate: Date, status: Status, cover: Data, toDoType: ToDoType) {
        self.name = name
        self.descriptions = descriptions
        self.location = location
        self.creationDate = creationDate
        self.status = status
        self.cover = cover
        self.toDoType = toDoType
    }
    
    struct Location: Codable {
        let latitude, longitude: Double
    }
    

    @Attribute(.ephemeral) var coverImage: UIImage {
         UIImage(data: cover)!
     }
}

