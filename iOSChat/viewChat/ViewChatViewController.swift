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
        title = userOther.name
        viewChatView.buttonSend.addTarget(self, action: #selector(onButtonSendTapped), for: .touchUpInside)
        users.append(self.userSelf.name)
        users.append(self.userOther.name)
        sortedUsers = users.sorted{$0 < $1}
        getChatID { (chatID) in
            if let chatID = chatID {
                self.chatID = chatID
                self.getAllChats(self.chatID)
            }
        }
        viewChatView.tableViewChat.delegate = self
        viewChatView.tableViewChat.dataSource = self
    }
    
    @objc func onButtonSendTapped() {
        guard let chatID = self.chatID,
              let text = self.viewChatView.messageField.text,
              text.count > 0 else {
            print("Message field is empty.")
            return
        }

        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)

        let newMessage = Message(name: userSelf.name, text: text, date: formattedDate)
        
        do {
            let encodedMessage = try Firestore.Encoder().encode(newMessage)
            
            let chatRef = self.database.collection("chats").document(chatID)
            chatRef.updateData([
                "messages": FieldValue.arrayUnion([encodedMessage])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    self.viewChatView.messageField.text = "" // clear the text field
                    self.getAllChats(self.chatID) // fetch all messages
                }
            }
        } catch let error {
            print("Error encoding message: \(error)")
        }
    }
    
    func getChatID(completion: @escaping (String?) -> Void) {
        self.database.collection("chats").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
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
                completion(self.chatID)
            }
        }
    }

    func getAllChats(_ chatID: String) {
        let messagesRef = self.database.collection("chats").document(chatID)
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
            DispatchQueue.main.async {
                self.viewChatView.tableViewChat.reloadData()
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
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        if chatList[indexPath.row].name == userSelf.name {
            cell.wrapperCellView.backgroundColor = UIColor.blue
            cell.labelText.textAlignment = .right
            cell.labelName.textAlignment = .right
            cell.labelTime.textAlignment = .right
            cell.labelText.textColor = UIColor.white
            cell.labelName.textColor = UIColor.white
            cell.labelTime.textColor = UIColor.white
        }
        else{
            cell.wrapperCellView.backgroundColor = UIColor.gray
            cell.labelText.textAlignment = .left
            cell.labelName.textAlignment = .left
            cell.labelTime.textAlignment = .left
            cell.labelText.textColor = UIColor.black
            cell.labelName.textColor = UIColor.black
            cell.labelTime.textColor = UIColor.black
        }
        return cell
    }
}
        
