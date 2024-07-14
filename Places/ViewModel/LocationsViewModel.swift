//
//  LocationsViewModel.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation

final class LocationsViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case loaded([Location])
        case error(String)
    }

    @Published var state: State = .loading
    private(set) var cancellationToken: Task<Void, Never>?
    private let locationsService: LocationsServiceProtocol
    private let deeplinkService: DeeplinkServiceProtocol

    init(locationsService: LocationsServiceProtocol, deeplinkService: DeeplinkServiceProtocol) {
        self.locationsService = locationsService
        self.deeplinkService = deeplinkService
    }

    func loadLocations() {
        state = .loading
        cancellationToken?.cancel()
        cancellationToken = Task {
            do {
                let locations = try await locationsService.fetchLocations()
                await update(state: .loaded(locations))
            } catch {
                await update(state: .error(error.localizedDescription))
            }
        }
    }

    func cancelLoading() {
        cancellationToken?.cancel()
        cancellationToken = nil
    }

    func openWiki(location: Location) {
        deeplinkService.openWiki(location: location)
    }

    @MainActor
    private func update(state: State) async {
        self.state = state
    }
}
