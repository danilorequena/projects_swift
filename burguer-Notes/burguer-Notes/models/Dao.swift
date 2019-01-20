//
//  Dao.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 19/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation

class Dao {
    func saveMeals(meals:Array<Meal>) {
        NSKeyedArchiver.archiveRootObject(meals, toFile: getArchive())
        
        
    }
    
    func getArchive() -> String {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        let archive = "\(dir)/burguer-NotesMeals.dados"
        return archive
    }
    
    func loadMeals() -> Array<Meal> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: getArchive()) {
            let meals = loaded as! Array<Meal>
            return meals
        }
        return Array<Meal>()
        
    }
}
