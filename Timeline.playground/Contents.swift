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

func dayname(number: Int) -> String {
    switch number {
    case 1:
        return "sunday"
    case 2:
        return "monday"
    case 3:
        return "tuesday"
    case 4:
        return "wednesday"
    case 5:
        return "thursday"
    case 6:
        return "friday"
    case 7:
        return "saturday"
    default:
        return "error"
    }
}


func addTime(yearAdded: Int, monthAdded: Int, weekAdded:Int, dayAdded: Int, fromDate: NSDate) -> NSDate {
    
    var newDate = calendar.dateByAddingUnit(NSCalendarUnit.Year, value: yearAdded, toDate: fromDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Month, value: monthAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: 7 * weekAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: dayAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    
    return newDate
    
}



func dayOfWhichWeekOfMonth(dateString: String, fromMonthStart: Bool) -> Int {
    
    let date = NSDate(dateString: dateString + " 00:00")
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year,NSCalendarUnit.Weekday], fromDate: date)
    
    var month = components.month
    
    var multiplier = -1
    
    if (!fromMonthStart){
        multiplier = 1
    }
    
    var integer = 1
    
    while (month == components.month){
        let newDate = addTime(0, monthAdded: 0, weekAdded: multiplier * integer, dayAdded: 0, fromDate: date)
        let newDateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Weekday], fromDate: newDate)
        month = newDateComponents.month
        integer += 1
    }
    
    return integer - 1
}


func isweekly(selected: String, series:String) -> Bool {
    let selectedDate = NSDate(dateString: selected + " 00:00")
    let seriesDate = NSDate(dateString: series + " 00:00")
    
    let diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: seriesDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))
    return (diffDateComponents.day % 7 == 0)
    
}


func isbiweekly(selected: String, series:String) -> Bool {
    let selectedDate = NSDate(dateString: selected + " 00:00")
    let seriesDate = NSDate(dateString: series + " 00:00")
    
    let diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: seriesDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))
    return (diffDateComponents.day % 14 == 0)
    
}


let serial_start_date: String = "2016-04-01"

let serialStart = NSDate(dateString: serial_start_date + " 00:00")



let eventDate = addTime(0, monthAdded: 0, weekAdded: 4, dayAdded: 0, fromDate: serialStart)




dayOfWhichWeekOfMonth("2016-04-23", fromMonthStart: false)









isweekly("2016-04-16", series: "2016-04-02")
isbiweekly("2016-04-23", series: "2016-04-02")



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
