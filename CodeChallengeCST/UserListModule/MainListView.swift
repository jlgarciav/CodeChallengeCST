//
//  MainListView.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 13/03/23.
//

import UIKit
import Combine

class MainListView: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.masksToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Properties
    private var viewModel: MainListViewModel = MainListViewModel()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - addSubViews
    func addSubViews() {
        self.contentView.addSubview(self.tableView)
    }

    // MARK: - setupConstraints
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Users"
        self.addSubViews()
        self.setupConstraints()
        viewModel.$users
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] users in
                self?.tableView.reloadData()
            })
        .store(in: &subscriptions)
    }
    
    @IBAction func addNewUser() {
        let viewModel = UserDetailViewModel()
        viewModel.users = self.viewModel.users
        viewModel.$users
            .sink(receiveValue: { [weak self] users in
                self?.viewModel.users = users
            })
            .store(in: &subscriptions)

        let vc = UserDetailView(viewModel: viewModel)
        self.navigationController?.pushViewController( vc, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension MainListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDataSource
extension MainListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.setupCell(user: viewModel.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = UserDetailViewModel()
        viewModel.users = self.viewModel.users
        viewModel.selectedUser = self.viewModel.users[indexPath.row]
        viewModel.$users
            .sink(receiveValue: { [weak self] users in
                self?.viewModel.users = users
            })
            .store(in: &subscriptions)

        let vc = UserDetailView(viewModel: viewModel)
        self.navigationController?.pushViewController( vc, animated: true)
    }
}
