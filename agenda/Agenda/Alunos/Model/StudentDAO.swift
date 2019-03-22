//
//  StudentDAO.swift
//  Agenda
//
//  Created by Danilo Requena on 13/03/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import CoreData

class StudentDAO: NSObject {
    
    var managerResults:NSFetchedResultsController<Aluno>?
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func catchStudent() -> Array<Aluno> {
        let searchStudent:NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let orderByName = NSSortDescriptor(key: "nome", ascending: true)
        searchStudent.sortDescriptors = [orderByName]
        
      
        
        managerResults = NSFetchedResultsController(fetchRequest: searchStudent, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try managerResults?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let listOfStudent = managerResults?.fetchedObjects else { return [] }
        
        return listOfStudent
    }
    
    func saveStudent(alunoDictionary: Dictionary<String, Any>) {
        let aluno = Aluno(context: context)
        
        aluno.nome = alunoDictionary["nome"] as? String
        aluno.endereco = alunoDictionary["endereco"] as? String
        aluno.telefone = alunoDictionary["telefone"] as? String
        aluno.site = alunoDictionary["site"] as? String
        
        guard let nota = alunoDictionary["nota"] else { return }
        if (nota is String) {
            aluno.nota = (alunoDictionary["nota"] as! NSString).doubleValue
        } else {
            let conversaoNota = String(describing: nota)
            aluno.nota = (conversaoNota as NSString).doubleValue
        }
        
        refreshContext()
        

    }
    
    func refreshContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    

}
