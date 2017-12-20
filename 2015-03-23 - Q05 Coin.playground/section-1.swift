// Interview Cake Q05: Coin
// https://www.interviewcake.com/question/coin


var processedCombinations = [Int: [[Int]]]()


func coinCombinationsToMake(amount: Int, withDenominations denominations: [Int]) -> [[Int]] {
    var combinations = [[Int]]()
    
    //sort denominations
    let sortedDenominations = denominations.sorted { (lhs, rhs) -> Bool in
        return lhs < rhs
    }
    
    if let smallestDenomination = sortedDenominations.first {
        for (index, denomination) in enumerate(sortedDenominations) {
            let subAmount = amount - denomination
            let subDenominations = Array(sortedDenominations[index..<sortedDenominations.count])
            
            if subAmount >= smallestDenomination {
                var subCombinations = coinCombinationsToMake(subAmount, withDenominations: subDenominations)

                subCombinations = subCombinations.map({
                    $0 + [denomination]
                })
                
                combinations += subCombinations
            } else if subAmount == 0 {
                combinations.append([denomination])
            }
        }
        
        processedCombinations[amount] = combinations
    }
    
    return combinations
}

let coinCombinations = coinCombinationsToMake(4, withDenominations: [1, 2,3])




//--------------------------------------------------------------------------------------------

func coinCombinationsToMake2(amount: Int, withDenominations denominations: [Int]) -> [[Int]] {

    
    
    
    return [[0]]
}
