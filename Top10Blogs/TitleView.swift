import UIKit

class TitleView: UIView {

    private var viewModel: TitleViewModel?

    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .blue
        label.text = viewModel?.heading
        label.numberOfLines = 0
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = viewModel?.title
        label.numberOfLines = 0
        return label
    }()

    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headingLabel, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        return stackView
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
        addSubview(titleStack)
    }

    private func setupConstraints() {
        titleStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
