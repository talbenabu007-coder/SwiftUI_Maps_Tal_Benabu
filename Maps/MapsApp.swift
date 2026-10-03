//
//  MapsApp.swift
//  Maps
//
//  Created by Tal Benabu on 03/10/2026.
//

import SwiftUI

@main
struct MapsApp: App {
    @StateObject private var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
