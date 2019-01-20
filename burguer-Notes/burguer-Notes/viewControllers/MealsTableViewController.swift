

import UIKit

class MealsTableViewController : UITableViewController {
    
    var meals = Array<Meal>()
    
    // adicionando elementos na tabela
    func add(meal:Meal) {
        meals.append(meal)
        Dao().saveMeals(meals: meals)
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        self.meals = Dao().loadMeals()
       
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
            
            RemoveMealController(controller: self).show(meal, handler: { action in
                self.meals.remove(at: row)
                self.tableView.reloadData()
            })
           
            }
            
        }
        
        
    }
    
    
}


//Teste do git
