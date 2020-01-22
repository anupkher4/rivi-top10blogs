import UIKit

class BlogDetailsHeaderView: UIView {

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "downChevron"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(chevronImageView)
    }

    private func setupConstraints() {
        chevronImageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        chevronImageView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        chevronImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
