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
    var userSelf: User!
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
        //load entire fucking table
    }
    
    
}
