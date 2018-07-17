import UIKit

class ResultadoViewController: UIViewController {

    var respondidas:Int = 0
    var acertos:Int = 0
    var modulo:String = ""
    
    @IBOutlet weak var labelModulo: UILabel!
    @IBOutlet weak var labelRespondidas: UILabel!
    @IBOutlet weak var labelCorretas: UILabel!
    @IBOutlet weak var labelErradas: UILabel!
    @IBOutlet weak var labelAproveitamento: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelModulo.text = modulo
        labelRespondidas.text = "Perguntas respondidas: \(respondidas)"
        labelCorretas.text = "Respostas corretas: \(acertos.description)"
        labelErradas.text = "Respostas erradas: \(respondidas - acertos)"
        
        var aproveitamento:Float = 0
        if (respondidas != 0) {
            aproveitamento = Float((10000*acertos/respondidas))/100
        }
        
        if (aproveitamento > 50) {
            labelAproveitamento.textColor = UIColor.greenColor()
        } else {
            labelAproveitamento.textColor = UIColor.redColor()
        }
        labelAproveitamento.text = "\(aproveitamento)%"
    }

    @IBAction func mudarModulo(sender: UIButton) {
        var vc:UIViewController = self.presentingViewController!
        while (vc.presentingViewController != nil) {
            vc = vc.presentingViewController!
        }
        vc.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func reiniciar(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
