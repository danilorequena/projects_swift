//
//  Pessoa.swift
//  FileManager
//
//  Created by Eric Brito on 25/09/15.
//  Copyright (c) 2015 Eric Brito. All rights reserved.
//

import Foundation

class Pessoa:NSObject, NSCoding {
    
    var nome:String
    var email:String
    var altura:Float
    var peso:Float
    var foto:NSData
    
    override init() {
        nome = ""
        email = ""
        peso = 0
        altura = 0
        foto = NSData()
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        self.nome = (aDecoder.decodeObjectForKey("nome") as? String)!
        self.email = (aDecoder.decodeObjectForKey("email") as? String)!
        self.altura = (aDecoder.decodeObjectForKey("altura") as? Float)!
        self.peso = (aDecoder.decodeObjectForKey("peso") as? Float)!
        self.foto = (aDecoder.decodeObjectForKey("foto") as? NSData)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.nome, forKey: "nome")
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.altura, forKey: "altura")
        aCoder.encodeObject(self.peso, forKey: "peso")
        aCoder.encodeObject(self.foto, forKey: "foto")
    }
    
    func converterEmDados() -> NSData {
        let dados = NSKeyedArchiver.archivedDataWithRootObject(self)
        return dados
    }
    
    
}