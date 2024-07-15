import XCTest
@testable import PlistReader

class PlistReaderTests: XCTestCase {
    func testValueForKeyWithExistingKey() {
        let bundle = MockBundle(infoDictionary: ["TestKey": "TestValue"])
        let plistReader = PlistReader(bundle: bundle)

        do {
            let value: String = try plistReader.value(for: "TestKey")
            XCTAssertEqual(value, "TestValue")
        } catch {
            XCTFail("Expected to retrieve the value successfully, but got an error: \(error)")
        }
    }

    func testValueForKeyWithMissingKey() {
        let bundle = MockBundle(infoDictionary: [:])
        let plistReader = PlistReader(bundle: bundle)

        XCTAssertThrowsError(try plistReader.value(for: "MissingKey") as String) { error in
            XCTAssertEqual(error as? PlistReader.Error, .missingKey)
        }
    }

    func testValueForKeyWithInvalidValue() {
        let bundle = MockBundle(infoDictionary: ["TestKey": 12345])
        let plistReader = PlistReader(bundle: bundle)

        XCTAssertThrowsError(try plistReader.value(for: "TestKey") as String) { error in
            XCTAssertEqual(error as? PlistReader.Error, .invalidValue)
        }
    }

    func testValueForKeyWithConvertibleString() {
        let bundle = MockBundle(infoDictionary: ["TestKey": "12345"])
        let plistReader = PlistReader(bundle: bundle)

        do {
            let value: Int = try plistReader.value(for: "TestKey")
            XCTAssertEqual(value, 12345)
        } catch {
            XCTFail("Expected to retrieve the value successfully, but got an error: \(error)")
        }
    }
}
