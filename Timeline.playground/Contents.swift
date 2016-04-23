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


func dateStringToMonth(dateString: String) -> Int {
    let date = stringToDate(dateString)
    
    let components = calendar.components([NSCalendarUnit.Month], fromDate: date)
    
    return components.month
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


func isDateEarlier(earlierDate: NSDate, laterDate: NSDate) -> Bool {
    
    if earlierDate.compare(laterDate) == NSComparisonResult.OrderedAscending {
        return true
    } else {
        return false
    }
}


func daynameToInteger(dayname: String) -> Int {
    
    switch dayname.lowercaseString {
    case "sunday":
        return 1
    case "monday":
        return 2
    case "tuesday":
        return 3
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

func daynameFromInteger(number: Int) -> String {
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



func parseFrequencyValue(frequencyValueString: String) -> [String] {
    var i = 1
    let length = frequencyValueString.characters.count
    
    var valueArray = [String]()
    
    var word = ""
    
    while (i < length) {
        
        let index = frequencyValueString.startIndex.advancedBy(i)
        let nextIndex = frequencyValueString.startIndex.advancedBy(i+1)
        let character = String(frequencyValueString[index]).lowercaseString
        
        if (character == "]"){
            valueArray.append(word)
            word = ""
        } else if (character != ",") {
            word += character
        } else {
            valueArray.append(word)
            word = ""
            if (String(frequencyValueString[nextIndex]).lowercaseString == " "){
                i += 1
            }
        }
        
        i += 1
    }
    
    return valueArray
    
}


func parseMonthlyFrequencyString(weekOrderSpaceDayName: String) -> [Int]{
    
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
    
    
    let weekNum = weekToInteger(weekString)
    
    let dayNum = daynameToInteger(dayname)

    return [weekNum, dayNum]
    
}




func parseAnnualFrequencyString(weekOrderSpaceDaynameInMonth: String) -> [Int] {
    
    var i = 0
    let length = weekOrderSpaceDaynameInMonth.characters.count
    var weekString = ""
    var dayname = ""
    var month = ""
    var daynameBool = false
    var monthnameBool = false
    var spaceCount = 0
    
    
    while (i < length) {
        
        let index = weekOrderSpaceDaynameInMonth.startIndex.advancedBy(i)
        
        switch spaceCount{
        case 1:
            daynameBool = true
        case 2:
            daynameBool = false
            monthnameBool = false
        case 3:
            monthnameBool = true
        default:
            daynameBool = false
            monthnameBool = false
        }
        
        if (String(weekOrderSpaceDaynameInMonth[index]) == " "){
            spaceCount += 1
        } else if (!daynameBool && !monthnameBool && spaceCount == 0){
            weekString += String(weekOrderSpaceDaynameInMonth[index]).lowercaseString
        } else if (daynameBool && !monthnameBool){
            dayname += String(weekOrderSpaceDaynameInMonth[index]).lowercaseString
        } else if (!daynameBool && monthnameBool){
            month += String(weekOrderSpaceDaynameInMonth[index]).lowercaseString
        }
        
        i += 1
    }
    
    return [weekToInteger(weekString), daynameToInteger(dayname), monthToInteger(month)]
    
}


func createWeeklyEventFromSeries(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDateString: String, eventStartTimeString: String, seriesDurationMinute: Int) -> [NSDate]{
    
    let seriesEventStartDateTime = stringToDate(seriesStartDateString + " " + eventStartTimeString)
    
    var eventStartAfterWindowEnd = false
    
    var eventStartTime = seriesEventStartDateTime
    
    while !eventStartAfterWindowEnd {
        eventStartTime = addTime(0, monthAdded: 0, weekAdded: 1, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
        if (isDateEarlier(selectedMaximum, laterDate: eventStartTime)){
            eventStartAfterWindowEnd = true
        }
    }
 
    eventStartTime = addTime(0, monthAdded: 0, weekAdded: -1, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
    let eventEndTime = addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: seriesDurationMinute, fromDate: eventStartTime)
    
    return [eventStartTime, eventEndTime]
    
}

func createBiweeklyEventFromSeries(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDateString: String, eventStartTimeString: String, seriesDurationMinute: Int) -> [NSDate]{
    
    let seriesEventStartDateTime = stringToDate(seriesStartDateString + " " + eventStartTimeString)
    
    var eventStartAfterWindowEnd = false
    
    var eventStartTime = seriesEventStartDateTime
    
    while !eventStartAfterWindowEnd {
        eventStartTime = addTime(0, monthAdded: 0, weekAdded: 2, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
        if (isDateEarlier(selectedMaximum, laterDate: eventStartTime)){
            eventStartAfterWindowEnd = true
        }
    }
    
    eventStartTime = addTime(0, monthAdded: 0, weekAdded: -2, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
    let eventEndTime = addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: seriesDurationMinute, fromDate: eventStartTime)
    
    return [eventStartTime, eventEndTime]
    
}


func isWeekly(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDate:String, eventStartTime: String, seriesDurationMinute: Int) -> [NSDate] {
    
    let eventStartStopTime = createWeeklyEventFromSeries(selectedMinimum, selectedMaximum: selectedMaximum, seriesStartDateString: seriesStartDate, eventStartTimeString: eventStartTime, seriesDurationMinute: seriesDurationMinute)

    if isDateEarlier(selectedMinimum, laterDate: eventStartStopTime[1]){
        return eventStartStopTime
    } else {
        return []
    }
}



func isBiweekly(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDate:String, eventStartTime: String, seriesDurationMinute: Int) -> [NSDate] {
    
    let eventStartStopTime = createBiweeklyEventFromSeries(selectedMinimum, selectedMaximum: selectedMaximum, seriesStartDateString: seriesStartDate, eventStartTimeString: eventStartTime, seriesDurationMinute: seriesDurationMinute)
    
    if isDateEarlier(selectedMinimum, laterDate: eventStartStopTime[1]) {
        return eventStartStopTime
    } else {
        return []
    }
}



func createOtherWeeklyOnStartingDatesFromExistingDate(availableSeriesStartDateString: String, eventStartTimeString: String, frequencyValueString: String) -> [NSDate]{
    
    let frequencyValueArray = parseFrequencyValue(frequencyValueString)
    
    var availableSeriesStartDateDay = Int()
    
    var resultArray = [NSDate]()
    
    let availableSeriesStartDate = stringToDate(availableSeriesStartDateString + " " + eventStartTimeString)
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Weekday], fromDate: availableSeriesStartDate)
    
    availableSeriesStartDateDay = components.weekday
    
    for index in frequencyValueArray {
        var dayAddition = 0
        if (daynameToInteger(index) > availableSeriesStartDateDay){
            dayAddition = (daynameToInteger(index) - availableSeriesStartDateDay) % 7
            resultArray.append(addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: dayAddition, minuteAdded: 0, fromDate: availableSeriesStartDate))
        } else if (daynameToInteger(index) < availableSeriesStartDateDay){
            dayAddition = (7 + daynameToInteger(index) - availableSeriesStartDateDay) % 7
            resultArray.append(addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: dayAddition, minuteAdded: 0, fromDate: availableSeriesStartDate))
        }
    }
    
    return resultArray
}



func isWeeklyOn(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDate:String, eventStartTime: String, seriesDurationMinute: Int, frequencyValueString: String) -> [NSDate]{
    
    var dates = [NSDate]()
    dates.append(stringToDate(seriesStartDate + " " + eventStartTime))
    dates = dates + (createOtherWeeklyOnStartingDatesFromExistingDate(seriesStartDate, eventStartTimeString: eventStartTime, frequencyValueString: frequencyValueString))
    
    for index in dates {
//        let day = calendar.component(NSCalendarUnit.Weekday, fromDate: index)
        let dateString = dateToString(index)
        let hourString = dateToStringHour(index)
        
        if (!isWeekly(selectedMinimum, selectedMaximum: selectedMaximum, seriesStartDate: dateString, eventStartTime: hourString, seriesDurationMinute: seriesDurationMinute).isEmpty){
            return isWeekly(selectedMinimum, selectedMaximum: selectedMaximum, seriesStartDate: dateString, eventStartTime: hourString, seriesDurationMinute: seriesDurationMinute)
        }
    }
    return []
}



func datesWithDaynameInSelectedDateMonth(selectedDate: NSDate, dayname: String) -> [NSDate]{
    
    let components = calendar.components([NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Weekday, NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: selectedDate)
    
    var newArray = [NSDate]()
    
    let year = components.year
    let month = components.month
    
    var monthString = ""
    var hourString = ""
    var minuteString = ""
    
    var firstDate = NSDate()
    
    if month < 10 {
        monthString = "0" + String(month)
    } else {
        monthString = String(month)
    }
    
    if components.hour < 10 {
        hourString = "0" + String(components.hour)
    } else {
        hourString = String(components.hour)
    }
    
    if components.minute < 10 {
        minuteString = "0" + String(components.minute)
    } else {
        minuteString = String(components.minute)
    }
    
    
    for index in 1...7 {
        let iDate = stringToDate(String(year) + "-" + monthString + "-0" + String(index) + " " + hourString + ":" + minuteString)
        let iComponents = calendar.components([NSCalendarUnit.Weekday], fromDate: iDate)
        if (daynameToInteger(dayname) == iComponents.weekday){
            firstDate = iDate
        }
    }
    
    var iteratorMonth = month
    var currentWeek = firstDate
    
    while (iteratorMonth == month){
        newArray.append(currentWeek)
        currentWeek = addTime(0, monthAdded: 0, weekAdded: 1, dayAdded: 0, minuteAdded: 0, fromDate: currentWeek)
        let currentComponent = calendar.components([NSCalendarUnit.Month], fromDate: currentWeek)
        iteratorMonth = currentComponent.month
    }
    
    return newArray
}




func createMonthlyEventFromSeries(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDateString: String, eventStartTimeString: String, seriesDurationMinute: Int, frequencyValue: [Int]) -> [NSDate] {
    
    let seriesEventStartDateTime = stringToDate(seriesStartDateString + " " + eventStartTimeString)
    
    let startWeekday = calendar.component([NSCalendarUnit.Weekday], fromDate: seriesEventStartDateTime)

    let dayname = daynameFromInteger(startWeekday)
    
    var eventStartAfterWindowEnd = false
    
    var eventStartTime = seriesEventStartDateTime

    while !eventStartAfterWindowEnd {
        eventStartTime = addTime(0, monthAdded: 1, weekAdded: 0, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
        let newDatesArray = datesWithDaynameInSelectedDateMonth(eventStartTime, dayname: dayname)
     
        if frequencyValue[0] > 0 {
            eventStartTime = newDatesArray[frequencyValue[0]-1]
        } else {
            let index = newDatesArray.count - 1
            eventStartTime = newDatesArray[index]
        }
        
        if (isDateEarlier(selectedMaximum, laterDate: eventStartTime)){
            eventStartAfterWindowEnd = true
        }
    }
  
    eventStartTime = addTime(0, monthAdded: -1, weekAdded: 0, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
    let monthDatesArray = datesWithDaynameInSelectedDateMonth(eventStartTime, dayname: dayname)
    
    if frequencyValue[0] > 0 {
        eventStartTime = monthDatesArray[frequencyValue[0]-1]
    } else {
        let index = monthDatesArray.count - 1
        eventStartTime = monthDatesArray[index]
    }

    let eventEndTime = addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: seriesDurationMinute, fromDate: eventStartTime)
    
    return [eventStartTime, eventEndTime]
    
}


func createAllMonthlyStartingDatesFromExistingDate(availableSeriesStartDateString: String, eventStartTimeString: String, frequencyValueString: String) -> [AnyObject] {
    
    var datesAndValues = [AnyObject]()
    
    let frequencyValueArray = parseFrequencyValue(frequencyValueString)
    
    let availableSeriesStartDate = stringToDate(availableSeriesStartDateString + " " + eventStartTimeString)
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Weekday], fromDate: availableSeriesStartDate)
    
    for index in frequencyValueArray {
        let freqValue = parseMonthlyFrequencyString(index)
        if freqValue[0] > 0 && freqValue[0] == dayOfWhichWeekOfMonth(availableSeriesStartDateString, fromMonthStart: true) && components.weekday == freqValue[1] {
            datesAndValues.append([availableSeriesStartDate, freqValue])
        } else if freqValue[0] < 0 && -1 * freqValue[0] == dayOfWhichWeekOfMonth(availableSeriesStartDateString, fromMonthStart: false) && components.weekday == freqValue[1] {
            datesAndValues.append([availableSeriesStartDate, freqValue])
        } else {
            let wholeMonth = datesWithDaynameInSelectedDateMonth(availableSeriesStartDate, dayname: daynameFromInteger(freqValue[1]))
            var date = NSDate()
            
            if (freqValue[0] > 0){
                date = wholeMonth[freqValue[0] - 1]
            } else {
                let i = wholeMonth.count
                date = wholeMonth[i-1]
            }
            
            datesAndValues.append([date, freqValue])
            
        }
    }
    
    return datesAndValues
    
}



func isMonthly(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDateString: String, eventStartTimeString: String, seriesDurationMinute: Int, frequencyValueString: String) -> [NSDate] {
    
    let datesAndValues = createAllMonthlyStartingDatesFromExistingDate(seriesStartDateString, eventStartTimeString: eventStartTimeString, frequencyValueString: frequencyValueString) 
    
    for dateAndValue in datesAndValues {
        let date = dateAndValue[0] as! NSDate
        let dateString = dateToString(date)
        let freqValue = dateAndValue[1] as! [Int]
        
        let startAndStop = createMonthlyEventFromSeries(selectedMinimum, selectedMaximum: selectedMaximum, seriesStartDateString: dateString, eventStartTimeString: eventStartTimeString, seriesDurationMinute: seriesDurationMinute, frequencyValue: freqValue)
        if isDateEarlier(selectedMinimum, laterDate: startAndStop[1]){
            return startAndStop
        }
    }
    
    return []
}


func createAnnualEventFromSeries(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDateString: String, eventStartTimeString: String, seriesDurationMinute: Int, frequencyValue: [Int]) -> [NSDate] {
    
    let seriesEventStartDateTime = stringToDate(seriesStartDateString + " " + eventStartTimeString)
    
    let startWeekday = calendar.component([NSCalendarUnit.Weekday], fromDate: seriesEventStartDateTime)
    
    let dayname = daynameFromInteger(startWeekday)
    
    var eventStartAfterWindowEnd = false
    
    var eventStartTime = seriesEventStartDateTime
    
    while !eventStartAfterWindowEnd {
        eventStartTime = addTime(1, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
        let newDatesArray = datesWithDaynameInSelectedDateMonth(eventStartTime, dayname: dayname)
        
        if frequencyValue[0] > 0 {
            eventStartTime = newDatesArray[frequencyValue[0]-1]
        } else {
            let index = newDatesArray.count - 1
            eventStartTime = newDatesArray[index]
        }
        
        if (isDateEarlier(selectedMaximum, laterDate: eventStartTime)){
            eventStartAfterWindowEnd = true
        }
    }
    
    eventStartTime = addTime(-1, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: 0, fromDate: eventStartTime)
    let monthDatesArray = datesWithDaynameInSelectedDateMonth(eventStartTime, dayname: dayname)
    
    if frequencyValue[0] > 0 {
        eventStartTime = monthDatesArray[frequencyValue[0]-1]
    } else {
        let index = monthDatesArray.count - 1
        eventStartTime = monthDatesArray[index]
    }
    
    let eventEndTime = addTime(0, monthAdded: 0, weekAdded: 0, dayAdded: 0, minuteAdded: seriesDurationMinute, fromDate: eventStartTime)
    
    return [eventStartTime, eventEndTime]
}




func createAllAnnualStartingDatesFromExistingDate(availableSeriesStartDateString: String, eventStartTimeString: String, frequencyValueString: String) -> [AnyObject] {
    
    var datesAndValues = [AnyObject]()
    
    let frequencyValueArray = parseFrequencyValue(frequencyValueString)
    
    let availableSeriesStartDate = stringToDate(availableSeriesStartDateString + " " + eventStartTimeString)
    
    let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Weekday], fromDate: availableSeriesStartDate)
    
    let year = components.year
    let day = components.day
    
    for index in frequencyValueArray {
        let freqValue = parseAnnualFrequencyString(index)
        if freqValue[0] > 0 && freqValue[0] == dayOfWhichWeekOfMonth(availableSeriesStartDateString, fromMonthStart: true) && components.weekday == freqValue[1] && components.month == freqValue[2]{
            datesAndValues.append([availableSeriesStartDate, freqValue])
        } else if freqValue[0] < 0 && -1 * freqValue[0] == dayOfWhichWeekOfMonth(availableSeriesStartDateString, fromMonthStart: false) && components.weekday == freqValue[1] && components.month == freqValue[2] {
            datesAndValues.append([availableSeriesStartDate, freqValue])
        } else {
            let month = freqValue[2]
            
            var monthString = ""
            var dayString = ""
            
            if month < 10 {
                monthString = "0" + String(month)
            } else {
                monthString = String(month)
            }
            
            if day < 10 {
                dayString = "0" + String(day)
            } else {
                dayString = String(day)
            }
            
            var date = stringToDate(String(year) + "-" + monthString + "-" + dayString + " " + eventStartTimeString)
            
            if isDateEarlier(date, laterDate: availableSeriesStartDate){
                date = stringToDate(String(year+1) + "-" + monthString + "-" + dayString + " " + eventStartTimeString)
            }
            
            let wholeMonth = datesWithDaynameInSelectedDateMonth(date, dayname: daynameFromInteger(freqValue[1]))
            
            if (freqValue[0] > 0){
                date = wholeMonth[freqValue[0] - 1]
            } else {
                let i = wholeMonth.count
                date = wholeMonth[i-1]
            }
            
            datesAndValues.append([date, freqValue])
            
        }
    }
    
    return datesAndValues
    
}


func isAnnual(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDateString: String, eventStartTimeString: String, seriesDurationMinute: Int, frequencyValueString: String) -> [NSDate]{
    
    let datesAndValues = createAllAnnualStartingDatesFromExistingDate(seriesStartDateString, eventStartTimeString: eventStartTimeString, frequencyValueString: frequencyValueString)
    
    for dateAndValue in datesAndValues {
        let date = dateAndValue[0] as! NSDate
        let dateString = dateToString(date)
        let freqValue = dateAndValue[1] as! [Int]
        
        let startAndStop = createAnnualEventFromSeries(selectedMinimum, selectedMaximum: selectedMaximum, seriesStartDateString: dateString, eventStartTimeString: eventStartTimeString, seriesDurationMinute: seriesDurationMinute, frequencyValue: freqValue)
        if isDateEarlier(selectedMinimum, laterDate: startAndStop[1]){
            return startAndStop
        }
    }
    
    return []
}









let min = stringToDate("2016-12-30 20:00")
let max = stringToDate("2016-12-30 23:59")
isWeekly(min, selectedMaximum: max, seriesStartDate: "2016-04-22", eventStartTime: "20:00", seriesDurationMinute: 45)
isBiweekly(min, selectedMaximum: max, seriesStartDate: "2016-04-29", eventStartTime: "20:00", seriesDurationMinute: 45)
isWeeklyOn(min, selectedMaximum: max, seriesStartDate: "2016-04-26", eventStartTime: "22:00", seriesDurationMinute: 45, frequencyValueString: "[tuesday]")
isMonthly(min, selectedMaximum: max, seriesStartDateString: "2016-04-29", eventStartTimeString: "22:00", seriesDurationMinute: 120, frequencyValueString: "[last friday]")
isAnnual(min, selectedMaximum: max, seriesStartDateString: "2013-11-29", eventStartTimeString: "22:00", seriesDurationMinute: 120, frequencyValueString: "[last friday in november]")






func frequencyClassifier(selectedMin: NSDate, selectedMax: NSDate, seriesStartDate: String, eventStartTime: String, durationMinute: Int, frequency: String, frequencyValueString: String) -> [NSDate] {
    
    var startStopDate = [NSDate]()
    
    switch frequency.lowercaseString{
    case "weekly":
        startStopDate = isWeekly(selectedMin, selectedMaximum: selectedMax, seriesStartDate: seriesStartDate, eventStartTime: eventStartTime, seriesDurationMinute: durationMinute)
    case "biweekly":
        startStopDate = isBiweekly(selectedMin, selectedMaximum: selectedMax, seriesStartDate: seriesStartDate, eventStartTime: eventStartTime, seriesDurationMinute: durationMinute)
    case "weeklyon":
        startStopDate = isWeeklyOn(selectedMin, selectedMaximum: selectedMax, seriesStartDate: seriesStartDate, eventStartTime: eventStartTime, seriesDurationMinute: durationMinute, frequencyValueString: frequencyValueString)
    case "monthly":
        startStopDate = isMonthly(selectedMin, selectedMaximum: selectedMax, seriesStartDateString: seriesStartDate, eventStartTimeString: eventStartTime, seriesDurationMinute: durationMinute, frequencyValueString: frequencyValueString)
    case "annual":
        startStopDate = isAnnual(selectedMin, selectedMaximum: selectedMax, seriesStartDateString: seriesStartDate, eventStartTimeString: eventStartTime, seriesDurationMinute: durationMinute, frequencyValueString: frequencyValueString)
    case "quarterly":
        startStopDate = isAnnual(selectedMin, selectedMaximum: selectedMax, seriesStartDateString: seriesStartDate, eventStartTimeString: eventStartTime, seriesDurationMinute: durationMinute, frequencyValueString: frequencyValueString)
    case "semiannual":
        startStopDate = isAnnual(selectedMin, selectedMaximum: selectedMax, seriesStartDateString: seriesStartDate, eventStartTimeString: eventStartTime, seriesDurationMinute: durationMinute, frequencyValueString: frequencyValueString)
    default:
        print ("error")
    }

    return startStopDate
}



frequencyClassifier(min, selectedMax: max, seriesStartDate: "2013-11-29", eventStartTime: "22:00", durationMinute: 120, frequency: "quarterly", frequencyValueString: "[last friday in march, last friday in june, last friday in september, last friday in december]")

//func filterSeries(selectedMinimum: NSDate, selectedMaximum: NSDate, seriesStartDate: String, frequency: String, frequencyValueString: String) -> Bool {
//    
//    var frequencyValue = Array<String>()
//    
//    if (frequencyValueString != "") {
//        frequencyValue = parseFrequencyValue(frequencyValueString)
//    }
//    
//    var evaluation = false
//    
//    switch frequency.lowercaseString{
//    case "weekly":
//        evaluation = isWeekly(selected, series: seriesStartDate)
//    case "biweekly":
//        evaluation = isBiweekly(selected, series: seriesStartDate)
//    case "weeklyon":
//        for item in frequencyValue {
//            let test = isWeeklyOn(item, selected: selected)
//            if (test){
//                evaluation = true
//                break
//            }
//        }
//    case "monthly":
//        for item in frequencyValue {
//            let test = isMonthlyOn(item, selected: selected)
//            if (test){
//                evaluation = true
//                break
//            }
//        }
//    case "annual":
//        for item in frequencyValue {
//            let test = isAnnualOn(item, selected: selected)
//            if (test) {
//                evaluation = true
//                break
//            }
//        }
//    case "semiannual":
//        for item in frequencyValue {
//            let test = isAnnualOn(item, selected: selected)
//            if (test) {
//                evaluation = true
//                break
//            }
//        }
//    case "quarterly":
//        for item in frequencyValue {
//            let test = isAnnualOn(item, selected: selected)
//            if (test) {
//                evaluation = true
//                break
//            }
//        }
//    default:
//        print ("error")
//    }
//    
//    return evaluation
//    
//}
