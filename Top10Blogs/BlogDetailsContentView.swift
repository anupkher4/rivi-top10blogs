import UIKit

class BlogDetailsContentView: UIView {

    var foodCardDetails: FoodCardDetails? {
        didSet {
            if let details = foodCardDetails {
                bindData(details: details)
            } else {
                aboutView.foodCardDetails = nil
                whereToEatView.foodCardDetails = nil
                dishesView.foodCardDetails = nil
                photosView.foodCardDetails = nil
            }
        }
    }

    lazy var aboutView: AboutView = {
        let view = AboutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var whereToEatView: WhereToEatView = {
        let view = WhereToEatView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var dishesView: DishesView = {
        let view = DishesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var photosView: PhotosView = {
        let view = PhotosView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .gray
        label.text = "READ MORE"
        return label
    }()

    init() {
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(aboutView)
        addSubview(whereToEatView)
        addSubview(dishesView)
        addSubview(photosView)
        addSubview(footerLabel)
    }

    private func setupConstraints() {
        aboutView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        aboutView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        aboutView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        whereToEatView.topAnchor.constraint(equalTo: aboutView.bottomAnchor, constant: 5.0).isActive = true
        whereToEatView.leadingAnchor.constraint(equalTo: aboutView.leadingAnchor).isActive = true
        whereToEatView.trailingAnchor.constraint(equalTo: aboutView.trailingAnchor).isActive = true

        dishesView.topAnchor.constraint(equalTo: whereToEatView.bottomAnchor, constant: 5.0).isActive = true
        dishesView.leadingAnchor.constraint(equalTo: whereToEatView.leadingAnchor).isActive = true
        dishesView.trailingAnchor.constraint(equalTo: whereToEatView.trailingAnchor).isActive = true

        photosView.topAnchor.constraint(equalTo: dishesView.bottomAnchor, constant: 5.0).isActive = true
        photosView.leadingAnchor.constraint(equalTo: dishesView.leadingAnchor).isActive = true
        photosView.trailingAnchor.constraint(equalTo: dishesView.trailingAnchor).isActive = true

        footerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        footerLabel.topAnchor.constraint(equalTo: photosView.bottomAnchor).isActive = true
        footerLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func bindData(details: FoodCardDetails) {
        aboutView.foodCardDetails = details
        whereToEatView.foodCardDetails = details
        dishesView.foodCardDetails = details
        photosView.foodCardDetails = details
    }
}
