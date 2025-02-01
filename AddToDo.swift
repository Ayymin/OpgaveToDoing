//
//  ToDoSetting.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 16/04/2024.
//

import SwiftUI
import SwiftData
import MapKit
import PhotosUI

struct AddToDo: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var locationController: LocationController
    
    @State private var name = ""
    @State private var description = ""
    @State private var creationDate = Date()
    @State private var status = ToDo.Status.finished
    @State private var selectedTodoType =  ToDoType(type:"Work")
    
    
    @Query(sort: \ToDoType.type) private var types: [ToDoType]

    @State private var imageData: Data = Data()
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedItemData: Data?
    
    func fromDataToImage(imageData: Data) -> Image {
        guard let image = UIImage(data: imageData) else { return Image(systemName: "person.circle") }
        return Image(uiImage: image)
    }
    
    var profileImage: Image {
        guard let data = selectedItemData, let image = UIImage(data: data) else {
            return Image(systemName: "person.crop.circle")
        }
        return Image(uiImage: image)
    }
    
    
    
    private var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !imageData.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Section {
                HStack {
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, selectionBehavior: .continuousAndOrdered, matching: .images, photoLibrary: .shared()) {
                        Label("Select an Image", systemImage: "photo.badge.plus")
                            }
                        }
                    }
                    Text("Name:")
                    TextField("Enter name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    Text("Description")
                    TextField("Enter description", text: $description)
                        .textFieldStyle(.roundedBorder)
                    Text("Location")
                    Picker("Status", selection: $status) {
                        ForEach(ToDo.Status.allCases, id: \.rawValue) {status in
                            Text(status.rawValue).tag(status)}
                    }
                    Picker("Types", selection: $selectedTodoType) {
                        ForEach(types, id: \.self) {
                            Text($0.type)}
                    }
                    .onChange(of: selectedItems) { oldValues, newValues in
                        if let item = newValues.first {
                            Task {
                                if let data = try? await item.loadTransferable(type:
                                            Data.self) {
                                    imageData = data
                                    
                                }
                            }
                        }}
                }
                Section("Map") {
                    ZStack(alignment: .top) {
                        Map(position: $locationController.userCameraPosition){
                            UserAnnotation()
                        }
                        .mapControls() {
                            MapUserLocationButton()
                        }
                        .frame(height: 200)
                    }
                }
                
                HStack {
                    Spacer()
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                    Spacer()
                    Button("Save") {
                        guard let currentLocation = locationController.locationManager?.location?.coordinate else {
                            print("No location available")
                            return
                           
                        }
                        if !types.isEmpty {
                            self.selectedTodoType = types[0]
                        }
                        let todo = ToDo(name: name, descriptions: description, location: .init(latitude: currentLocation.latitude, longitude: currentLocation.longitude), creationDate: creationDate, status: status, cover: imageData, toDoType: selectedTodoType )
                        context.insert(todo)
                        do {
                            try context.save()
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                        dismiss()
                        
                    }
                    .disabled(!isValid)
                    Spacer()
                }
                .onAppear{
                    locationController.checkIflocationIsEnabled()
            }
            
        }
}


