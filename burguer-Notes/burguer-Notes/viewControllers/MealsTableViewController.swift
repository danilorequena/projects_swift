

import UIKit

class MealsTableViewController : UITableViewController {
    
    var meals = [Meal(name: "Oraculo Burguer", happiness: 10),
                Meal(name: "Five Guy burguer", happiness: 10),
                Meal(name: "Hard Rock Burguer", happiness: 8),
                Meal(name: "Outback Burguer", happiness: 10)]
    
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
