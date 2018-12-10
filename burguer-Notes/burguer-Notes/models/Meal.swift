

import Foundation


class Meal {
    let name: String
    var happiness: Int
    //var happinessComents: String
    var items = Array<item>()
    
    init(name:String, happiness:Int /*, happinessComents:String*/) {
        self.name = name
        self.happiness = happiness
       // self.happinessComents = happinessComents
    }
    
    func allcalories() -> Double {
        var total = 0.0
        for item in items {
            total += item.calories
        }
        return total
    }
}
