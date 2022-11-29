import UIKit

private let commentsListiCellIndentifier = "\(CommentsOnListCell.self)"

class CommentsList2VController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var networking = Networking()
    var commonArrayForComments = [CommentModel]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.fetchCommentsRequest()
        networking.networkClosureForComments = { (mydata) in
            DispatchQueue.main.async {
                self.commonArrayForComments = mydata
                self.collectionView.reloadData()
            }
        }
        
        collectionView.register(UINib(nibName: commentsListiCellIndentifier, bundle: nil), forCellWithReuseIdentifier: commentsListiCellIndentifier)
    }
    
    // MARK: UICollectionViewDataSou%rce
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return commonArrayForComments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentsListiCellIndentifier, for: indexPath) as! CommentsOnListCell
        
        cell.emailLabel.text = commonArrayForComments[indexPath.item].email
        cell.nameLabel.text = commonArrayForComments[indexPath.item].name
        cell.textLabel.text = commonArrayForComments[indexPath.item].body
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width * 0.97, height: 120)
    }
    
}

