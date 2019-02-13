//
//  MapsViewController.swift
//  Agenda
//
//  Created by Danilo Requena on 12/02/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    //MARK: - Variaveis
    
    var aluno: Aluno?
    
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitle()
        initialLocalization()
        studentLocalization()

    }
    
    
    //MARK: - Metodos
    
    func getTitle() -> String {
        return "Localizar Alunos"
    }
    
    func initialLocalization() {
        Localization().convertAddressCoords(endereco: "BRQ - São Paulo") { (findedLocalization) in
            let pin = self.configPin(title: "BRQ", localization: findedLocalization)
            let region = MKCoordinateRegionMakeWithDistance(pin.coordinate, 5000, 5000)
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(pin)
        }
    }
    
    func studentLocalization() {
        if let aluno = aluno {
            Localization().convertAddressCoords(endereco: aluno.endereco!) { (findedLocalization) in
                let pin = self.configPin(title: aluno.nome!, localization: findedLocalization)
                self.map.addAnnotation(pin)
            }
        }
    }
    
    func configPin(title: String, localization: CLPlacemark) -> MKPointAnnotation {
        let pin = MKPointAnnotation()
        pin.title = title
        pin.coordinate = localization.location!.coordinate
        
        return pin
    }



}