import UIKit

class TutorialViewController: UIViewController {

    var modulo:Int = 0
    let informacoes:[(String, String, String)] = [
        ("101", "Linguagem", "Neste módulo você terá 1 minuto para responder o máximo de perguntas sobre a linguagem Swift. Cada pergunta terá quatro alternativas. Boa sorte!"),
        ("201", "Componentes", "Neste módulo você terá 5 minutos para responder o máximo de perguntas sobre os principais do CocoaTouch. Você deverá digitar a resposta correta. Boa sorte!"),
    ]
    
    @IBOutlet weak var labelModulo: UILabel!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelDescrição: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelModulo.text = "Módulo \(informacoes[modulo].0)"
        labelTitulo.text = informacoes[modulo].1
        labelDescrição.text = informacoes[modulo].2
    }

    @IBAction func comecar(sender: UIButton) {
        performSegueWithIdentifier("modulo\(informacoes[modulo].0)", sender: nil)
    }
    
    @IBAction func dismiss(sender: UIButton) {
        print(self.presentingViewController)
        print(self.parentViewController)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
