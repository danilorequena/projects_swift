

import Foundation

class item: NSObject, NSCoding {
    let name: String
    var calories: Double
    var size: String
    
    init(name:String, calories:Double, size:String) {
        self.name = name
        self.calories = calories
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.calories = aDecoder.decodeDouble(forKey: "calories")
        self.size = aDecoder.decodeObject(forKey: "size") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(calories, forKey: "calories")
        aCoder.encode(size, forKey: "size")
        
    }
}



func ==(first:item, second:item) -> Bool{
    
    return first.name == second.name && first.calories == second.calories
    
}
