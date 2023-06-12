//
//  ViewChatViewController.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import UIKit
import FirebaseAuth

class ViewChatViewController: UIViewController {
    var delegate:ViewController!
    let viewChatView = ViewChatView()
    var userSelf: User! // should be getting passed in from the previous page
    var userOther: User!
    var chatID: String!
    var chatList = [Message]()
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
        //set colorChat for Self
        //set colorChat for Other (note these two could be included in getAllChats
        //load entire fucking table
        //SCROLL TO BOTTOM USING THIS THING BELOW.
        tableV_Chat.ScrollToRow(
                NSIndexPath.FromRowSection(Messages.Length - 1, 0),
                UITableViewScrollPosition.None,
                false);
        
    }
    
    @objc func onButtonSendTapped(){
        var currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        if let textSend = viewChatView.messageField.text {
            var newMessage = Message(name: userSelf.name, text: textSend, date: formattedDate)
            //add data to database
            //send request to refresh data and reload table or call getAllChats
        }
    }
    
    func getAllChats(){
        //use users to search firebase storage for chat id, and respective chat info and populate table.
        //call method when message is sent or recieved.
    }
}

    extension ViewChatViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return chatList.count //this has to be changed to chat messages count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "names", for: indexPath) as! ChatTableViewCell
            cell.labelText.text = chatList[indexPath.row].text
            cell.labelName.text = chatList[indexPath.row].name
            cell.labelTime.text = chatList[indexPath.row].date
            return cell
        }
        
}
