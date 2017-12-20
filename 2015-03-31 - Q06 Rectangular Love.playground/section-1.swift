// Interview Cake Q06: Rectangular Love
// https://www.interviewcake.com/question/rectangular-love

typealias LoveRectangle = [String: Int]

let x = "x"
let y = "y"
let w = "width"
let h = "height"

func loveIntersection(loveRectangle1: LoveRectangle, loveRectangle2: LoveRectangle) -> LoveRectangle {
    var loveRectangle = LoveRectangle()
    
    if containsElements(loveRectangle1) && containsElements(loveRectangle2) {
        if intersects(loveRectangle1, loveRectangle2) {
            loveRectangle[x] = loveRectangle2[x]
            loveRectangle[y] = loveRectangle2[y]
            loveRectangle[w] = min(loveRectangle2[x]! + loveRectangle2[w]!, loveRectangle1[x]! + loveRectangle1[w]!) - max(loveRectangle1[x]!, loveRectangle2[x]!)
            loveRectangle[h] = min(loveRectangle2[y]! + loveRectangle2[h]!, loveRectangle1[y]! + loveRectangle1[h]!) - max(loveRectangle1[y]!, loveRectangle2[y]!)
        } else if intersects(loveRectangle2, loveRectangle1) {
            loveRectangle[x] = loveRectangle1[x]
            loveRectangle[y] = loveRectangle1[y]
            loveRectangle[w] = min(loveRectangle2[x]! + loveRectangle2[w]!, loveRectangle1[x]! + loveRectangle1[w]!) - max(loveRectangle1[x]!, loveRectangle2[x]!)
            loveRectangle[h] = min(loveRectangle2[y]! + loveRectangle2[h]!, loveRectangle1[y]! + loveRectangle1[h]!) - max(loveRectangle1[y]!, loveRectangle2[y]!)
        }
    }
    
    return loveRectangle
}


func containsElements(loveRectangle: LoveRectangle) -> Bool {
    if loveRectangle[x] != nil && loveRectangle[y] != nil && loveRectangle[w] != nil && loveRectangle[h] != nil {
        return true
    } else {
        return false
    }
}

func intersects(loveRectangle1: LoveRectangle, loveRectangle2: LoveRectangle) -> Bool {
    if (loveRectangle2[x]! < loveRectangle1[x]! + loveRectangle1[w]! && loveRectangle2[x]! > loveRectangle1[x]!) &&
        (loveRectangle2[y]! < loveRectangle1[y]! + loveRectangle1[w]! && loveRectangle2[y]! > loveRectangle1[y]!) {
        return true
    }
    
    return false
}


let loveRectangle1: LoveRectangle = [x: 2, y: 2, w: 2, h: 2]
//let loveRectangle2: LoveRectangle = [x: 3, y: 3, w: 4, h: 4]
let loveRectangle2: LoveRectangle = [x: 4, y: 2, w: 4, h: 4]

let loveIntersect = loveIntersection(loveRectangle1, loveRectangle2)