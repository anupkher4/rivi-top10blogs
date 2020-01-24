import UIKit

class BlogDetailsViewController: UIViewController {

    private let viewModel: BlogDetailsViewModel

    private lazy var headerView: UIView = {
        let view = BlogDetailsHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleView: UIView = {
        let view = TitleView(viewModel: viewModel.titleViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = 30
        tableView.sectionFooterHeight = 30
        return tableView
    }()

    init(viewModel: BlogDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(BlogDetailsTableViewCell.self, forCellReuseIdentifier: BlogDetailsTableViewCell.reuseIdentifier)
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(headerView)
        view.addSubview(titleView)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        headerView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        titleView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        titleView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true

        tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.bottomAnchor, multiplier: 1).isActive = true
    }
}

extension BlogDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.foodCardSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.foodCardSections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogDetailsTableViewCell.reuseIdentifier, for: indexPath) as? BlogDetailsTableViewCell else {
            fatalError("Expected \(BlogDetailsTableViewCell.self) type for resuseIdentifier \(BlogDetailsTableViewCell.reuseIdentifier)")
        }

        let foodCard = viewModel.foodCardSections[indexPath.section][indexPath.row]
        let cellViewModel = BlogDetailsCardViewModelImpl(foodCard: foodCard)
        cell.viewModel = cellViewModel

        return cell
    }
}

extension BlogDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
