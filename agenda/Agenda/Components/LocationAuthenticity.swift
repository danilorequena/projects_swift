//
//  LocationAuthenticity.swift
//  Agenda
//
//  Created by Danilo Requena on 13/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import LocalAuthentication

class LocationAuthenticity: NSObject {
    
    func autorizationUser(complition: @escaping(_ authenticated: Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "É necessário autenticação para apagar o arquivo") { (answer, error) in
                complition(answer)
            }
        }
    }

}
