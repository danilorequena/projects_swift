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
            guard let navigation = navigationController else { return }
            let menu = MenuStudantOptions().configMenuStudantOptions(navigation: navigation, alunoSelecionado: selectedStudent)
            present(menu, animated: true, completion: nil)
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
                        let alunoSelecionando = self.students[indexPath.row]
                        Repository().deletaAluno(aluno: alunoSelecionando)
                        self.students.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
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
        if let texto = searchBar.text {
            students = Filtro().filtraAlunos(listaDeAlunos: students, texto: texto)
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        students = StudentDAO().catchStudent()
        tableView.reloadData()
    }
    
}
