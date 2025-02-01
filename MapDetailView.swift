//
//  MapDetailView.swift
//  OpgaveToDoing
//
//  Created by dmu mac 33 on 07/05/2024.
//

import SwiftUI
import MapKit


struct MapDetailView: View {
    
    var todo: ToDo
    @State private var cameraPosition = MapCameraPosition.automatic
    var body: some View {
        
        
        Map(position: $cameraPosition) {
            Marker("", systemImage: "mappin.circle.fill", coordinate: CLLocationCoordinate2D(latitude: todo.location.latitude, longitude: todo.location.longitude))
            UserAnnotation()
        }
        .onAppear {
            cameraPosition = .region(MKCoordinateRegion(center: .init(latitude: todo.location.latitude, longitude: todo.location.longitude), span: .init(latitudeDelta: 0.02, longitudeDelta: 0.02)))
        }
            

    }
}

