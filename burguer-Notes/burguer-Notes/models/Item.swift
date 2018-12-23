

import Foundation

class item: Equatable {
    let name: String
    var calories: Double
    var size: String
    
    init(name:String, calories:Double, size:String) {
        self.name = name
        self.calories = calories
        self.size = size
    }
}

func ==(first:item, second:item) -> Bool{
    
    return first.name == second.name && first.calories == second.calories
    
}
