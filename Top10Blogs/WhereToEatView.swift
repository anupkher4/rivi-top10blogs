import UIKit

class WhereToEatView: UIView {

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

    private func setupLocationLabels(details: FoodCardDetails) {
        if details.location.count == 1 {
            let location = details.location[0].name
            let label = getNewLabel()
            labelStack.addArrangedSubview(label)
            if let distance = details.location[0].distance {
                label.text = "\(location) (\(distance)Km from City Centre)"
            } else {
                label.text = "\(location)"
            }
        } else if details.location.count > 1 {
            for (number, location) in details.location.enumerated() {
                let label = getNewLabel()
                labelStack.addArrangedSubview(label)
                if let distance = location.distance {
                    label.text = "\(number + 1). \(location.name) (\(distance)Km from City Centre)"
                } else {
                    label.text = "\(number + 1). \(location.name)"
                }
            }
        }
    }

    private func bindData(details: FoodCardDetails) {
        if !details.location.isEmpty {
            titleLabel.text = "WHERE TO EAT"
            setupLocationLabels(details: details)
        } else {
            titleLabel.text = nil
        }
    }

}
