//
//  ViewController.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 28/11/18.
//  Copyright © 2018 Danilo Requena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var localBurguerField: UITextField!
    @IBOutlet  weak var nameBurguerField: UITextField!
    @IBOutlet weak var avaliationField: UITextField?
    @IBOutlet weak var show: UILabel!
    
    
    
    
    @IBAction func add() {
    
        if (localBurguerField == nil || nameBurguerField == nil || avaliationField == nil) {
            
            return
        }
        
    let localBurguer = localBurguerField.text!
    let nameBurguer = nameBurguerField!.text!
    //let happinessComents: String
       
        if let avaliation = Int(avaliationField!.text!){
    let meal = Meal(name: nameBurguer, happiness: avaliation)
       
            show.text = "Aqui no \(localBurguer), comi o hamburguer \(meal.name), e a nota que dou a ele é \(meal.happiness)"
            
             print ("Aqui no \(localBurguer), comi o hamburguer \(meal.name), e a nota que dou a ele é \(meal.happiness)")
        
        
        
            
    view.endEditing(true)
        
        }
        
    }


}

