//: Interview Cake - Q07 -
// https://www.interviewcake.com/question/python/temperature-tracker

import Foundation
import XCTest

final class TempTracker {

  private var min: Int?
  private var max: Int?
  private var sum = 0
  private var numTemperatures = 0
  private var temperatureCounts = [Int : Int]()
  private var mode: Int?

  func insert(temperature: Int) {
    if let max = max {
      if temperature > max {
        self.max = temperature
      }
    } else {
      max = temperature
    }

    if let min = min {
      if temperature < min {
        self.min = temperature
      }
    } else {
      min = temperature
    }

    sum += temperature
    numTemperatures += 1
    let count = (temperatureCounts[temperature] ?? 0) + 1
    temperatureCounts[temperature] = count
    if let mode = mode {
      let modeCount = temperatureCounts[mode] ?? 0
      if count > modeCount {
        self.mode = temperature
      }
    } else {
      mode = temperature
    }
  }

  func getMax() -> Int {
    return max ?? 0
  }

  func getMin() -> Int {
    return min ?? 0
  }

  func getMean() -> Double {
    if numTemperatures > 0 {
      return Double(sum/numTemperatures)
    } else {
      return Double(0)
    }
  }

  func getMode() -> Int {
    return mode ?? 0
  }
}

class Tests : XCTestCase {

  func test() {
    let tempTracker = TempTracker()
    tempTracker.insert(temperature: 0)
    tempTracker.insert(temperature: 110)
    tempTracker.insert(temperature: 55)
    tempTracker.insert(temperature: 55)

    XCTAssertEqual(tempTracker.getMax(), 110)
    XCTAssertEqual(tempTracker.getMin(), 0)
    XCTAssertEqual(tempTracker.getMean(), 55)
    XCTAssertEqual(tempTracker.getMode(), 55)
  }

}

Tests.defaultTestSuite.run()
