//
//  ViewController.swift
//  burguer-Notes
//
//  Created by Danilo Requena on 28/11/18.
//  Copyright © 2018 Danilo Requena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {

    
    @IBOutlet weak var localBurguerField: UITextField!
    @IBOutlet  weak var nameBurguerField: UITextField!
    @IBOutlet weak var avaliationField: UITextField?
    @IBOutlet weak var show: UILabel!
    
    var delegate : MealsTableViewController?
    
    var selected = Array<item>()
    
    var itens = [
        item(name: "Cheese", calories: 40, size: "Small"),
        item(name: "Burguer", calories: 150, size: "medium"),
        item(name: "Salad", calories: 20, size: "Small"),
        item(name: "Bacon", calories: 100, size: "Medium")
    ]
    
    @IBOutlet var tableview:UITableView?
    
    func add(_ item: item) {
        itens.append(item)
        if let table = tableview {
            table.reloadData()
        } else {
           Alert(controller: self).show()
        }
        
        //        tableview?.reloadData() -> Esse optional Chaining "?" Funciona como se fosse um If mas sem um else
        

    }
    
    override func viewDidLoad() {
        let newButtonItem = UIBarButtonItem(title: "New Item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showNewItem))
        navigationItem.rightBarButtonItem = newButtonItem
    }
    
    @objc func showNewItem() {
        
      let newItem = NewItemViewController(delegate: self)
        navigationController?.pushViewController(newItem, animated: true)
        
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        } else {
            Alert(controller: self).show(message: "Algo deu errado")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if (cell.accessoryType == UITableViewCell.AccessoryType.none){
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                let item = itens[indexPath.row]
                selected.append(item)
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
                let item = itens[indexPath.row]
                if let position = selected.index(of: item){
                    selected.remove(at: position)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = itens[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = item.name
        return cell
    }
    
    
    func convertToInt( _ text:String?) -> Int? {
        if let number = text {
            return Int(number)
    }
        return nil
    }
    
    
    func getFromForm() -> Meal? {
        if let name = nameBurguerField?.text {
            if let happiness = convertToInt(avaliationField?.text) {
                let meal = Meal(name: name, happiness: happiness, items: selected)
                
                print ("Comi o hamburguer \(meal.name), e a nota que dou a ele é \(meal.happiness) com os itens \(meal.items)")
                return meal
            }
        }
        return nil
    }
    
    @IBAction func add() {
    
        if let meal = getFromForm() {
            if let meals = delegate {
            meals.add(meal: meal)
                if let navigation = navigationController {
                navigation.popViewController(animated: true)
                    return
                } else {
                    Alert(controller: self).show()
                   
                }
                 return
                
            }
            
            Alert(controller: self).show()
            
        }
       
//            show.text = "Aqui no \(localBurguer), comi o hamburguer \(meal.name), e a nota que dou a ele é \(meal.happiness)"
//            navigationController?.popViewController(animated: true) -->  nesse caso tem o optional, o jeito abaixo é o modo seguro
            
        view.endEditing(true)
        
        }
        
    }




