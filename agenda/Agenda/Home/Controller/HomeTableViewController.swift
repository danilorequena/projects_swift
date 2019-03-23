//
//  HomeTableViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Variáveis

    let searchController = UISearchController(searchResultsController: nil)
    var alunoviewController:AlunoViewController?
    var message = Message()
    var students: Array<Aluno> = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuraSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        catchStudent()
    }
    
    // MARK: - Métodos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEdit" {
            alunoviewController = segue.destination as? AlunoViewController
        }
    }
    
    func catchStudent() {
        Repository().catchStudents { (listOfStudent) in
            self.students = listOfStudent
            self.tableView.reloadData()

        }
    }
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    @objc func openActionSheet(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            let selectedStudent = students[(longPress.view?.tag)!]
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
                    
                case .openPagesWeb:
                    if let studentUrl = selectedStudent.site {
                        var formatedUrl = studentUrl
                        if !formatedUrl.hasPrefix("http://") {
                            formatedUrl = String(format: "http://%@", formatedUrl)
                        }
                        
                        guard let url = URL(string: formatedUrl) else {return}
                        let safariViewController = SFSafariViewController(url: url)
                        self.present(safariViewController, animated: true, completion: nil)
                    }
                }
            }
            self.present(menu, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        cell.tag = indexPath.row
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(openActionSheet(_:)))
        let student = students[indexPath.row]
        cell.configStudant(student)
        cell.addGestureRecognizer(longPress)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocationAuthenticity().autorizationUser { (authenticated) in
                if authenticated {
                    DispatchQueue.main.async {
//                        guard let selectedStudant = self.managerResults?.fetchedObjects! [indexPath.row] else {return}
//                        self.context.delete(selectedStudant)
//
//                        do {
//                            try self.context.save()
//                        } catch {
//                            print(error.localizedDescription)
//                        }
                    }
                }
                
            }
        
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStudent = students[indexPath.row]
        alunoviewController?.aluno = selectedStudent
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
        CalculateAverage().calculateAverageGeneralStudents(alunos: students, sucesso: { (dictionary) in
            if let alert = Notifications().showNotificationAverageStudents(dictionaryAverage: dictionary) {
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    @IBAction func buttonGeneralLocalization(_ sender: UIBarButtonItem) {
        let mapa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Maps") as! MapsViewController
        navigationController?.pushViewController(mapa, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
    }
    
}
