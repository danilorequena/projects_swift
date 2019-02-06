//
//  ImagePicker.swift
//  Agenda
//
//  Created by Danilo Requena on 06/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

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

}
