# Places App

## Overview

The Places app is a technical assignment for ABN Amro Bank, designed to demonstrate the capability to fetch, display, and interact with location data using the Wikipedia app via deep linking. The app fetches locations from a specified URL, displays them in a list, and allows users to open each location in the Wikipedia app. Additionally, users can manually enter a custom location to open in the Wikipedia app.

## Features

- Fetch locations from a remote JSON endpoint.
- Display locations in a list.
- Open locations in the Wikipedia app via deep linking.
- Manually enter custom locations to open in the Wikipedia app.
- UI is implemented using SwiftUI

## Setup

1. **Clone the Repository:**
   ```sh
   git clone https://github.com/vmeansdev/Places.git
   cd Places
   ```

2. **Open the Project:**
   Open `Places.xcodeproj` in Xcode.

3. **Install Dependencies:**
   Run `swift package resolve` to install dependencies.

4. **Build and Run:**
   Select the target `Places` and run the app.

## Configuration

The app fetches location data from a URL configured in the `Places.xcconfig` file. Ensure the URL is set correctly:

```plaintext
PLACES_URL = https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json
```

## Usage

1. **Fetch and Display Locations:**
   The app will fetch locations from the specified URL and display them in a list.

2. **Open Location in Wikipedia App:**
   Tap on a location to open it in the Wikipedia app using deep linking.

3. **Enter Custom Location:**
   Navigate to the custom location view, enter a name (optional), and coordinates (latitude and longitude), then tap "Open" to view the location in the Wikipedia app.

## Assumptions

- Only the name of a location is optional; coordinates are required.
- Custom locations entered by the user are not stored in the initial list and are opened only upon tapping the "Open" button.

## Possible future Improvements

- App icon
- SwiftLint and SwiftFormat integration
- Localization support
- Enhanced color scheme
- Fonts
- Some sort of AppHttpKit library for networking (for simplicity there is a direct use of URLSession and as it is quite tricky to mock URLSession and no networking library is implemented/used, for testing I mocked URLProtocol which reads and uses bundled JSON files)

## License

This project is licensed under the MIT License.