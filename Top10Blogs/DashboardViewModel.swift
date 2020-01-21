import UIKit

protocol TitleViewModel {
    var heading: String { get }
    var title: String { get }
}

protocol DashboardViewModel {
    var titleViewModel: TitleViewModel { get }
    var foodCards: [FoodCard] { get }
}

protocol DashboardBlogCardViewModel {
    var image: String { get }
    var title: String { get }
    var description: String { get }
}

struct TitleViewModelImpl: TitleViewModel {
    var heading: String = "CURATED FOR MAYANK"
    var title: String

    init(foodSummary: FoodBlogSummary) {
        title = "\(foodSummary.title) \(foodSummary.city)"
    }
}

struct DashboardViewModelImpl: DashboardViewModel {
    let titleViewModel: TitleViewModel
    let foodCards: [FoodCard]

    init(service: FoodBlogService) {
        titleViewModel = TitleViewModelImpl(foodSummary: service.data.summary)
        foodCards = service.data.cards
    }
}

struct DashboardBlogCardViewModelImpl: DashboardBlogCardViewModel {
    let image: String
    let title: String
    let description: String

    init(foodCard: FoodCard) {
        image = foodCard.image
        title = foodCard.title
        description = foodCard.description
    }
}
