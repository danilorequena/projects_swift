

import Foundation


class Meal {
    let name: String
    let happiness: Int
    //var happinessComents: String
    let items:Array<item>
    
    init(name:String, happiness:Int, items: Array<item> /*, happinessComents:String*/) {
        self.name = name
        self.happiness = happiness
        self.items = items
       // self.happinessComents = happinessComents
    }
    
    init(name:String, happiness:Int) {
        self.name = name
        self.happiness = happiness
        self.items = []
    }
    
    func allcalories() -> Double {
        var total = 0.0
        for item in items {
            total += item.calories
        }
        return total
    }
}
