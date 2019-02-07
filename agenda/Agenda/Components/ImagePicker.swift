//
//  ImagePicker.swift
//  Agenda
//
//  Created by Danilo Requena on 06/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

enum MenuOptions {
    case camera
    case library
}

protocol ImagePickerSelectedPhoto {
    func imagePickerSelectedPhoto(_ picture: UIImage)
}


class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //MARK: Atributes
    
    var delegate:ImagePickerSelectedPhoto?
    
    // MARK: Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let picture = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagePickerSelectedPhoto(picture)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func menuOptions(complition: @escaping(_ opcao: MenuOptions) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "Escolha umas das opções abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Câmera", style: .default) { (action) in
            complition(.camera)
        }
        menu.addAction(camera)
        
        let library = UIAlertAction(title: "Library", style: .default) { (action) in
            complition(.library)
        }
        menu.addAction(library)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancel)
        
        return menu
    }

}
