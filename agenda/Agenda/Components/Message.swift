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
    
    var delegate:MFMessageComposeViewControllerDelegate?
    
    func setDelegate() -> MFMessageComposeViewControllerDelegate? {
        delegate = self
        
        return delegate
    }
    //MARK: - Metodos
    
    func sendSMS(_ aluno: Aluno, controller: UIViewController)  {
        
        if MFMessageComposeViewController.canSendText() {
            let messageComponent = MFMessageComposeViewController()
            guard let numberOfStudent = aluno.telefone else { return }
            messageComponent.recipients = [numberOfStudent]
            guard let delegate = setDelegate() else { return }
            messageComponent.messageComposeDelegate = delegate
            controller.present(messageComponent, animated: true, completion: nil)
        }
    }
    
    // MARK: - messageComposeDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

}
