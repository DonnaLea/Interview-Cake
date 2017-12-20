// Playground - noun: a place where people can play

// Interview Cake Q2: Product of Integers
// https://www.interviewcake.com/question/product-of-other-numbers

func productOfOtherNumbers1(array: [Int]) -> [Int] {
    var productArray = [Int]()
    let duplicateArray = array
    
    for (numberIndex, number) in enumerate(array) {
        var product = 1
        for (otherNumberIndex, otherNumber) in enumerate(array) {
            if otherNumberIndex != numberIndex {
                product *= otherNumber
            }
        }

        productArray.append(product)
    }
    
    return productArray
}


productOfOtherNumbers1([0, 7, 3, 4])


func productOfOtherNumbers(array: [Int]) -> [Int] {
    var productArray = [Int](count: countElements(array), repeatedValue: 1)
    var beforeProduct = 1
    var afterProduct = 1
    
    for (numberIndex, number) in enumerate(array) {
        let product = beforeProduct
        beforeProduct *= number
        
        productArray[numberIndex] *= product
    }
    
    productArray
    
    for var numberIndex = countElements(array)-1; numberIndex >= 0; --numberIndex {
        let number = array[numberIndex]
        let product = afterProduct
        
        productArray[numberIndex] *= product
        afterProduct *= number
    }
    
    return productArray
}

productOfOtherNumbers([1, 7, 3, 4])