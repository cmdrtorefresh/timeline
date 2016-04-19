import UIKit


let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!


func stringToDate(dateString: String) -> NSDate {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.dateFromString(dateString)!
}


func dateToString(date: NSDate) -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.stringFromDate(date)
}


func dateStringToDayname(dateString: String) -> String {
    
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

func changeTimeOfDay(date: NSDate, newTime: String) -> NSDate {
    
    let newDateTimeString = dateToString(date) + " " + newTime
    return stringToDate(newDateTimeString)
    
}


func dateToStringHour(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale.currentLocale()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.stringFromDate(date)
}


//


func isWeeklyOn(dayname: String, selected: String) -> Bool {
    return (dateStringToDayname(selected) == dayname)
}

func isMonthlyOn(weekOrderSpaceDayName: String, selected: String) -> Bool {
    
    var i = 0
    let length = weekOrderSpaceDayName.characters.count
    var weekString = ""
    var daynameBool = false
    var dayname = ""
    
    while (i < length) {
        let index = weekOrderSpaceDayName.startIndex.advancedBy(i)
        if (String(weekOrderSpaceDayName[index]) == " "){
            daynameBool = true
        } else if (!daynameBool){
            weekString += String(weekOrderSpaceDayName[index]).lowercaseString
        } else {
            dayname += String(weekOrderSpaceDayName[index]).lowercaseString
        }
        
        i += 1
    }
    
    let dayCheck = (dayname == dateStringToDayname(selected))
    
    var weekCheck = false
    
    if (weekToInteger(weekString) < 0){
        weekCheck = (1 == dayOfWhichWeekOfMonth(selected, fromMonthStart: false))
    } else {
        weekCheck = (weekToInteger(weekString) == dayOfWhichWeekOfMonth(selected, fromMonthStart: true))
    }
    
    return dayCheck && weekCheck
    
}




func isWeekly(selected: String, series:String) -> Bool {
    let selectedDate = stringToDate(selected + " 00:00")
    let seriesDate = stringToDate(series + " 00:00")
    
    let diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: seriesDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))
    return (diffDateComponents.day % 7 == 0)
    
}


func isBiweekly(selected: String, series:String) -> Bool {
    let selectedDate = stringToDate(selected + " 00:00")
    let seriesDate = stringToDate(series + " 00:00")
    
    let diffDateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: seriesDate, toDate: selectedDate, options: NSCalendarOptions.init(rawValue: 0))
    return (diffDateComponents.day % 14 == 0)
    
}


func daynameToInteger(dayname: String) -> Int {
    
    switch dayname.lowercaseString {
    case "sunday":
        return 1
    case "monday":
        return 2
    case "tuesday":
        return 2
    case "wednesday":
        return 4
    case "thursday":
        return 5
    case "friday":
        return 6
    case "saturday":
        return 7
    default:
        return 8
     }
}


func monthToInteger(month: String) -> Int {
    
    switch month.lowercaseString {
    case "january":
        return 1
    case "february":
        return 2
    case "march":
        return 3
    case "april":
        return 4
    case "may":
        return 5
    case "june":
        return 6
    case "july":
        return 7
    case "august":
        return 8
    case "september":
        return 9
    case "october":
        return 10
    case "november":
        return 11
    case "december":
        return 12
    default:
        return 13
    }
    
}

func weekToInteger(week: String) -> Int {
    switch week.lowercaseString {
    case "first":
        return 1
    case "second":
        return 2
    case "third":
        return 3
    case "fourth":
        return 4
    case "fifth":
        return 5
    case "last":
        return -1
    default:
        return 6
    }
}

func frequencyClassifier(selected: String, seriesStartDate: String, frequency: String){
    switch frequency.lowercaseString{
    case "weekly":
        isWeekly(selected, series: seriesStartDate)
    case "biweekly":
        isBiweekly(selected, series: seriesStartDate)
    
        
    default:
       print ("Hello")
    }
}


// Example of Usage of all functions above

let series_start_date: String = "2016-04-01"

let seriesStart = stringToDate(series_start_date + " 00:00")

dateToString(seriesStart)

var eventDateStart = addTime(0, monthAdded: 0, weekAdded: 4, dayAdded: 0, minuteAdded: 0, fromDate: seriesStart)

eventDateStart = changeTimeOfDay(eventDateStart, newTime: "19:30")

dateToStringHour(eventDateStart)

let duration = 90

addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: duration, fromDate: eventDateStart)

dateStringToDayname(series_start_date)

dayOfWhichWeekOfMonth("2016-04-23", fromMonthStart: false)

isWeekly("2016-04-16", series: "2016-04-02")

isBiweekly("2016-04-23", series: "2016-04-02")

daynameToInteger("thursday")

monthToInteger("october")

weekToInteger("Second")

isMonthlyOn("first monday", selected: "2016-04-18")