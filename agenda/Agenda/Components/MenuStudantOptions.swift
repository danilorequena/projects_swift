//
//  MenuStudantOptions.swift
//  Agenda
//
//  Created by Danilo Requena on 07/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

enum MenuActionSheetStudant {
    case sms
}

class MenuStudantOptions: NSObject {
    func configMenuStudantOptions(complition: @escaping(_ option: MenuActionSheetStudant) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "escolha uma das opções abaixo:", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "enviar sms", style: .default) { (action) in
            complition(.sms)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(sms)
        menu.addAction(cancel)
        
        return menu
    }

}
