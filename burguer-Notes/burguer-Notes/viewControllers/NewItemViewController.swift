//
//  NewItemViewController.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 25/12/18.
//  Copyright © 2018 Danilo Requena. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {

    var delegate:AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate) {
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    @IBOutlet var textFieldName:UITextField?
    @IBOutlet var textFieldCalories:UITextField?
    
    @IBAction func addNewItem() {
        
        let name = textFieldName!.text
        let calories = Double(textFieldCalories!.text!)
        
        if name == nil || calories == nil || delegate == nil {
            return
        }
        
        let iten = item(name: name!, calories: calories!, size: "Big")
        delegate?.add(iten)
        
//        if delegate == nil {
//            return                   -> Essa solução foi resolvida colocando a mesma coisa no if logo acima
 //        }
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
