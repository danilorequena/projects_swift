//
//  imagePicker.swift
//  Agenda
//
//  Created by Danilo Requena on 06/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class imagePicker: NSObject, UIImagePickerControllerDelegate {
    
    //MARK: Atributes
    
    // MARK: Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let picture = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        picker.dismiss(animated: true, completion: nil)
    }

}
