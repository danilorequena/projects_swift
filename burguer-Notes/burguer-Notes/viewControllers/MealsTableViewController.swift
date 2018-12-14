

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
        let view = segue.destination as! ViewController
        view.mealsTable = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal.name
        return cell
    }
}


//Teste do git
