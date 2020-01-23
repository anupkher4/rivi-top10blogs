import UIKit

class BlogDetailsContentView: UIView {

    var foodCardDetails: FoodCardDetails? {
        didSet {
            if let details = foodCardDetails {
                bindData(details: details)
            }
        }
    }

    lazy var aboutView: AboutView = {
        let view = AboutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    }

    private func setupConstraints() {
        aboutView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        aboutView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        aboutView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        aboutView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func bindData(details: FoodCardDetails) {
        aboutView.foodCardDetails = details
    }
}
