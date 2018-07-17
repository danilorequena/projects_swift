import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var botao: UIButton!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfAltura: UITextField!
    @IBOutlet weak var tfPeso: UITextField!
    @IBOutlet weak var foto: UIImageView!
    
    var fileManager = NSFileManager.defaultManager()
    let documentsDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
    let dados:String = "/dados"
    var imageLowRes:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botao.layer.cornerRadius = 6
        foto.layer.cornerRadius = foto.frame.size.width/2
        lerDados()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func lerDados() {
        //2 - CARREGANDO DADOS DA CLASSE PESSOA
        //============================================
        //============================================
    }
    
    @IBAction func pegarFoto(sender: UIButton) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let newSize = CGSize(width: 300, height: 300)
        
        UIGraphicsBeginImageContext(newSize);
        image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        imageLowRes = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        foto.image = imageLowRes
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
            case tfNome:
                tfEmail.becomeFirstResponder()
            case tfEmail:
                tfAltura.becomeFirstResponder()
            case tfAltura:
                tfPeso.becomeFirstResponder()
            case tfPeso:
                entrar()
            default:
                break
        }
        return true
    }

    @IBAction func entrar(sender: UIButton) {
        performSegueWithIdentifier("listSegue", sender: nil)
        //entrar()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func entrar() {
        var mensagem:String = ""
        if (imageLowRes == nil) {
            mensagem = "Você precisa definir sua foto"
        } else if (tfNome.text! == "") {
            mensagem = "Você precisa colocar seu email"
        } else if (tfEmail.text! == "") {
            mensagem = "Você precisa colocar seu email"
        } else if (tfPeso.text! == "") {
            mensagem = "Você precisa colocar com seu peso"
        } else if (tfAltura.text! == "") {
            mensagem = "Você precisa colocar sua altura"
        }
        if (mensagem != "") {
            let alerta = UIAlertController(title: "Dados inválidos", message: mensagem, preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            presentViewController(alerta, animated: true, completion: nil)
            
        } else {
            
            //1 - GERANDO E SALVANDO CLASSE PESSOA
            //============================================
            //============================================

            self.view.becomeFirstResponder()
            performSegueWithIdentifier("listSegue", sender: nil)
        }
        
    }
}

