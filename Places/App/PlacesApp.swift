//
//  PlacesApp.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import SwiftUI

@main
struct PlacesApp: App {
    @State private var dependenciesProvider = DependenciesProvider()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: dependenciesProvider.makeLocationsViewModel())
        }
    }
}
