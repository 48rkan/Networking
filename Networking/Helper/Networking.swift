
import Foundation

class Networking {
    
    var networkClosure : (([PostModel]) -> Void)?
    
    var networkClosureForComments : (([CommentModel]) -> Void)?
    
    var website = "https://jsonplaceholder.typicode.com"
    
    func fetchItemsRequest() {
        
        let customUrl = "\(website)/posts"
        
        //1
        let url = URL(string: customUrl)!
        
        //2
        let session = URLSession(configuration: .default)
        
        //3
        let task = session.dataTask(with: url) { data, response , error in
            if let data = data {
                do {
                    let data = try JSONDecoder().decode([PostModel].self, from: data)
                    
                    self.networkClosure?(data)
                    
                } catch {
                    print(error)
                }
            }
        }
        //4
        task.resume()
    }
    
    func fetchCommentsRequest() {
        //1
        let url = URL(string: "\(website)/posts/1/comments")!
        //2
        let session = URLSession(configuration: .default)
        //3
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let commentsData = try JSONDecoder().decode([CommentModel].self, from: data)
                    self.networkClosureForComments?(commentsData)
                } catch {
                    print("error")
                }
            }
        }
        //4
        task.resume()
    }
}
