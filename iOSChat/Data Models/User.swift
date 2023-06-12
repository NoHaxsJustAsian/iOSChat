import Foundation
import FirebaseFirestoreSwift

struct User: Codable{
    @DocumentID var id: String?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
