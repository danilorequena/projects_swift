//
//  RemoveMealController.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 06/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class RemoveMealController{
    let controller: UIViewController
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert )
        
        //            func removeSelected(action: UIAlertAction) {
        //                meals.remove(at: row)
        //                tableView.reloadData()
        //            }
        
        let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: handler)
        details.addAction(remove)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        details.addAction(cancel)
        
        controller.present(details, animated: true, completion: nil)
    }
}
