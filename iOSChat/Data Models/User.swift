//
//  Contact.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable{
    @DocumentID var id: String?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
