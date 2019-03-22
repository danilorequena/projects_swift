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

}
