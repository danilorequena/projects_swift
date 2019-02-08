//
//  Lacalization.swift
//  Agenda
//
//  Created by Danilo Requena on 08/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import CoreLocation

class Localization: NSObject {
    
    func convertAddressCoords(endereco:String, local: @escaping(_ local: CLPlacemark)-> Void) {
        let converter = CLGeocoder()
        converter.geocodeAddressString(endereco) { (localizationList, error) in
            if let localization = localizationList?.first {
                local(localization)
            }
        }
    }

}
