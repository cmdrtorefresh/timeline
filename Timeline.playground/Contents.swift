import UIKit


let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!


func stringToDate(dateString: String) -> NSDate {
    
    //    2016-05-01 00:00
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.dateFromString(dateString)!
}


func dateToString(date: NSDate) -> String {
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: date)
    
    var month = ""
    
    var day = ""
    
    if (components.month < 10) {
        month = "0" + String(components.month)
    } else {
        month = String(components.month)
    }
    
    if (components.day < 10) {
        day = "0" + String(components.day)
    } else {
        day = String(components.day)
    }
    
    
    return String(components.year) + "-" + month + "-" + day
    
}


func dayname(dateString: String) -> String {
    
    let date = stringToDate(dateString + " 00:00")
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year,NSCalendarUnit.Weekday], fromDate: date)
    
    let number = components.weekday
    
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


func addTime(yearAdded: Int, monthAdded: Int, weekAdded:Int, dayAdded: Int, minuteAdded: Int, fromDate: NSDate) -> NSDate {
    
    var newDate = calendar.dateByAddingUnit(NSCalendarUnit.Year, value: yearAdded, toDate: fromDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Month, value: monthAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: 7 * weekAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: dayAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    newDate = calendar.dateByAddingUnit(NSCalendarUnit.Minute, value: minuteAdded, toDate: newDate, options: NSCalendarOptions.init(rawValue: 0))!
    
    return newDate
    
}


func dayOfWhichWeekOfMonth(dateString: String, fromMonthStart: Bool) -> Int {
    
    let date = stringToDate(dateString + " 00:00")
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year,NSCalendarUnit.Weekday], fromDate: date)
    
    var month = components.month
    
    var multiplier = -1
    
    if (!fromMonthStart){
        multiplier = 1
    }
    
    var integer = 1
    
    while (month == components.month){
        let newDate = addTime(0, monthAdded: 0, weekAdded: multiplier * integer, dayAdded: 0, minuteAdded: 0, fromDate: date)
        let newDateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Weekday], fromDate: newDate)
        month = newDateComponents.month
        integer += 1
    }
    
    return integer - 1
}


func isweekly(selected: String, series:String) -> Bool {
    let selectedDate = stringToDate(selected + " 00:00")
    let seriesDate = stringToDate(series + " 00:00")
    
    let diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: seriesDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))
    return (diffDateComponents.day % 7 == 0)
    
}


func isbiweekly(selected: String, series:String) -> Bool {
    let selectedDate = stringToDate(selected + " 00:00")
    let seriesDate = stringToDate(series + " 00:00")
    
    let diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: seriesDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))
    return (diffDateComponents.day % 14 == 0)
    
}


func changeTimeOfDay(date: NSDate, newTime: String) -> NSDate {
    
    let newDateTimeString = dateToString(date) + " " + newTime
    return stringToDate(newDateTimeString)
     
}



// Example of Usage of all functions above

let series_start_date: String = "2016-04-01"

let seriesStart = stringToDate(series_start_date + " 00:00")

let seriesStartString = dateToString(seriesStart)

var eventDateStart = addTime(0, monthAdded: 0, weekAdded: 4, dayAdded: 0, minuteAdded: 0, fromDate: seriesStart)

eventDateStart = changeTimeOfDay(eventDateStart, newTime: "19:30")

let duration = 90

let eventDateEnd = addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: duration, fromDate: eventDateStart)

dayname(series_start_date)

dayOfWhichWeekOfMonth("2016-04-23", fromMonthStart: false)

isweekly("2016-04-16", series: "2016-04-02")

isbiweekly("2016-04-23", series: "2016-04-02")