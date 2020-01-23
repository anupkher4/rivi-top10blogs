import Foundation
import UIKit

class DashboardTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DashboardTableViewCell"

    var viewModel: DashboardBlogCardViewModel? {
        didSet {
            if let vm = viewModel {
                bindData(vm)
            }
        }
    }

    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        return stackView
    }()

    lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodImageView, labelStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.distribution = .fillProportionally
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
        foodImageView.image = nil
    }

    private func setupViews() {
        contentView.addSubview(contentStack)
    }

    private func setupConstraints() {
        contentStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        foodImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    }

    private func bindData(_ viewModel: DashboardBlogCardViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        downloadMainCardImage(viewModel)
    }

    private func downloadMainCardImage(_ viewModel: DashboardBlogCardViewModel) {
        URLSession.shared.dataTask(with: URL(string: viewModel.image)!) { [weak self] (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self?.foodImageView.image = UIImage(imageLiteralResourceName: "placeholder")
                }
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.foodImageView.image = image
                }
            }
        }.resume()
    }
}
