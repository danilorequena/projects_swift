import UIKit

class ModuloViewController: UIViewController {

    var respondidas:[Int] = []
    var perguntasRespondidas:Int = 0
    var indiceAtual:Int = 0
    var acertos:Int = 0
    var tempo:NSTimeInterval!
    var totalPerguntas:Int!
    var tituloModulo:String!
    
    @IBOutlet weak var viewContador: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        //Este trecho abaixo serve apenas para ajudar na implementação de novos módulos,
        //para que o desenvolvedor não esqueça de setar estar variáveis
        var erro:Bool = false
        if (tituloModulo == nil) {
            print("Você precisa definir o título do Módulo na classe Principal")
            erro = true
        }
        if (totalPerguntas == nil) {
            print("Você precisa definir o total de Perguntas na classe Principal")
            erro = true
        }
        if (tempo == nil) {
            print("Você precisa definir o tempo de duração do quiz  na classe Principal")
            erro = true
        }
        if (erro) {
            view.backgroundColor = UIColor.redColor()
            return
        }
        
        
        viewContador.frame.size.width = 320
        respondidas.removeAll(keepCapacity: false)
        perguntasRespondidas = 0
        acertos = 0
        iniciarContador()
        iniciarQuiz()
    }
    
    func iniciarQuiz() {
        print("Você precisa fazer a sbrescrita do método iniciarQuiz para iniciar o seu jogo!!!!")
    }
    
    func iniciarContador() {
        UIView.animateWithDuration(tempo, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.viewContador.frame.size.width = 0
            }) { (sucesso) -> Void in
                self.performSegueWithIdentifier("resultadoSegue", sender: nil)
        }
    }
    
    func pegarQuiz() -> Int {
        if (respondidas.count == totalPerguntas) {
            respondidas.removeAll(keepCapacity: false)
        }
        var indicePergunta:Int = 0
        repeat {
            indicePergunta = gerarNumeroAleatorio(totalPerguntas)
        } while (respondidas.contains(indicePergunta))
        respondidas.append(indicePergunta)
        return indicePergunta
    }
    
    func gerarNumeroAleatorio(range: Int) -> Int {
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let resutadoVC:ResultadoViewController = segue.destinationViewController as! ResultadoViewController
        resutadoVC.acertos = acertos
        resutadoVC.respondidas = perguntasRespondidas
        resutadoVC.modulo = tituloModulo
    }

}
