import Foundation
import UIKit

class LeaderboardTableViewController : UITableViewController{
    var items: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add view to remove empty rows
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
}
