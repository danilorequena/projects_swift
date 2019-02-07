//
//  HomeTableViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    
    //MARK: - Variáveis
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    let searchController = UISearchController(searchResultsController: nil)
    var managerResults:NSFetchedResultsController<Aluno>?
    var alunoviewController:AlunoViewController?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuraSearch()
        self.catchStudent()
        
    }
    
    // MARK: - Métodos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEdit" {
            alunoviewController = segue.destination as? AlunoViewController
        }
    }
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    func catchStudent() {
        let searchStudent:NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let orderByName = NSSortDescriptor(key: "nome", ascending: true)
        searchStudent.sortDescriptors = [orderByName]
        
        managerResults = NSFetchedResultsController(fetchRequest: searchStudent, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        managerResults?.delegate = self
        
        do{
            try managerResults?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let studantListCount = managerResults?.fetchedObjects?.count else { return 0 }
    
        return studantListCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        guard let aluno = managerResults?.fetchedObjects![indexPath.row] else { return cell }
        cell.configStudant(aluno)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedStudant = managerResults?.fetchedObjects! [indexPath.row] else { return  }
        alunoviewController?.aluno = selectedStudant
    }
    
    // MARK: - FetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            //Implementar
            break
        default:
            tableView.reloadData()
        }
    }

}
