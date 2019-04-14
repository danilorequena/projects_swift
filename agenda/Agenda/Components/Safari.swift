//
//  Safari.swift
//  Agenda
//
//  Created by Danilo Requena on 31/03/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import SafariServices

class Safari: NSObject {

    func abriPaginasWeb(_ selectedStudent:Aluno, controller:UIViewController) {
        if let studentUrl = selectedStudent.site {
            var formatedUrl = studentUrl
            if !formatedUrl.hasPrefix("http://") {
                formatedUrl = String(format: "http://%@", formatedUrl)
            }
            
            guard let url = URL(string: formatedUrl) else {return}
            let safariViewController = SFSafariViewController(url: url)
            controller.present(safariViewController, animated: true, completion: nil)
        }

    }
}
