
import UIKit

class ItemsOnListCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("h")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
