import XCTest
@testable import Top10Blogs

class Top10BlogsTests: XCTestCase {

    func testFoodCard() {
        let service = loadAndDecodeJson()
        let card = service?.data.cards.first

        XCTAssertEqual(card?.title, "Bombas")
        XCTAssertEqual(card?.cardNumber, 1)
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
