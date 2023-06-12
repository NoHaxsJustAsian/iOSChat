//
//  Message.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable{
    var name: String
    var text: String
    var date: String
    
    init(name: String, text: String, date: String) {
        self.name = name
        self.text = text
        self.date = date
    }
}
