//
//  File.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 01/01/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    let controller:UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ title: String = "Sorry!", message: String = "Unexpected Error") {
        let alert = UIAlertController(title: "Sorry!", message: "Unable to update the table", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
        
    }
}
