import UIKit

class DashboardTableViewCell: UITableViewCell {

    var viewModel: DashboardBlogCardViewModel? {
        didSet {
            if let vm = viewModel {
                bindData(vm)
            }
        }
    }

    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 50.0)
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 30.0)
        label.textColor = .gray
        return label
    }()

    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 20.0
        return stackView
    }()

    lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodImageView, labelStack])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20.0, left: 40.0, bottom: 20.0, right: 40.0)
        stackView.axis = .horizontal
        stackView.spacing = 40.0
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        viewModel = nil
    }

    private func setupViews() {
        contentView.addSubview(contentStack)
    }

    private func setupConstraints() {
        foodImageView.heightAnchor.constraint(equalToConstant: 143.0).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 143.0).isActive = true
    }

    private func bindData(_ viewModel: DashboardBlogCardViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }

}
