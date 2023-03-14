//
//  UserDetailView.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 14/03/23.
//

import UIKit
import Combine

class UserDetailView: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var textFieldFirstName: UITextField!
    @IBOutlet private weak var textFieldLastName: UITextField!
    @IBOutlet private weak var textFieldCompanyName: UITextField!
    @IBOutlet private weak var textFieldAddress: UITextField!
    @IBOutlet private weak var textFieldCity: UITextField!
    @IBOutlet private weak var textFieldCountry: UITextField!
    @IBOutlet private weak var textFieldState: UITextField!
    @IBOutlet private weak var textFieldZip: UITextField!
    @IBOutlet private weak var textFieldPhone1: UITextField!
    @IBOutlet private weak var textFieldPhone: UITextField!
    @IBOutlet private weak var textFieldEmail: UITextField!
    @IBOutlet private weak var buttonSave: UIButton!

    // MARK: - Properties
    private var viewModel: UserDetailViewModel = UserDetailViewModel()
    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: UserDetailViewModel) {
        super.init(nibName: "UserDetailView", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "User detail"
        super.viewDidLoad()
        self.configureView()
    }

    // MARK: - configureView
    func configureView() {
        self.configureBindings()
    }

    // MARK: - Configure Bindings
    func configureBindings() {
        viewModel.isSubmitEnabled
            .assign(to: \.isEnabled, on: buttonSave)
            .store(in: &subscriptions)

        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldFirstName.text = user.firstName
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldLastName.text = user.lastName
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldCompanyName.text = user.companyName
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldAddress.text = user.address
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldCity.text = user.city
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldCountry.text = user.country
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldState.text = user.state
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldZip.text = user.zip
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldPhone1.text = user.phone1
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldPhone.text = user.phone
            })
            .store(in: &subscriptions)
        
        viewModel.$selectedUser
            .sink(receiveValue: { [weak self] user in
                self?.textFieldEmail.text = user.email
            })
            .store(in: &subscriptions)
        
        textFieldFirstName.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.firstName = text
            })
            .store(in: &subscriptions)
        
        textFieldLastName.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.lastName = text
            })
            .store(in: &subscriptions)
        
        textFieldCompanyName.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.companyName = text
            })
            .store(in: &subscriptions)
        
        textFieldAddress.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.address = text
            })
            .store(in: &subscriptions)
        
        textFieldCity.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.city = text
            })
            .store(in: &subscriptions)
        
        textFieldCountry.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.country = text
            })
            .store(in: &subscriptions)
        
        textFieldState.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.state = text
            })
            .store(in: &subscriptions)
        
        textFieldZip.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.zip = text
            })
            .store(in: &subscriptions)
        
        textFieldPhone1.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.phone1 = text
            })
            .store(in: &subscriptions)
        
        textFieldPhone.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.phone = text
            })
            .store(in: &subscriptions)
        
        textFieldEmail.textPublisher
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.selectedUser.email = text
            })
            .store(in: &subscriptions)
    }
    
    @IBAction func saveData() {
        if viewModel.users.contains(where: { $0.identifier == self.viewModel.selectedUser.identifier }) {
            self.viewModel.users = viewModel.users.map { $0.identifier == self.viewModel.selectedUser.identifier ? self.viewModel.selectedUser : $0 }
        } else {
            self.viewModel.users.insert(self.viewModel.selectedUser, at: 0)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

