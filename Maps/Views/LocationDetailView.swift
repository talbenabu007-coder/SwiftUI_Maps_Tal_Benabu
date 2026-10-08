//
//  LocationDetailView.swift
//  Maps
//
//  Created by Tal Benabu on 04/10/2026.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @Environment(\.colorScheme) var colorScheme
    let location:Location
    
    var body: some View {
     
        ScrollView {
            VStack {
                imageSeection
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    VStack(spacing: 0) {
                        Divider()
                        
                        mapLayer
                            .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 700 : 500)
                        
                            
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.gray.opacity(0.3), lineWidth: 3)
                            }
                        
                            .padding(UIDevice.current.userInterfaceIdiom == .phone ? 16 : 20)
                        
                        
                    }
                }
                }
            }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

extension LocationDetailView {
    private var imageSeection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(location.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(location.cityName)
                    .font(.title3)
                    .foregroundStyle(.secondary)

            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
        .padding(.horizontal)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding()
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .background(.thinMaterial)
                .clipShape(Circle())
                .shadow(radius: 1)
                .padding()
            
        }
    }
    
    
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}
