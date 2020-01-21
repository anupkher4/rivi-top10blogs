
import UIKit

class DashboardViewController: UIViewController {

    private let viewModel: DashboardViewModel

    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10.0
        return view
    }()

//    private lazy var contentStack: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.clipsToBounds = true
//        return stack
//    }()

    private lazy var titleView: UIView = {
        let view = TitleView(viewModel: viewModel.titleViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SF Pro Text", size: 30.0)
        label.textColor = .gray
        label.text = "SEE MORE"
        return label
    }()

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: "DashboardTableViewCell")
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        containerView.addSubview(titleView)
        view.addSubview(containerView)
    }

    private func setupConstraints() {
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100.0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400.0).isActive = true
        containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100.0).isActive = true

        titleView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        titleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0).isActive = true
    }

}

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.foodCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as? DashboardTableViewCell else {
            return UITableViewCell()
        }

        let foodCard = viewModel.foodCards[indexPath.row]
        cell.viewModel = DashboardBlogCardViewModelImpl(foodCard: foodCard)

        return cell
    }
}

extension DashboardViewController: UITableViewDelegate {

}
