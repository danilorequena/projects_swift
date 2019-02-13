//
//  CalculateAverage.swift
//  Agenda
//
//  Created by Danilo Requena on 13/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class CalculateAverage: NSObject {
    
    func calculateAverageGeneralStudents(alunos: Array<Aluno>, sucesso: @escaping(
        _ dictionaryAverage:Dictionary<String, Any>) -> Void, falha: @escaping(_ error:Error) -> Void) {
        guard let url = URL(string: "https://www.caelum.com.br/mobile") else {return}
        var listStudents: Array<Dictionary<String, Any>> = []
        var json: Dictionary<String, Any> = [:]
        
        for aluno in alunos {
        
            guard let nome = aluno.nome else {break}
            guard let endereco = aluno.endereco else {break}
            guard let telefone = aluno.telefone else {break}
            guard let site = aluno.site else {break}
            
            let dictionaryStudents = [
                "id": "\(aluno.objectID)",
                "nome": nome,
                "endereco": endereco,
                "telefone": telefone,
                "site": site,
                "nota": String(aluno.nota)
            ]
            listStudents.append(dictionaryStudents as [String:Any])
        }
        
        
        
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
                        let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                        sucesso(dictionary)
                    } catch {
                        falha(error)
                    }
                    
                    
                }
                
            }
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
}
