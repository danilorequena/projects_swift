//
//  studentAPI.swift
//  Agenda
//
//  Created by Danilo Requena on 05/03/19.
//  Copyright © 2019 Alura. All rights reserved.


import UIKit
import Alamofire


class StudentAPI: NSObject {
    
    // MARK: GET
    
    func recoverStudent(completion: @escaping() -> Void) {
        Alamofire.request("http://10.0.1.19:8080/api/aluno", method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String, Any> {
                    guard let listOfStudents = resposta["alunos"] as? Array<Dictionary<String, Any>> else {return}
                    for dicionarioDeAlunos in listOfStudents {
                        StudentDAO().saveStudent(alunoDictionary: dicionarioDeAlunos)
                    }
                    completion()
                }
                
                break
            case .failure:
                print(response.error!)
                completion()
                break
            }
        }
        
    }
    
    // MARK: - PUT
    
    func saveStudentOnServer(parameters:Array<Dictionary<String, String>>) {
        guard let url = URL(string: "http://10.0.1.19:8080/api/aluno/lista") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let json = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = json
        request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(request)
    }

}
