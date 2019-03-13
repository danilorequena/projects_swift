//
//  Repository.swift
//  Agenda
//
//  Created by Danilo Requena on 13/03/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Repository: NSObject {
    
    func saveStudent(aluno: Dictionary<String, String>) {
        StudentAPI().saveStudentOnServer(parameters: [aluno])
        StudentDAO().saveStudent(alunoDictionary: aluno)
    }

}
