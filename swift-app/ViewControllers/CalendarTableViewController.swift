import UIKit

class CalendarTableViewController: UITableViewController {
    var items: [CalendarItem]!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        let completeEvent = items[indexPath.row]
        cell.dateLabel.text = completeEvent.date
        cell.eventLabel.text = completeEvent.event
        return cell
    }
}

