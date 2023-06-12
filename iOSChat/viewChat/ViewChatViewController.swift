//
//  ViewChatViewController.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import UIKit

class ViewChatViewController: UIViewController {
    var delegate:ViewController!
    let viewChatView = ViewChatView()
    var userSelf: User! // should be getting passed in from the previous page
    var userOther: User!
    
    override func loadView() {
        view = viewChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "" //User Other's Name
        
        getAllChats()
        
        //set userSelf
        //set userOther
        //set colorChat for Self
        //set colorChat for Other (note these two could be included in getAllChats
        //load entire fucking table
        //SCROLL TO BOTTOM USING THIS THING BELOW.
        tableV_Chat.ScrollToRow(
                NSIndexPath.FromRowSection(Messages.Length - 1, 0),
                UITableViewScrollPosition.None,
                false);
        
    }
    func getAllChats(){
        //use users to search firebase storage for chat id, and respective chat info and populate table.
        //call method when message is sent or recieved.
    }
}

    extension ViewChatViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contactNames.count //this has to be changed to chat messages count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "names", for: indexPath) as! ContactsTableViewCell
            cell.labelName.text = contactNames[indexPath.row] //change to chat messages array
            return cell
        }
        
}
