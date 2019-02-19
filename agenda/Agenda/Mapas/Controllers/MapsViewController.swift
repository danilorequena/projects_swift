//
//  MapsViewController.swift
//  Agenda
//
//  Created by Danilo Requena on 12/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    //MARK: - Variaveis
    
    var aluno: Aluno?
    lazy var localization = Localization()
    lazy var managerLocalization = CLLocationManager()
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitle()
        initialLocalization()
        verifyAutorizationUser()
        map.delegate = localization
        managerLocalization.delegate = self

    }
    
    
    //MARK: - Metodos
    
    func getTitle() -> String {
        return "Localizar Alunos"
    }
    
    func verifyAutorizationUser() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                let button = Localization().configButtonLocalizationCurrent(map: map)
                map.addSubview(button)
                managerLocalization.startUpdatingLocation()
                break
            case .notDetermined:
                managerLocalization.requestWhenInUseAuthorization()
                
                break
            case .denied:
                
                break
            default:
                break
            }
        }
    }
    
    func initialLocalization() {
        Localization().convertAddressCoords(endereco: "BRQ - São Paulo") { (findedLocalization) in
//            let pin = self.configPin(title: "BRQ", localization: findedLocalization)
            let pin = Localization().configPin(title: "BRQ", localization: findedLocalization, color: .black, icon: nil)
            let region = MKCoordinateRegionMakeWithDistance(pin.coordinate, 5000, 5000)
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(pin)
            self.studentLocalization()
        }
    }
    
    func studentLocalization() {
        if let aluno = aluno {
            Localization().convertAddressCoords(endereco: aluno.endereco!) { (findedLocalization) in
//                let pin = self.configPin(title: aluno.nome!, localization: findedLocalization)
                let pin = Localization().configPin(title: aluno.nome!, localization: findedLocalization, color: nil, icon: nil)
                self.map.addAnnotation(pin)
                self.map.showAnnotations(self.map.annotations, animated: true)
            }
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            let button = Localization().configButtonLocalizationCurrent(map: map)
            map.addSubview(button)
            managerLocalization.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
   
    
    



}
