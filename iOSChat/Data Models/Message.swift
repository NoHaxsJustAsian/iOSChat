//
//  Message.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable{
    @DocumentID var id: String?
    var name: String
    var text: String
    var date: Date
    
    init(name: String, text: String, date: Date) {
        self.name = name
        self.text = text
        self.date = date
    }
}
