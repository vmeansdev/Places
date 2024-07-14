//
//  ContentView.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: LocationsViewModel

    init(viewModel: LocationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let locations):
                List(locations, id: \.id) { location in
                    VStack(alignment: .leading) {
                        Text("\(location.name ?? Constants.notAvailable)")
                            .font(.headline)
                        Text("\(location.latitude), \(location.longitude)")
                            .font(.caption)
                    }.onTapGesture {
                        viewModel.openWiki(location: location)
                    }
                }
            case .error(let message):
                Text(message)
            }
        }.onAppear {
            viewModel.loadLocations()
        }.onDisappear {
            viewModel.cancelLoading()
        }
    }

    private enum Constants {
        static let notAvailable = "N/A"
    }
}

#Preview {
    let dependenciesProvider = DependenciesProvider()
    let viewModel = LocationsViewModel(locationsService: dependenciesProvider.makeLocationsService(), deeplinkService: dependenciesProvider.makeDeeplinkService())
    viewModel.state = .loaded([
        .init(name: "Amsterdam", latitude: 1.2345, longitude: 6.789),
        .init(name: "Amsterdam", latitude: 1.2345, longitude: 6.789),
        .init(name: "Amsterdam", latitude: 1.2345, longitude: 6.789),
        .init(name: "Amsterdam", latitude: 1.2345, longitude: 6.789),
        .init(name: "Amsterdam", latitude: 1.2345, longitude: 6.789),
    ])
    return ContentView(viewModel: viewModel)
}
