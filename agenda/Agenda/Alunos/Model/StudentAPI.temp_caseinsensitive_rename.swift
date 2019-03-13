//
//  studentAPI.swift
//  Agenda
//
//  Created by Danilo Requena on 05/03/19.
//  Copyright © 2019 Alura. All rights reserved.


import UIKit
import Alamofire

class StudentAPI: NSObject {
    
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
