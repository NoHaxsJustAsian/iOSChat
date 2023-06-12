//
//  ViewChatView.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import UIKit

class ViewChatView: UIView {

    var contentWrapper:UIScrollView!
    var tableViewChat: UITableView!
    var bottomAddView:UIView!
    var messageField: UITextField!
    var buttonSend:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupContentWrapper()
        setupBottomAddView()
        setupTableViewChat()
        setupMessageField()
        setupButtonSend()
        initConstraints()
    }

    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupTableViewChat(){
        tableViewChat = UITableView()
        tableViewChat.register(ChatTableViewCell.self, forCellReuseIdentifier: "chat")
        tableViewChat.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(tableViewChat)
    }
    
    func setupBottomAddView(){
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.7
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupMessageField(){
        messageField = UITextField()
        messageField.placeholder = "Message"
        messageField.borderStyle = .roundedRect
        messageField.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(messageField)
    }
    
    func setupButtonSend(){
        buttonSend = UIButton(type: .system)
        buttonSend.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSend.setTitle("Send", for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(buttonSend)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            buttonSend.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
            buttonSend.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
            buttonSend.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
            
            messageField.bottomAnchor.constraint(equalTo: buttonSend.bottomAnchor, constant: -8),
            messageField.leadingAnchor.constraint(equalTo: buttonSend.leadingAnchor),
            messageField.trailingAnchor.constraint(equalTo: buttonSend.trailingAnchor),
            
            bottomAddView.topAnchor.constraint(equalTo: buttonSend.topAnchor, constant: -8),
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, constant: -50),
            
            tableViewChat.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewChat.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewChat.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewChat.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor),
        ])
}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
