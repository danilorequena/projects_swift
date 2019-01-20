//
//  Dao.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 19/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation

class Dao {
    
    let mealsArchive: String
    let itemsArchive: String
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
         mealsArchive = "\(dir)/burguer-NotesMeals.dados"
         itemsArchive = "\(dir)/burguer-NotesItems.dados"
    }
    
    
    func saveMeals(_ meals:Array<Meal>) {
        NSKeyedArchiver.archiveRootObject(meals, toFile: mealsArchive)
        
        
    }
    
    
    
    func loadMeals() -> Array<Meal> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: mealsArchive) {
            let meals = loaded as! Array<Meal>
            return meals
        }
        return Array<Meal>()
        
    }
    
    func loadItems() -> Array<item> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: itemsArchive) {
           let items = loaded as! Array<item>
           return items
        }
        
        return []
    }
    
    func saveItems(_ items:Array<item>) {
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsArchive)
    }
}
