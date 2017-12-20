// Interview Cake Q04 - Merging Ranges
// https://www.interviewcake.com/question/merging-ranges

// donna: see bottom solution

typealias TimeRange = (start: Int, end: Int)


func timeRangesConnect(timeRange1: TimeRange, timeRange2: TimeRange) -> Bool {
    if timeRange1.start <= timeRange2.start && timeRange1.end >= timeRange2.start {
        return true
    } else if timeRange2.start <= timeRange1.start && timeRange2.end >= timeRange1.start {
        return true
    }
    
    return false
}


func joinTimeRanges(timeRange1: TimeRange, timeRange2: TimeRange) -> TimeRange {
    return TimeRange(start: min(timeRange1.start, timeRange2.start), max(timeRange1.end, timeRange2.end))
}


// -------------------------------------------------------------------------------------------------
// potentially bad O(n^n)

func combineTimeRanges(timeRanges: [TimeRange]) -> [TimeRange] {
    var busyTimes = [TimeRange]()
    
    for timeRange in timeRanges {
        var updatedIndex: Int?
        
        for (index, busyTime) in enumerate(busyTimes) {
            if timeRangesConnect(timeRange, busyTime) {
                let joinedTimeRange = joinTimeRanges(timeRange, busyTime)

                // check if there is now an overlap with the time range after it
                busyTimes[index] = joinedTimeRange
                updatedIndex = index
                break
            }
        }
        
        if let updatedIndex = updatedIndex {
            checkAndConnectTimeRangesFromIndex(updatedIndex, &busyTimes)
        } else {
            insertTimeRange(timeRange, &busyTimes)
        }
    }
    
    return busyTimes
}

func checkAndConnectTimeRangesFromIndex(index: Int, inout timeRanges: [TimeRange]) {
    var checkForNewConnection = true
    var indexToCheck = index
    
    while checkForNewConnection {
        // check if there are more time ranges after this index
        if indexToCheck < timeRanges.count - 1 {
            let firstTimeRange = timeRanges[indexToCheck]
            let secondTimeRange = timeRanges[indexToCheck+1]
            
            if timeRangesConnect(firstTimeRange, secondTimeRange) {
                let joinedTimeRange = joinTimeRanges(firstTimeRange, secondTimeRange)
                timeRanges[indexToCheck] = joinedTimeRange
                timeRanges.removeAtIndex(indexToCheck+1)
            } else {
                // we can stop checking now
                checkForNewConnection = false
            }
        } else {
            checkForNewConnection = false
        }
    }
}


func insertTimeRange(timeRange: TimeRange, inout timeRanges: [TimeRange]) {
    // assume times are sorted
    //could be optimised with binary insertion instead
    var indexToInsert: Int?
    for i in 0..<timeRanges.count {
        let tr = timeRanges[i]
        if tr.start > timeRange.start {
            indexToInsert = i
            break
        }
    }
    
    if let index = indexToInsert {
        timeRanges.insert(timeRange, atIndex: index)
    } else {
        timeRanges.append(timeRange)
    }
}

var timeRanges: [TimeRange] = [(0, 1), (3, 5), (4, 8), (10, 12), (9, 10), (-2, -1), (-1, 0), (1, 3)]
var busyTimes = combineTimeRanges(timeRanges)



// -------------------------------------------------------------------------------------------------
// O(nlogn)

func combineTimeRanges2(timeRanges: [TimeRange]) -> [TimeRange] {
    var busyTimes = [TimeRange]()
    
    let sortedTimes = timeRanges.sorted { (lhs, rhs) -> Bool in
        lhs.start < rhs.start
    }
    
    var currentTimeRange: TimeRange?
    
    for timeRange in sortedTimes {
        if currentTimeRange != nil {
            if timeRangesConnect(currentTimeRange!, timeRange) {
                currentTimeRange = joinTimeRanges(currentTimeRange!, timeRange)
            } else {
                busyTimes.append(currentTimeRange!)
                currentTimeRange = timeRange
            }
        } else {
            currentTimeRange = timeRange
        }
    }
    
    if let currentTimeRange = currentTimeRange {
        busyTimes.append(currentTimeRange)
    }
    
    return busyTimes
}

var timeRanges2: [TimeRange] = [(0, 1), (3, 5), (4, 8), (10, 12), (9, 10), (-2, -1), (-1, 0), (1, 3)]
var busyTimes2 = combineTimeRanges2(timeRanges)
