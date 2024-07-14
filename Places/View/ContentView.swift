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
    @State private var isShowingAddLocationView = false

    init(viewModel: LocationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    LoadingView()
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
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar(content: {
                Button(action: {
                    isShowingAddLocationView.toggle()
                }) {
                    Image(systemName: Constants.addButtonImageName)
                }
            })
            .sheet(isPresented: $isShowingAddLocationView) {
                OpenLocationView { location in
                    viewModel.openWiki(location: location)
                }
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
        static let addButtonImageName = "plus.magnifyingglass"
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
