import UIKit

class PhotosView: UIView {

    var foodCardDetails: FoodCardDetails? {
        didSet {
            if let details = foodCardDetails {
                bindData(details: details)
            } else {
                imageStack.subviews.forEach { $0.removeFromSuperview() }
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

    private lazy var imageStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
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
        addSubview(imageStack)
    }

    private func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true

        imageStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        imageStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        imageStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        imageStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageStack.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
    }

    private func getNewImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        return imageView
    }

    private func setupImages(details: FoodCardDetails) {
        for image in details.images {
            URLSession.shared.dataTask(with: URL(string: image)!) { [weak self] (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        if let imageView = self?.getNewImageView() {
                            imageView.image = UIImage(imageLiteralResourceName: "placeholder")
                            self?.imageStack.addArrangedSubview(imageView)
                        }
                    }
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let imageView = self?.getNewImageView() {
                            imageView.image = image
                            self?.imageStack.addArrangedSubview(imageView)
                        }
                    }
                }
            }.resume()
        }
    }

    private func bindData(details: FoodCardDetails) {
        if !details.images.isEmpty {
            titleLabel.text = "PHOTOS"
            setupImages(details: details)
        } else {
            titleLabel.text = nil
        }
    }

}
