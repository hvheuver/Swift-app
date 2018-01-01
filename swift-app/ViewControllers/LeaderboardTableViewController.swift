import Foundation
import UIKit

class LeaderboardTableViewController : UITableViewController{
    var items: [Statistic]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add view to remove empty rows
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items != nil {
            return items.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderboardCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "leaderboardHeaderCell")
        return headerCell
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}
