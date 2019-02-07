//
//  AlunoViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import CoreData

class AlunoViewController: UIViewController, ImagePickerSelectedPhoto {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viewImagemAluno: UIView!
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var buttonFoto: UIButton!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldSite: UITextField!
    @IBOutlet weak var textFieldNota: UITextField!
    
    // MARK: - Atributes
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    let imagePicker = ImagePicker()
    var aluno:Aluno?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.arredondaView()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Métodos
    
    func setup() {
        imagePicker.delegate = self
        guard let selectedStudant = aluno else { return }
        textFieldNome.text = selectedStudant.nome
        textFieldEndereco.text = selectedStudant.endereco
        textFieldSite.text = selectedStudant.site
        textFieldTelefone.text = selectedStudant.telefone
        textFieldNota.text = "\(selectedStudant.nota)"
        imageAluno.image = selectedStudant.foto as? UIImage
        
    }
    
    func arredondaView() {
        self.viewImagemAluno.layer.cornerRadius = self.viewImagemAluno.frame.width / 2
        self.viewImagemAluno.layer.borderWidth = 1
        self.viewImagemAluno.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func aumentarScrollView(_ notification:Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + self.scrollViewPrincipal.frame.height/2)
    }
    
    //MARK: - Delegate
    
    func imagePickerSelectedPhoto(_ picture: UIImage) {
        imageAluno.image = picture
    }
    
    func showMedia(_ option: MenuOptions) {
        
        let media = UIImagePickerController()
        media.delegate = imagePicker
        
        if option == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            media.sourceType = .camera
        } else {
             media.sourceType = .photoLibrary
        }
       
        self.present(media, animated: true, completion: nil)
            
        
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonFoto(_ sender: UIButton) {
        let menu = ImagePicker().menuOptions { (option) in
            self.showMedia(option)
        }
        present(menu, animated: true, completion: nil)
        
    }
    
    @IBAction func stepperNota(_ sender: UIStepper) {
        self.textFieldNota.text = "\(sender.value)"
    }
    
    @IBAction func buttonSave(_ sender: UIButton) {
//        let aluno = Aluno(context: context)
        if aluno == nil {
            aluno = Aluno(context: context)
        }
        aluno?.nome = textFieldNome.text
        aluno?.endereco = textFieldEndereco.text
        aluno?.telefone = textFieldTelefone.text
        aluno?.site = textFieldSite.text
        aluno?.nota = (textFieldNota.text! as NSString).doubleValue
        aluno?.foto = imageAluno.image
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
