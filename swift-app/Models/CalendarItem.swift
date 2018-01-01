import Foundation

class CalendarItem {
    var date: String
    var dateObj: Date
    var event: String
    
    init(date: String, event: String) {
        // https://developer.apple.com/documentation/foundation/dateformatter
        // read from custom format and create date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.dateObj = dateFormatter.date(from: date)!
        // set to BE locale and format
        dateFormatter.locale = Locale(identifier: "nl_BE")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdyyyy")
        // assign
        self.event = event
        self.date = dateFormatter.string(from: dateObj)
    }
}
