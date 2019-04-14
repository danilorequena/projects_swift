//
//  LigacaoTelefonica.swift
//  Agenda
//
//  Created by Danilo Requena on 31/03/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefonica: NSObject {
    
    func fazLigacao(_ selectedStudent:Aluno) {
        guard let numberOfStudent = selectedStudent.telefone else { return }
        if let url = URL(string: "tel://\(numberOfStudent)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

    }

}
