
import Foundation

struct PostModel : Decodable {
    
    var id : Int
    var userId : Int
    var title : String
    var body : String
}

struct CommentModel : Decodable {
    
    var id : Int
    var name : String
    var email : String
    var body : String
}
