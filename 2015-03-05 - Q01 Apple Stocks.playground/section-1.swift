// Playground - noun: a place where people can play

// https://www.interviewcake.com/question/stock-price



// ------------------------------------------------------------------------------------------
// MARK: DayTrade

class DayTrade {
    
    // MARK: Properties
    
    var buyTime: Int = 0 {
        didSet {
            buyPrice = stockPricesYesterday[buyTime]
        }
    }
    
    var buyPrice: Double
    
    var sellTime: Int = 0 {
        didSet {
            sellPrice = stockPricesYesterday[sellTime]
        }
    }
    
    var sellPrice: Double
    
    var profit: Double {
        return sellPrice - buyPrice
    }
    
    var isSameTimeTrade: Bool {
        return buyTime == sellTime
    }
    
    
    // MARK: Init
    
    init(buyTime: Int, sellTime: Int) {
        self.buyTime = buyTime
        self.sellTime = sellTime
        self.buyPrice = stockPricesYesterday[buyTime]
        self.sellPrice = stockPricesYesterday[sellTime]
    }
}


// ------------------------------------------------------------------------------------------
// MARK: Main


let stockPricesYesterday: [Double] =  /*[4, 3, 6, 5, 2, 4, 2, 4] */[5, 6, 4, 7, 3, 8, 2, 9, 1] //[500, 400, 510, 680, 690, 700, 1, 710, 691, 685, 630]
var bestTrade: DayTrade?
var possibleTrade = DayTrade(buyTime: 0, sellTime: 0)


func save(trade: DayTrade) {
    if !trade.isSameTimeTrade {
        if trade.profit > bestTrade?.profit {
            bestTrade = possibleTrade
        }
    }
}


// loop through the prices and look for possible trades. We want to make a new trade (instead of mutating the possibleTrade) when the stock price drops below the previous buy price. Otherwise, if the stock price is higher than the buy price, then we check if it's higher than the sell price. If so, overwrite the sell price, otherwise ignore
for (index, stockPrice) in enumerate(stockPricesYesterday) {
    if stockPrice < possibleTrade.buyPrice {
        // found a new potential day trade
        // save the currently listed possible trade
        save(possibleTrade)
        println()
        possibleTrade = DayTrade(buyTime: index, sellTime: index)
    } else if stockPrice > possibleTrade.buyPrice && stockPrice > possibleTrade.sellPrice {
        // found a better time to sell at
        possibleTrade.sellTime = index
    }
}

save(possibleTrade)

if let bestTrade = bestTrade {
    println("bestTrade profit: \(bestTrade.profit), buy: [\(bestTrade.buyTime)]\(bestTrade.buyPrice), sell: [\(bestTrade.sellTime)]\(bestTrade.sellPrice)")
} else {
    println("no profit to be made yesterday")
}




