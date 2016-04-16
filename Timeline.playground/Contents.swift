import UIKit


extension NSDate{
    convenience init(dateString:String){
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate: d)
    }
}

let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!



let serial_start_date: String = "2016-04-01"
let serial_start_time: String = "19:30"

let serial_start = NSDate(dateString: serial_start_date + " " + serial_start_time)


let monthToAdd = 0
let daysToAdd = 5 * 7




var event_date = calendar.dateByAddingUnit(NSCalendarUnit.Month, value: monthToAdd, toDate: serial_start, options: NSCalendarOptions.init(rawValue: 0))!
event_date = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: daysToAdd, toDate: event_date, options: NSCalendarOptions.init(rawValue: 0))!




let eventStartComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfMonth, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Weekday], fromDate: event_date)

eventStartComponents.day
eventStartComponents.month
eventStartComponents.year
//
//
let selectedDate = NSDate(dateString: "2016-04-16 12:28")


var diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: selectedDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))

diffDateComponents.day
diffDateComponents.



//
//let anotherdate = calendar.dateFromComponents(startingComponents)




//var yearfirst = Int(String(start_date[start_date.startIndex.advancedBy(0)]))!
//var yearsecond = Int(String(start_date[start_date.startIndex.advancedBy(1)]))!
//var yearthird = Int(String(start_date[start_date.startIndex.advancedBy(2)]))!
//var yearfourth = Int(String(start_date[start_date.startIndex.advancedBy(3)]))!
//
//var monthfirst = Int(String(start_date[start_date.startIndex.advancedBy(5)]))!
//var monthsecond = Int(String(start_date[start_date.startIndex.advancedBy(6)]))!
//
//var dayfirst = Int(String(start_date[start_date.startIndex.advancedBy(8)]))!
//var daysecond = Int(String(start_date[start_date.startIndex.advancedBy(9)]))!
//
//var year = yearfirst*1000 + yearsecond*100 + yearthird*10 + yearfourth
//var month = monthfirst*10 + monthsecond
//var day = dayfirst*10 + daysecond



//let dateFormatter = NSDateFormatter()
//dateFormatter.locale = NSLocale.currentLocale()


//
//
//let startingComponents = NSDateComponents()
//startingComponents.day = 4
//startingComponents.month = 5
//startingComponents.year = 2006
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//var startDay = NSDate(dateString: "2014-06-06 0:00")
//var endDay = NSDate(dateString: "2014-06-06 23:59")
//
//var timeIntervalStartDay = NSTimeIntervalSince1970
//var timeIntervalEndDay = NSTimeIntervalSince1970
//timeIntervalStartDay = startDay.timeIntervalSince1970
//timeIntervalEndDay = endDay.timeIntervalSince1970
//
//
//
//
//
