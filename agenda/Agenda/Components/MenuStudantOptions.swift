//
//  MenuStudantOptions.swift
//  Agenda
//
//  Created by Danilo Requena on 07/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class MenuStudantOptions: NSObject {
    func configMenuStudantOptions(navigation:UINavigationController, alunoSelecionado:Aluno) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "escolha uma das opções abaixo:", preferredStyle: .actionSheet)
        guard let viewController = navigation.viewControllers.last else { return menu }
        let sms = UIAlertAction(title: "enviar sms", style: .default) { (action) in
            Message().sendSMS(alunoSelecionado, controller: viewController)
        }
        menu.addAction(sms)
       
        let call = UIAlertAction(title: "📞Ligar", style: .default) { (action) in
            LigacaoTelefonica().fazLigacao(alunoSelecionado)
        }
         menu.addAction(call)
        
        let waze = UIAlertAction(title: "Waze", style: .default) { (action) in
            Localization().localizacaoWaze(alunoSelecionado)
        }
        menu.addAction(waze)
        
        let mapas = UIAlertAction(title: "Mapas", style: .default) { (action) in
            let map = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Maps") as! MapsViewController
            map.aluno = alunoSelecionado
           navigation.pushViewController(map, animated: true)

        }
        menu.addAction(mapas)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancel)
        
        let openPagesWeb = UIAlertAction(title: "Abrir Página da Web", style: .default) { (action) in
           Safari().abriPaginasWeb(alunoSelecionado, controller: viewController)
        }
        menu.addAction(openPagesWeb)
        
       
        
        return menu
    }

}
