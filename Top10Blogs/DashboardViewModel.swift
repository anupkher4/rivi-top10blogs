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

protocol BlogDetailsViewModel {
    var titleViewModel: TitleViewModel { get }
    var foodImageStrings: [String] { get }
    var foodCardSections: [[FoodCard]] { get }
    var selectedFoodCard: FoodCard { get }
}

protocol BlogDetailsCardViewModel {
    var blogCard: DashboardBlogCardViewModel { get }
    var blogDetailsCard: FoodCardDetails { get }
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

struct BlogDetailsViewModelImpl: BlogDetailsViewModel {
    let titleViewModel: TitleViewModel
    let foodImageStrings: [String]
    let foodCardSections: [[FoodCard]]
    let selectedFoodCard: FoodCard

    init(service: FoodBlogService, selectedFoodCard: FoodCard) {
        titleViewModel = TitleViewModelImpl(foodSummary: service.data.summary)
        foodImageStrings = service.data.cards.map { $0.image }
        foodCardSections = service.data.cards.map({ (foodCard) -> [FoodCard] in
            var card: [FoodCard] = []
            card.append(foodCard)
            return card
        })
        self.selectedFoodCard = selectedFoodCard
    }
}

struct BlogDetailsCardViewModelImpl: BlogDetailsCardViewModel {
    let blogCard: DashboardBlogCardViewModel
    let blogDetailsCard: FoodCardDetails

    init(foodCard: FoodCard) {
        blogCard = DashboardBlogCardViewModelImpl(foodCard: foodCard)
        blogDetailsCard = foodCard.details
    }
}
