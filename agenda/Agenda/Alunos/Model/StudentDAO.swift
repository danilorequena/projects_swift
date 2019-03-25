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
        var aluno:NSManagedObject?
        guard let id = UUID(uuidString: alunoDictionary["id"] as! String) else { return }
        
        let alunos = catchStudent().filter() { $0.id == id}
        
        if alunos.count > 0 {
            guard let alunoEncontrado = alunos.first else {return}
            aluno = alunoEncontrado
        } else {
            let entidade = NSEntityDescription.entity(forEntityName: "Aluno", in: context)
            aluno = NSManagedObject(entity: entidade!, insertInto: context)
        }
        
        aluno?.setValue(id, forKey: "id")
        aluno?.setValue(alunoDictionary["nome"] as? String, forKey: "nome")
        aluno?.setValue(alunoDictionary["endereco"] as? String, forKey: "endereco")
        aluno?.setValue(alunoDictionary["telefone"] as? String, forKey: "telefone")
        aluno?.setValue(alunoDictionary["site"] as? String, forKey: "site")
        
        guard let nota = alunoDictionary["nota"] else { return }
        if (nota is String) {
            aluno?.setValue((alunoDictionary["nota"] as! NSString).doubleValue, forKey: "nota")
        } else {
            let conversaoNota = String(describing: nota)
            aluno?.setValue((conversaoNota as NSString).doubleValue, forKey: "nota")
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
