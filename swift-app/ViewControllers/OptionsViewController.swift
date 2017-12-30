import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class OptionsViewController: UICollectionViewController {
    /**
     Used the following website to learn how UICollectionView works:
     https://www.raywenderlich.com/136159/uicollectionview-tutorial-getting-started
     Implemented my own version for what I wanted in my app.
     
     Also using a Firebase Realtime Database:
     https://firebase.google.com/docs/database/
    */
    // for performance: use a reuseIdentifier to use a cell as "base"
    fileprivate let reuseIdentifier = "optionCell"
    fileprivate let items: Int = 4
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsetsMake(50.0, 20.0, 50.0, 20.0)
    
    var ref: DatabaseReference!
    var calendarItems: [CalendarItem]!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        calendarItems = []
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "calendar"?:
            prepareCalendar(segue, sender)
        case "leaderboard"?:
            break
        case "inventory"?:
            break
        case "statistics"?:
            break
        case "logout"?:
            break
        default:
            fatalError("Unknown segue")
        }
    }
    
    func prepareCalendar(_ segue: UIStoryboardSegue, _ sender: Any?) {
        //requests most recent data from the db
        let calendarTableView = segue.destination as! CalendarTableViewController
            ref.child("calendar").observe(DataEventType.value, with: { (snapshot) in
                let dict = snapshot.value as? NSDictionary
                for (key, value) in dict! {
                    let calendarItem = CalendarItem(date: key as! String, event: value as! String)
                    self.calendarItems.append(calendarItem)
                }
                calendarTableView.items = self.calendarItems.sorted(by: { ($0.dateObj).compare($1.dateObj) == .orderedAscending })
                calendarTableView.tableView.reloadData()
                self.calendarItems.removeAll()
            }) { (error) in
                print(error.localizedDescription)
            }
    }
}

extension OptionsViewController {
    // could have additional methods for sections
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 'base' cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OptionCell
        // setup custom content for base cell
        cell.backgroundColor = UIColor.white
        // border
        cell.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true;
        // shadow backdrop
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath

        // setup each cell, depending on index path
        switch indexPath.item {
        case 0:
            cell.itemLabel.text = "Statistieken"
            cell.imageView.image = UIImage(named: "statistics")
        case 1:
            cell.itemLabel.text = "Klassement"
            cell.imageView.image = UIImage(named: "trophy")
        case 2:
            cell.itemLabel.text = "Uitrusting"
            cell.imageView.image = UIImage(named: "inventory")
        case 3:
            cell.itemLabel.text = "Schietingen"
            cell.imageView.image = UIImage(named: "calendar")
        default:
            fatalError("Unknown cell")
        }
        return cell
    }
}

extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    //extension with custom layout
    
    // responsible for size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // calc padding space (one extra for last item, double padding)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        // how much space is left after padding
        let availableWidth = view.frame.width - paddingSpace
        // distribute available space
        let widthPerItem = availableWidth / itemsPerRow
        // squares
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // responsible for spacing between cells/headers
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // spacing between each line
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            performSegue(withIdentifier: "statistics", sender: self)
        case 1:
            performSegue(withIdentifier: "leaderboard", sender: self)
        case 2:
            performSegue(withIdentifier: "inventory", sender: self)
        case 3:
            performSegue(withIdentifier: "calendar", sender: self)
        default:
            fatalError("Unknown segue")
        }
    }
}
