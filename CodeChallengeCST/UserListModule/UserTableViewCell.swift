//
//  UserTableViewCell.swift
//  CodeChallengeCST
//
//  Created by José Luis García on 13/03/23.
//

import Foundation
import UIKit
import Combine

class UserTableViewCell: UITableViewCell {

    lazy var labelName : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var labelLastName : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var labelPhoneNumber : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static var identifier : String = "UserTableViewCell"
    private var subscriptions = Set<AnyCancellable>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        buildComponents()
        buildComponentsLayout()
        subscriptions = Set<AnyCancellable>()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildComponents() {
        contentView.addSubview(labelName)
        contentView.addSubview(labelLastName)
        contentView.addSubview(labelPhoneNumber)
        contentView.addSubview(separatorView)
    }
    
    func buildComponentsLayout() {
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            labelName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            labelName.trailingAnchor.constraint(equalTo: labelLastName.leadingAnchor, constant: -8),
            labelName.bottomAnchor.constraint(equalTo: self.labelPhoneNumber.topAnchor, constant: -8.0),
           
            labelLastName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            labelLastName.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            labelLastName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            labelLastName.bottomAnchor.constraint(equalTo: self.labelPhoneNumber.topAnchor, constant: -8.0),
            
            labelPhoneNumber.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: 8.0),
            labelPhoneNumber.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            labelPhoneNumber.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1.0),
            separatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setupCell(user: User) {
        self.selectionStyle = .none
        self.labelName.text = "Full name: \(user.firstName)"
        self.labelLastName.text = user.lastName
        self.labelPhoneNumber.text = "Phone number: \(user.phone)"
    }
}
