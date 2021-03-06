//
//  Lacalization.swift
//  Agenda
//
//  Created by Danilo Requena on 08/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class Localization: NSObject, MKMapViewDelegate {
    
    func localizacaoWaze(_ selectedStudent:Aluno) {
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            guard let addressStudent = selectedStudent.endereco else {return}
            Localization().convertAddressCoords(endereco: addressStudent, local: { (localizationFinded) in
                let latitude = String(describing: localizationFinded.location!.coordinate.latitude)
                let longitude = String(describing: localizationFinded.location!.coordinate.longitude)
                let url: String = "waze://?ll=\(latitude),\(longitude)&navigate=yes"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            })
        }
    }
    
    func convertAddressCoords(endereco:String, local: @escaping(_ local: CLPlacemark)-> Void) {
        let converter = CLGeocoder()
        converter.geocodeAddressString(endereco) { (localizationList, error) in
            if let localization = localizationList?.first {
                local(localization)
            }
        }
    }
    
    func configPin(title: String, localization: CLPlacemark, color: UIColor?, icon: UIImage?) -> Pin {
        let pin = Pin(coordinate: localization.location!.coordinate)
        pin.title = title
        pin.color = color
        pin.icon = icon
        
        return pin
    }
    
    func configButtonLocalizationCurrent(map: MKMapView) -> MKUserTrackingButton {
        let button = MKUserTrackingButton(mapView: map)
        button.frame.origin.x = 10
        button.frame.origin.y = 10
        
        
        return button
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is Pin {
            let annotationView = annotation as! Pin
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationView.title!) as? MKMarkerAnnotationView
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationView.title)
            
            pinView?.annotation = annotationView
            pinView?.glyphImage = annotationView.icon
            pinView?.markerTintColor = annotationView.color
            
            return pinView
        }
        
        return nil
    }

}
