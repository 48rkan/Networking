
import UIKit

class ViewController: UIViewController {
    
    var networking = Networking()
    var commonArray = [PostModel]()
        
    //MARK:- Properties
    @IBOutlet var tableView: UITableView!
    
    var itemsListCellIdentifier = "\(ItemsOnListCell.self)"
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.register(UINib(nibName: itemsListCellIdentifier, bundle: nil), forCellReuseIdentifier: itemsListCellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let loader = loader()
        
        networking.fetchItemsRequest()
        
        networking.networkClosure = { (myData) in
            DispatchQueue.main.async {
                self.commonArray = myData
                self.tableView.reloadData()
                
                self.stopLoader(loader: loader)

            }
        }
    }
    
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "Wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.color = .red
        alert.view.addSubview(indicator)
            
        self.present(alert, animated: true, completion: nil)
            
        return alert
    }
        
    func stopLoader(loader:UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemsListCellIdentifier) as! ItemsOnListCell
//        networkClosure!(cell.titleLabel?.text ?? "" , cell.bodyLabel.text ?? "")
        cell.titleLabel.text = commonArray[indexPath.row].title
        cell.bodyLabel.text = commonArray[indexPath.row].body
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let commentsListVC = storyboard?.instantiateViewController(identifier: "CommentsList2VController") as! CommentsList2VController

        navigationController?.show(commentsListVC, sender: nil)

    }
}
