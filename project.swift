import Cocoa

let pi = 3.14

enum Trgnm {
    case sin, cos, tg, ctg
}

var radToDgr = { (num: Double) -> Int in
    print("\(num) rad = \(Int((num / pi) * 180))º")
    return Int((num / pi) * 180)
}

var period = { (num: Int, fnc: Trgnm) -> Int in
    let k: Int = fnc == Trgnm.sin || fnc == Trgnm.cos ? 360 : 180
    
    if num <= k && num >= 0 {
        return num
    }
    print("\(fnc)(\(num)º) = \(fnc)(\(num > 0 ? Int(num - Int((num / k) * k)) : Int(num + Int(((-num / k) + 1) * k))))º")
    
    return num > 0 ? Int(num - Int((num / k) * k)) : Int(num + Int(((-num / k) + 1) * k))
}

var formula = { (num: Double, fnc: Trgnm, isRadian: Bool, cofunc: Bool) -> String in
    let degree = isRadian ? period(radToDgr(num), fnc) : period(Int(num), fnc)
    var isNegative: Bool
    
    switch fnc {
    case .sin:
        if degree <= 180 {
            isNegative = false
        } else {
            isNegative = true
        }
    case .cos:
        if degree <= 90 || degree >= 270 {
            isNegative = false
        } else {
            isNegative = true
        }
    default:
        if degree <= 90 || (degree >= 180 && degree <= 270)  {
            isNegative = false
        } else {
            isNegative = true
        }
    }
    
    if !cofunc {
        if degree <= 90 {
            return "\(fnc)(\(degree)º) = \(fnc)(\(degree)º)"
        } else {
            return "\(fnc)(\(degree))º = \(isNegative ? "-" : "")\(fnc)(\(degree <= 270 ? abs(degree - 180) : abs(degree - 360))º)"
        }
    } else {
        var cofunc: Trgnm
        
        switch fnc {
        case .sin:
            cofunc = .cos
        case .cos:
            cofunc = .sin
        case .tg:
            cofunc = .ctg
        case .ctg:
            cofunc = .tg
        }
        
        return "\(fnc)(\(degree)º) = \(isNegative ? "-" : "")\(cofunc)(\(degree <= 180 ? abs(degree - 90) : abs(degree - 270)))º"
    }
}
