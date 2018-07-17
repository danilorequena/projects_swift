//
//  ViewController.swift
//  ColorPassword
//
//  Created by Danilo Requena on 17/08/15.
//  Copyright (c) 2015 Danilo Requena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cores = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.blackColor()]
    
    var segredo: Dictionary<Int, UIColor> = Dictionary<Int, UIColor> ()

    var coresAtuais = [0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    gerarCombinacao()
    }
    
    //gerarCorAleatoria()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gerarCombinacao() {
        
        for indice in 1...3 {
            
            var cor = gerarCorAleatoria()
            segredo[indice] = cor
            
            switch cor {
                case UIColor.redColor():
                    println("Vermelho")
                
                case UIColor.blackColor():
                    println("Preto")
                
                case UIColor.blueColor():
                    println("Azul")
                
                default :
                    println("Verde")
            }
        }
        
    }
    
    func gerarCorAleatoria() -> UIColor {
        return cores [Int(arc4random_uniform(UInt32(cores.count)))]
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let toque = touches.first as! UITouch
        
        var viewSelecionada = toque.view
        switch viewSelecionada.tag {
        case 1, 2, 3:
            var indiceCor = coresAtuais[viewSelecionada.tag-1] % 4
            viewSelecionada.backgroundColor = cores[indiceCor]
            coresAtuais[viewSelecionada.tag-1] += 1
        case 10 : adivinhar()
        default :
            break
        }
    }
    
    func adivinhar() {
        
        var acertei : Bool = true
        for indice in 1...3 {
            
            let viewSelecionada = self.view.viewWithTag(indice)
            if (viewSelecionada?.backgroundColor != segredo[indice]) {
                
                acertei = false
            }
        }
        var textoDeCima = self.view.viewWithTag(5) as! UILabel
        if (acertei) {
            println("ACERTEI!!!")
            textoDeCima.text = "Ahhh moleque!!!"
        }else{
            println("ERROU!!!")
            textoDeCima.text = "Errou Cabaço!!!"
        }
    }


}

