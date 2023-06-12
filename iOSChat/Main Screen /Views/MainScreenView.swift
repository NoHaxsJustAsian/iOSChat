//
//  MainScreenView.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import UIKit

class MainScreenView: UIView {
    var labelText: UILabel!
    var floatingButtonAddContact: UIButton!
    var tableViewContacts: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelText()
        setupTableViewContacts()
        initConstraints()
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewContacts(){
        tableViewContacts = UITableView()
        tableViewContacts.register(ContactsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewContacts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContacts)
    }
    

    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([

            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            
            tableViewContacts.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewContacts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
