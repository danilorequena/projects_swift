

import Foundation


class Meal: NSObject ,NSCoding {
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
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.happiness = aDecoder.decodeInteger(forKey: "happiness")
        self.items = aDecoder.decodeObject(forKey: "items") as! Array
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(happiness, forKey: "happiness")
        aCoder.encode(items, forKey: "items")
    }
    
    func allcalories() -> Double {
        var total = 0.0
        for item in items {
            total += item.calories
        }
        return total
    }
    
    func details() -> String {
        var message = "Happines: \(happiness)"
        for item in items {
            message += "\n \(item.name) - calorias: \(item.calories)"
    }
        return message
  }
}
