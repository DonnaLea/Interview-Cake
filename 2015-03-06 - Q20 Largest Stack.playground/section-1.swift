// Playground - noun: a place where people can play

// Interview Cake: Largest Stack
// https://www.interviewcake.com/question/largest-stack


class Stack<T: Comparable> {
    
    // MARK: Properties
    
    var items = [T]()
    
    
    // MARK: Basic Stack functions
    
    func push(item: T) {
        items.append(item)
    }
    
    
    func pop() -> T? {
        if items.count > 0 {
            return items.removeLast()
        } else {
            return nil
        }
    }
    
    
    func peek() -> T? {
        return items.last
    }
}


class MaxStack<T: Comparable>: Stack<T> {
    
    var maxItems = Stack<T>()
    
    override func push(item: T) {
        super.push(item)
        if item >= maxItems.peek() {
            maxItems.push(item)
        }
    }
    
    
    override func pop() -> T? {
        let poppedItem = super.pop()
        if let poppedItem = poppedItem {
            if poppedItem == maxItems.peek() {
                maxItems.pop()
            }
        }
        
        return poppedItem
    }
    
    
    func getMax() -> T? {
        return maxItems.peek()
    }
    
}


var maxStack = MaxStack<Int>()
maxStack.push(1)
maxStack.maxItems
maxStack.push(2)
maxStack.maxItems
maxStack.push(3)
maxStack.maxItems
maxStack.push(2)
maxStack.maxItems
maxStack.push(3)
maxStack.maxItems
maxStack.pop()
maxStack.maxItems
maxStack.pop()
maxStack.maxItems
maxStack.pop()
maxStack.maxItems
maxStack.pop()
maxStack.pop()
maxStack.pop()
maxStack.getMax()
