//
//  LocationsView.swift
//  Maps
//
//  Created by Tal Benabu on 03/10/2026.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm:LocationsViewModel

    var body: some View {
            ZStack {
                
                Map(coordinateRegion: $vm.mapRegion)
                    .ignoresSafeArea(edges: .vertical)
                
                VStack(spacing:10) {
                    header
                        .padding()
                    
                    Spacer()
                }
            }
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button {
                vm.toggleLocationList()
            }label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                   .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                   .frame(height: 55)
                   .frame(maxWidth: .infinity)
                   .animation(.none, value: vm.mapLocation)
                  .overlay(alignment: .leading) {
                      Image(systemName: "arrow.down")
                           .font(.headline)
                           .foregroundStyle(.black)
                          .padding()
                          .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                  }
            }
            if vm.showLocationList {
                LocationListView()
            }
        }
        
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}


    


#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
