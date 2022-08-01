//
//  ViewController.swift
//  CidadaoBR
//
//  Created by Vinicius on 28/07/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    @IBOutlet weak var textFieldNome: UITextField!
    
    @IBOutlet weak var textFieldLocalizacao: UITextField!
    
    @IBOutlet weak var imageViewProblema: UIImageView!
    
    @IBOutlet weak var textFieldDescricao: UITextField!
    
    @IBOutlet weak var buttonAddEdit: UIButton!
    
    var problema: Problema?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let problema = problema {
            title = "Edicao"
            textFieldNome.text = problema.nome
            textFieldLocalizacao.text = problema.localizacao
            textFieldDescricao.text = problema.descricao
            
            if let image = problema.foto{
                imageViewProblema.image = UIImage(data: image)
            }
            buttonAddEdit.setTitle("Alterar", for: .normal)
        }
    }
    
    
    
    @IBAction func selectFoto(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Selecionar Foto", message: "De onde voce deseja escolher o poster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ _ in
            self.selectPicture(sourceType: .camera)
        }
        alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default){ _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Album de fotos", style: .default){ _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker  = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil )
    }

    @IBAction func save(_ sender: UIButton) {
               
        if problema == nil{
            print("passou x")
            problema = Problema(context: context)
        }
            problema?.nome = textFieldNome.text
            problema?.localizacao = textFieldLocalizacao.text
            problema?.descricao = textFieldDescricao.text
            problema?.dataCadastro = Date()
            problema?.foto = imageViewProblema.image?.jpegData(compressionQuality: 0.9)
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
        
}
    



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
             imageViewProblema.image = image
        }

        // fecha a tela
        dismiss(animated: true, completion: nil)

    }
}
