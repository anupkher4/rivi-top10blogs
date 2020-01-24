import UIKit

class DishesView: UIView {

    var foodCardDetails: FoodCardDetails? {
        didSet {
            if let details = foodCardDetails {
                bindData(details: details)
            } else {
                labelStack.subviews.forEach { $0.removeFromSuperview() }
            }
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 0
        return label
    }()

    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(labelStack)
    }

    private func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true

        labelStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        labelStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        labelStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func getNewLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }

    private func setupDishLabels(details: FoodCardDetails) {
        if details.dishes.count == 1 {
            let label = getNewLabel()
            labelStack.addArrangedSubview(label)
            label.text = details.dishes[0]
        } else {
            for (number, dish) in details.dishes.enumerated() {
                let label = getNewLabel()
                labelStack.addArrangedSubview(label)
                label.text = "\(number + 1). \(dish)"
            }
        }
    }

    private func bindData(details: FoodCardDetails) {
        if !details.dishes.isEmpty {
            titleLabel.text = "BEST DISHES"
            setupDishLabels(details: details)
        } else {
            titleLabel.text = nil
        }
    }

}
