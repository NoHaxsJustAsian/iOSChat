//
//  ViewChatViewController.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewChatViewController: UIViewController {
    var delegate:ViewController!
    let viewChatView = ViewChatView()
    let userSelf: User! // should be getting passed in from the previous page
    let userOther: User!
    var userIds = [String]()
    var chatID: String!
    var chatList = [Message]()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = viewChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "" //User Other's Name
        viewChatView.buttonSend.addTarget(self, action: #selector(onButtonSendTapped), for: .touchUpInside)
        
        getAllChats()
        
        //set userSelf
        //set userOther
        //var chat = // auth.findChat([user1 user2].sort)
        //load entire fucking table
        //        let indexPath = IndexPath(row: chatList.count - 1, section: 0)
        //        viewChatView.tableViewChat.scrollToRow(at: indexPath, at: .none, animated: false)
        
        
    }
    
    @objc func onButtonSendTapped(){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        if let textSend = viewChatView.messageField.text {
            var newMessage = Message(name: userSelf.name, text: textSend, date: formattedDate)
            database.collection("chats")
            
            //add data to database
            //send request to refresh data and reload table or call getAllChats
        }
    }
    
    func getAllChats() -> String {
        userIds.append(self.userSelf.id!)
        userIds.append(self.userOther.id!)
        userIds = userIds.sorted()
        
    }
}

extension ViewChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chat", for: indexPath) as! ChatTableViewCell
        cell.labelText.text = chatList[indexPath.row].text
        cell.labelName.text = chatList[indexPath.row].name
        cell.labelTime.text = chatList[indexPath.row].date
        if chatList[indexPath.row].name == userSelf.name {
            cell.backgroundColor = UIColor.blue
            cell.labelText.textAlignment = .right
            cell.labelName.textAlignment = .right
            cell.labelTime.textAlignment = .right
        }
        else{
            cell.backgroundColor = UIColor.gray
            cell.labelText.textAlignment = .left
            cell.labelName.textAlignment = .left
            cell.labelTime.textAlignment = .left
        }
        return cell
    }
}

