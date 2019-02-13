//
//  Notifications.swift
//  Agenda
//
//  Created by Danilo Requena on 13/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Notifications: NSObject {
    
    func showNotificationAverageStudents(dictionaryAverage: Dictionary<String, Any>) -> UIAlertController? {
        if let media = dictionaryAverage["media"] as? String {
            let alert = UIAlertController(title: "Atenção", message: "A média geral dos alunos é \(media)", preferredStyle: .alert)
            let button = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(button)
            return alert
        }
        return nil
    }

}
