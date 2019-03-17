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
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
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
