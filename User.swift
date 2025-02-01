//
//  User.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 07/05/2024.
//
import SwiftUI
import SwiftData
import PhotosUI

struct UserView: View {
    @AppStorage("name") private var name: String = ""
    @AppStorage("avatar") private var avatar: Data?

    @State private var userName = ""
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
    

    var body: some View {
        VStack {
            profileImage
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, selectionBehavior: .continuousAndOrdered, matching: .images, photoLibrary: .shared()) {
                Label("Select an Image", systemImage: "photo.badge.plus")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .shadow(radius: 5)
        .onChange(of: selectedItems) { oldValues, newValues in
            if let item = newValues.first {
                Task {
                    if let imageData = try? await item.loadTransferable(type: Data.self) {
                        selectedItemData = imageData
                        avatar = imageData
                    }
                }
            }
        }
        .onAppear() {
            selectedItemData = avatar
        }
    }
}
