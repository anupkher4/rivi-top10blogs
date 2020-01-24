import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "ImagesCollectionViewCell"

    var foodImage: String? {
        didSet {
            if let image = foodImage {
                downloadAndSetupImage(imageString: image)
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

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        foodImage = nil
        foodImageView.image = nil
    }

    private func setupViews() {
        contentView.addSubview(foodImageView)
    }

    private func setupConstraints() {
        foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0).isActive = true
        foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }

    private func downloadAndSetupImage(imageString: String) {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: NSString(string: imageString)) {
            DispatchQueue.main.async {
                self.foodImageView.image = cachedImage
            }
        }
        URLSession.shared.dataTask(with: URL(string: imageString)!) { [weak self] (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self?.foodImageView.image = UIImage(imageLiteralResourceName: "placeholder")
                }
                return
            }
            if let data = data, let downloadedImage = UIImage(data: data) {
                imageCache.setObject(downloadedImage, forKey: NSString(string: imageString))
                DispatchQueue.main.async {
                    self?.foodImageView.image = downloadedImage
                }
            }
        }.resume()
    }
}
