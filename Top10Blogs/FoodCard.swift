import Foundation

struct FoodBlogService: Decodable {
    let data: FoodBlogData

    private enum CodingKeys: String, CodingKey {
        case data
    }
}

struct FoodBlogData: Decodable {
    let summary: FoodBlogSummary
    let cards: [FoodCard]

    private enum CodingKeys: String, CodingKey {
        case summary = "card_details"
        case cards = "card"
    }
}

struct FoodBlogSummary: Decodable {
    let title: String
    let city: String
}

struct FoodCard: Decodable {
    let title: String
    let description: String
    let image: String
    let cardNumber: Int
    let details: FoodCardDetails

    private enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case image = "img"
        case cardNumber = "card_no"
        case details
    }
}

struct FoodCardDetails: Decodable {
    let about: [String]
    let location: [FoodCardLocation]
    let dishes: [String]
    let images: [String]

    private enum CodingKeys: String, CodingKey {
        case about
        case location = "where"
        case dishes
        case images
    }
}

struct FoodCardLocation: Decodable {
    let name: String
    let distance: Double?
}
