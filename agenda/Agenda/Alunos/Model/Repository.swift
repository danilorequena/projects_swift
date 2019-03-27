//
//  Repository.swift
//  Agenda
//
//  Created by Danilo Requena on 13/03/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Repository: NSObject {
    
    func catchStudents(completion: @escaping(Array<Aluno>) -> Void) {
        var students = StudentDAO().catchStudent()
        if students.count == 0 {
            StudentAPI().recoverStudent {
                students = StudentDAO().catchStudent()
                completion(students)
            }
        } else {
            completion(students)
        }
        
    }
    
    func saveStudent(aluno: Dictionary<String, String>) {
        StudentAPI().saveStudentOnServer(parameters: [aluno])
        StudentDAO().saveStudent(alunoDictionary: aluno)
    }
    
    func deletaAluno(aluno:Aluno) {
        guard let id = aluno.id else { return }
        StudentAPI().deletaAluno(id: String(describing: id).lowercased())
        StudentDAO().deletaAluno(aluno: aluno)
    }
    
    func sincronizaAluno() {
        let alunos = StudentDAO().catchStudent()
        var listaDeAlunos:Array<Dictionary<String, String>> = []
        for aluno in alunos {
            guard let id = aluno.id else { return }
            let parametros:Dictionary<String, String> = [
                "id" : String(describing: id).lowercased(),
                "nome" : aluno.nome ?? "",
                "endereco" : aluno.endereco ?? "",
                "telefone" : aluno.telefone ?? "",
                "site" : aluno.site ?? "",
                "nota" : "\(aluno.nota)"
            ]
            listaDeAlunos.append(parametros)
        }
        StudentAPI().saveStudentOnServer(parameters: listaDeAlunos)
    }

}
