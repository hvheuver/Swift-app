import Foundation

class Deserializer {
    
    static func deserializeCalendarItems(dict: NSDictionary) -> [CalendarItem]{
        var items: [CalendarItem] = []
        for (key, value) in dict {
            let calendarItem = CalendarItem(date: key as! String, event: value as! String)
            items.append(calendarItem)
        }
        return items
    }
    
    static func deserializeStatistic(dict: NSDictionary) -> Statistic{
        let statistic = Statistic()
        for (_, userid) in dict {
            // key will be a timestamp (currently not used), value a data entry
            let subdict = userid as! NSDictionary
            let entry = DataEntry(
                hoogvogels: Int(truncating: subdict.object(forKey: "hoogvogels") as! NSNumber),
                zijvogels: Int(truncating: subdict.object(forKey: "zijvogels") as! NSNumber),
                kalleVogels: Int(truncating: subdict.object(forKey: "kalleVogels") as! NSNumber),
                kleineVogels: Int(truncating: subdict.object(forKey: "kleineVogels") as! NSNumber))
            // add each entry to the statistic
            statistic.appendData(data: entry)
        }
        return statistic
    }
}
