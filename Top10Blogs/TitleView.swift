import UIKit

class TitleView: UIView {

    private var viewModel: TitleViewModel?

    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .blue
        label.text = viewModel?.heading
        label.numberOfLines = 0
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = viewModel?.title
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: TitleViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)

        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(headingLabel)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        headingLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 15.0).isActive = true
        headingLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15.0).isActive = true
        headingLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 15.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15.0).isActive = true
        titleLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: headingLabel.lastBaselineAnchor, multiplier: 1).isActive = true
        layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: titleLabel.lastBaselineAnchor, multiplier: 1).isActive = true
    }

}
