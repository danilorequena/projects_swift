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
    var message = Message()
    
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
    
    @objc func openActionSheet(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            guard let selectedStudent = managerResults?.fetchedObjects?[(longPress.view?.tag)!] else { return }
            let menu = MenuStudantOptions().configMenuStudantOptions { (option) in
                switch option {
                case .sms:
                    if let messageComponent = self.message.configSMS(selectedStudent) {
                        messageComponent.messageComposeDelegate = self.message
                        self.present(messageComponent, animated: true, completion: nil)
                    }
                    break
                
                case .call:
                    guard let numberOfStudent = selectedStudent.telefone else { return }
                    if let url = URL(string: "tel://\(numberOfStudent)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    break
                    
                case .waze:
                    if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
                        guard let addressStudent = selectedStudent.endereco else {return}
                        Localization().convertAddressCoords(endereco: addressStudent, local: { (localizationFinded) in
                            let latitude = String(describing: localizationFinded.location!.coordinate.latitude)
                            let longitude = String(describing: localizationFinded.location!.coordinate.longitude)
                            let url: String = "waze://?ll=\(latitude),\(longitude)&navigate=yes"
                            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                            
                        })
                    }
                    break
                    
                case .mapas:
                    
                    let map = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Maps") as! MapsViewController
                    map.aluno = selectedStudent
                    self.navigationController?.pushViewController(map, animated: true)
                    
                    break
                
                }
            }
            self.present(menu, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let studantListCount = managerResults?.fetchedObjects?.count else { return 0 }
    
        return studantListCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        cell.tag = indexPath.row
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(openActionSheet(_:)))
        guard let aluno = managerResults?.fetchedObjects![indexPath.row] else { return cell }
        cell.configStudant(aluno)
        cell.addGestureRecognizer(longPress)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let selectedStudant = managerResults?.fetchedObjects! [indexPath.row] else {return}
            context.delete(selectedStudant)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
           
            
            
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
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            tableView.reloadData()
        }
    }
   
    @IBAction func buttonCalculateAverage(_ sender: UIBarButtonItem) {
        guard let listStudent = managerResults?.fetchedObjects else { return }
        CalculateAverage().calculateAverageGeneralStudents(alunos: listStudent, sucesso: { (dictionary) in
            if let alert = Notifications().showNotificationAverageStudents(dictionaryAverage: dictionary) {
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
