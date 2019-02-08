//
//  Message.swift
//  Agenda
//
//  Created by Danilo Requena on 08/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MessageUI

class Message: NSObject, MFMessageComposeViewControllerDelegate {
    
    //MARK: - Metodos
    
    func configSMS(_ aluno: Aluno) -> MFMessageComposeViewController?  {
        
        if MFMessageComposeViewController.canSendText() {
            let messageComponent = MFMessageComposeViewController()
            guard let numberOfStudent = aluno.telefone else { return messageComponent }
            messageComponent.recipients = [numberOfStudent]
            messageComponent.messageComposeDelegate = self
            
            return messageComponent
        }
        return nil
    }
    
    // MARK: - messageComposeDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

}
