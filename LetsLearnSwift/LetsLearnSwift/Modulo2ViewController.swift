import UIKit

class Modulo2ViewController: ModuloViewController, UITextFieldDelegate {

    @IBOutlet weak var tfResposta: UITextField!
    @IBOutlet weak var labelPergunta: UILabel!
    @IBOutlet weak var btREsopnder: UIButton!
    
    let perguntas = [
        ("Qual o componente utilizado quando queremos que o usuário insira uma informação de texto?", "uitextfield"),
        ("Qual o componente para trabalharmos com imagens?", "uiimageview"),
        ("Qual o framework que contém todas as classes para trabalharmos com elementos de view?", "uikit"),
        ("Qual a classe que controla as views?", "uiviewcontroller")
    ]
    
    override func viewDidLoad() {
        tituloModulo = "Módulo 201: Componentes"
        totalPerguntas = perguntas.count
        tempo = 15.0
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func iniciarQuiz() {
        print("iniciarQuiz do Módulo 2")
        indiceAtual = pegarQuiz()
        tfResposta.text = ""
        labelPergunta.text = perguntas[indiceAtual].0
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        responder(btREsopnder)
        return true
    }

    @IBAction func responder(sender: UIButton) {
        perguntasRespondidas++
        if (tfResposta.text!.lowercaseString == perguntas[indiceAtual].1) {
            acertos++
        }
        iniciarQuiz()
    }
}
