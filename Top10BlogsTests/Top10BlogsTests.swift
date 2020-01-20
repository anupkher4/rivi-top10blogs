import XCTest
@testable import Top10Blogs

class Top10BlogsTests: XCTestCase {

    func testFoodBlogService() {
        let service = loadAndDecodeJson()

        let summary = service?.data.summary
        XCTAssertEqual(summary?.title, "4 Must Try Local Foods in")
        XCTAssertEqual(summary?.city, "Barcelona")

        let cards = service?.data.cards
        XCTAssertEqual(cards?.count, 4)
    }

    func testFoodCard() {
        let service = loadAndDecodeJson()

        let card = service?.data.cards.first
        XCTAssertEqual(card?.title, "Bombas")
        XCTAssertEqual(card?.description, "Catalan Fried Potato")
        XCTAssertEqual(card?.cardNumber, 1)
    }

    func testFoodCardDetailsDistanceIsNotNil() {
        let service = loadAndDecodeJson()

        let card = service?.data.cards.last
        let details = card?.details
        let distance = details?.location.first?.distance
        XCTAssertEqual(distance, 0.2)
    }

    func testFoodCardDetailsDistanceIsNil() {
        let service = loadAndDecodeJson()

        let card = service?.data.cards[1]
        let details = card?.details
        let distance = details?.location.first?.distance
        XCTAssertNil(distance)
    }

    private func loadAndDecodeJson() -> FoodBlogService? {
        guard let path = Bundle.main.path(forResource: "RiviServerData", ofType: "json") else {
            print("File not found")
            return nil
        }
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            print("String parsing failed")
            return nil
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Could not create data from json string")
            return nil
        }
        let decoder = JSONDecoder()
        guard let service = try? decoder.decode(FoodBlogService.self, from: jsonData) else {
            print("Could not decode json data")
            return nil
        }
        return service
    }
}
