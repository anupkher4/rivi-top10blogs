import UIKit

class BlogDetailsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "BlogDetailsTableViewCell"

    var viewModel: BlogDetailsCardViewModel? {
        didSet {
            if let vm = viewModel {
                bindData(vm)
            }
        }
    }

    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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

    lazy var detailsContentView: BlogDetailsContentView = {
        let view = BlogDetailsContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "downChevron"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.layer.cornerRadius = 10.0
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        contentView.layer.shadowOpacity = 0.4
//        contentView.layer.shadowRadius = 10.0
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
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(detailsContentView)
    }

    private func setupConstraints() {
        foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        foodImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        foodImageView.bottomAnchor.constraint(equalTo: detailsContentView.topAnchor, constant: -10.0).isActive = true

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: 20.0).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor, constant: 10.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true

        chevronImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50.0).isActive = true
        chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        chevronImageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        chevronImageView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true

        detailsContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        detailsContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        detailsContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }

    private func bindData(_ viewModel: BlogDetailsCardViewModel) {
        downloadMainCardImage(viewModel)
        titleLabel.text = viewModel.blogCard.title
        descriptionLabel.text = viewModel.blogCard.description
        detailsContentView.foodCardDetails = viewModel.blogDetailsCard
    }

    private func downloadMainCardImage(_ viewModel: BlogDetailsCardViewModel) {
        URLSession.shared.dataTask(with: URL(string: viewModel.blogCard.image)!) { [weak self] (data, response, error) in
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
