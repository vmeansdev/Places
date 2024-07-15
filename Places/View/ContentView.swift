//
//  ContentView.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import PlacesUI
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: LocationsViewModel
    @State private var isShowingOpenLocationView = false

    init(viewModel: LocationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                        .accessibilityLabel(Constants.loadingLabel)
                case .loaded(let locations):
                    List(locations, id: \.id) { location in
                        VStack(alignment: .leading) {
                            let locationName = location.name ?? Constants.notAvailable
                            Text("\(locationName)")
                                .font(.headline)
                                .accessibilityLabel("\(Constants.locationNameText): \(locationName)")
                            Text("\(location.latitude), \(location.longitude)")
                                .font(.caption)
                                .accessibilityLabel("\(Constants.latitudeText): \(location.latitude), \(Constants.longitudeText): \(location.longitude)")
                        }.onTapGesture {
                            viewModel.openWiki(location: location)
                        }
                        .accessibilityAction {
                            viewModel.openWiki(location: location)
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityHint(Constants.locationHintText)
                    }
                case .error(let message):
                    ErrorView(errorMessage: message, actionButtonText: Constants.retryText) {
                        viewModel.loadLocations()
                    }
                    .accessibilityLabel("\(Constants.errorLabel): \(message)")
                    .accessibilityHint(Constants.errorHint)
                }
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar(content: {
                Button(action: {
                    isShowingOpenLocationView.toggle()
                }) {
                    Image(systemName: Constants.openButtonImageName)
                }
                .accessibilityLabel(Constants.openLocationLabel)
                .accessibilityHint(Constants.openLocationHint)
            })
            .sheet(isPresented: $isShowingOpenLocationView) {
                OpenLocationView { location in
                    viewModel.openWiki(location: location)
                }
                .accessibilityLabel(Constants.openNewLocationLabel)
            }
            .onAppear {
                viewModel.loadLocations()
            }.onDisappear {
                viewModel.cancelLoading()
            }
        }
    }

    private enum Constants {
        static let notAvailable = "N/A"
        static let navigationTitle = "Places"
        static let openButtonImageName = "plus.magnifyingglass"
        static let retryText = "Retry"
        static let loadingLabel = "Loading"
        static let locationNameText = "Location name"
        static let latitudeText = "Latitude"
        static let longitudeText = "Longitude"
        static let locationHintText = "Tap to open a location in Wikipedia app"
        static let errorLabel = "Error"
        static let errorHint = "Tap to retry loading locations"
        static let openLocationLabel = "Open location"
        static let openLocationHint = "Tap to open a new location"
        static let openNewLocationLabel = "Open a new location view"
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
