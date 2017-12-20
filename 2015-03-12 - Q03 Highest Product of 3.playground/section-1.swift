// Playground - noun: a place where people can play

// Interview Cake Q3: Highest Product of 3
// https://www.interviewcake.com/question/highest-product-of-3


func highestProductOf3(array: [Int]) -> Int {
    assert(array.count >= 3, "Array needs to have at least 3 items")
    
    var highestProductOf3: Int?
    var highestProductOf2: Int?
    var highest: Int?
    var lowestProductOf2: Int?
    var lowest: Int?
    
    for number in array {
        
        // calculate a new potential highest product of 3 by multiplying with either lowest negative product of 2 or highest positive number
        if number >= 0 {
            if highestProductOf2 != nil {
                let currentProduct = number * highestProductOf2!
                if currentProduct > highestProductOf3 || highestProductOf3 == nil {
                    highestProductOf3 = currentProduct
                }
            }
        } else {
            if lowestProductOf2 != nil {
                let currentProduct = number * lowestProductOf2!
                if currentProduct > highestProductOf3 || highestProductOf3 == nil {
                    highestProductOf3 = currentProduct
                }
            }
        }
        
        // calculate a new potential highest product of 2 by multiplying with either lowest negative number or highest positive number
        if number >= 0 {
            if highest != nil {
                let currentProduct = number * highest!
                if currentProduct > highestProductOf2 || highestProductOf2 == nil {
                    highestProductOf2 = currentProduct
                }
            }
        } else {
            if lowest != nil {
                let currentProduct = number * lowest!
                if currentProduct > highestProductOf2 || highestProductOf2 == nil {
                    highestProductOf2 = currentProduct
                }
            }
        }
        
        // calculate a new potential lowest product of 2 by multiplying with either lowest negative number or highest positive number
        if number >= 0 {
            if lowest != nil {
                let currentProduct = number * lowest!
                if currentProduct < lowestProductOf2 || lowestProductOf2 == nil {
                    lowestProductOf2 = currentProduct
                }
            }
        } else {
            if highest != nil {
                let currentProduct = number * highest!
                if currentProduct < lowestProductOf2 || lowestProductOf2 == nil {
                    lowestProductOf2 = currentProduct
                }
            }
        }
        
        // calculated new highest or lowest numbers
        if number > highest || highest == nil {
            highest = number
        } else if number < lowest || lowest == nil {
            lowest = number
        }
    }

    return highestProductOf3!
}

highestProductOf3([1, 10, -5, 1, -100])


func highestProductOfK(array: [Int], k: Int) -> Int {
    assert(array.count >= k, "Array needs to have at least \(k) items")
    
    var positiveProducts = [Int?](count: k, repeatedValue: nil) // stored largest to lowest
    var negativeProducts = [Int?](count: k, repeatedValue: nil) // stored largest negative to lowest negative
    
    for number in array {
        for i in 1..<k {
            let prevPositiveProduct = positiveProducts[i-1]
            let prevNegativeProduct = negativeProducts[i-1]
            let positiveProduct = positiveProducts[i]
            let negativeProduct = negativeProducts[i]
            
            // calculate the previous largest positive number
            if number >= 0 {
                if positiveProduct != nil {
                    let currentProduct = number * positiveProduct!
                    if currentProduct > prevPositiveProduct || prevPositiveProduct == nil {
                        positiveProducts[i-1] = currentProduct
                    }
                }
            } else {
                if negativeProduct != nil {
                    let currentProduct = number * negativeProduct!
                    if currentProduct > prevPositiveProduct || prevPositiveProduct == nil {
                        positiveProducts[i-1] = currentProduct
                    }
                }
            }
            
            // calculate the previous largest negative number
            if number >= 0 {
                if negativeProduct != nil {
                    let currentProduct = number * negativeProduct!
                    if currentProduct < prevNegativeProduct || prevNegativeProduct == nil {
                        negativeProducts[i-1] = currentProduct
                    }
                }
            } else {
                if positiveProduct != nil {
                    let currentProduct = number * positiveProduct!
                    if currentProduct < prevNegativeProduct || prevNegativeProduct == nil {
                        negativeProducts[i-1] = currentProduct
                    }
                }
            }

            // set the final number which isn't a product
            if i == k-1 {
                if number > positiveProduct || positiveProduct == nil {
                    positiveProducts[i] = number
                } else if number < negativeProduct || negativeProduct == nil {
                    negativeProducts[i] = number
                }
            }
        }
    }

    return positiveProducts.first!!
}

highestProductOfK([1, 10, -5, 1, -100], 3)