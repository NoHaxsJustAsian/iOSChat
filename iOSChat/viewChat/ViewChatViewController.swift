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
    var userSelf: User! // should be getting passed in from the previous page
    var userOther: User!
    var users = [String]()
    var chatID: String!
    var chatList = [Message]()
    var sortedUsers: [String]!
    let database = Firestore.firestore()
    
    override func loadView() {
        view = viewChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "" //User Other's Name
        
        viewChatView.buttonSend.addTarget(self, action: #selector(onButtonSendTapped), for: .touchUpInside)
        users.append(self.userSelf.name)
        users.append(self.userOther.name)
        sortedUsers = users.sorted{$0 < $1}
        getChatID()
        getAllChats()
        
        //load entire fucking table
        //let indexPath = IndexPath(row: chatList.count - 1, section: 0)
        //viewChatView.tableViewChat.scrollToRow(at: indexPath, at: .none, animated: false)

        
    }
    
    @objc func onButtonSendTapped(){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        if let textSend = viewChatView.messageField.text {
            var newMessage = Message(name: userSelf.name, text: textSend, date: formattedDate)
            let chatRef = database.collection("chats").document(self.chatID)
            chatRef.updateData([
                "messages": FieldValue.arrayUnion([newMessage])
            ])
            getAllChats()
        }
    }
    
    func getAllChats(){
        var messagesRef = self.database.collection("chats").document(self.chatID)
                messagesRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let dbMessages = document.get("messages") as? [[String: Any]] {
                            var fetchedMessages: [Message] = []
                            for dbMessage in dbMessages {
                                do {
                                    let data = try JSONSerialization.data(withJSONObject: dbMessage, options: [])
                                    let message = try JSONDecoder().decode(Message.self, from: data)
                                    fetchedMessages.append(message)
                                } catch {
                                    print("Error decoding message: \(error)")
                                }
                            }
                            // Update your local list with the fetched messages
                            self.chatList = fetchedMessages
                            print("Fetched Messages: \(self.chatList)")
                        } else {
                            print("No messages found")
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
        viewChatView.tableViewChat.reloadData()
    }
    
    
    func getChatID(){
            self.database.collection("chats").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        if (document.data()["userids"] as? [String] == self.sortedUsers) {
                            self.chatID = document.documentID
                        }
                    }
                    if (self.chatID == nil) {
                        let newChatRef = self.database.collection("chats").addDocument(data: [
                            "userids": self.sortedUsers,
                            "messages": [String]()
                        ]) { error in
                            if let error = error {
                                print("Error adding document: \(error)")
                            }
                        }
                        self.chatID = newChatRef.documentID
                        print("chatID =", self.chatID)
                        print("chatRef =", newChatRef.documentID)
                    }
                }
            }
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
        
