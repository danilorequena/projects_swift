//
//  ViagemDAO.swift
//  Alura Viagens
//
//  Created by Ândriu Coelho on 04/08/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class TravelDAO: NSObject {
    
    func returnAllTravels() -> Array<Travel> {
        let ceara = Travel(title: "Ceará", numberOfDays: 6, price: "1.900,00", imagePath: "img1")
        let rioDeJaneiro = Travel(title: "Rio de Janeiro", numberOfDays: 7, price: "685,00", imagePath: "img2")
        let rioGrandeDoSul = Travel(title: "Rio grande do Sul", numberOfDays: 5, price: "1.521,89", imagePath: "img3")
        let parana = Travel(title: "Paraná", numberOfDays: 7, price: "1.000,00", imagePath: "img4")
        let portoAlegre = Travel(title: "Porto Alegre", numberOfDays: 6, price: "2.123,22", imagePath: "img5")
        let usa = Travel(title: "USA", numberOfDays: 5, price: "2000", imagePath: "img6")
        let travelList:Array<Travel> = [ceara, rioDeJaneiro, rioGrandeDoSul, parana, portoAlegre, usa]
        
        return travelList
    }
}
