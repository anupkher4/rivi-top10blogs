import UIKit

class AboutView: UIView {

    var foodCardDetails: FoodCardDetails? {
        didSet {
            if let details = foodCardDetails {
                bindData(details: details)
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

    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
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
        addSubview(aboutLabel)
    }

    private func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true

        aboutLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        aboutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        aboutLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        layoutMarginsGuide.bottomAnchor.constraint(equalTo: aboutLabel.bottomAnchor).isActive = true
    }

    private func bindData(details: FoodCardDetails) {
        if !details.about.joined().isEmpty {
            titleLabel.text = "ABOUT"
            aboutLabel.text = details.about.joined()
        }
    }
}
