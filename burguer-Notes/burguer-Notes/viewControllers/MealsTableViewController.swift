

import UIKit

class MealsTableViewController : UITableViewController {
    
    var meals = [Meal(name: "Oraculo Burguer", happiness: 10),
                Meal(name: "Five Guy burguer", happiness: 10),
                Meal(name: "Hard Rock Burguer", happiness: 8),
                Meal(name: "Outback Burguer", happiness: 10)]
    
    // adicionando elementos na tabela
    func add(meal:Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addMeal") {
        let view = segue.destination as! ViewController
        view.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal.name
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPressRecognizer)
        
        
        
        return cell
    }
    
    @objc func showDetails(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.began {
            let cell = recognizer.view as! UITableViewCell
         if let indexPath = tableView.indexPath(for: cell) {
            let row = indexPath.row
            let meal = meals[row]
            
            let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert )
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            details.addAction(ok)
            
            present(details, animated: true, completion: nil)
           
            }
            
        }
        
        
    }
}


//Teste do git
