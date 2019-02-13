//
//  CalculateAverage.swift
//  Agenda
//
//  Created by Danilo Requena on 13/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class CalculateAverage: NSObject {
    
    func calculateAverageGeneralStudents() {
        guard let url = URL(string: "https://www.caelum.com.br/mobile") else {return}
        var listStudents: Array<Dictionary<String, Any>> = []
        var json: Dictionary<String, Any> = [:]
        
        let dictionaryStudents = [
            "id": "1",
            "nome": "Danilo",
            "endereco": "Rua Ali perto, São Paulo",
            "telefone": "9999-8989",
            "site": "www.alura.com.br",
            "nota": "9"
        ]
        listStudents.append(dictionaryStudents as [String:Any])
        
        json = [
            "list": [
                ["aluno": listStudents]
            ]
        ]
        
        
        do {
            var request =  URLRequest(url: url)
            var data = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(dictionary)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    
                }
                
            }
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
}
