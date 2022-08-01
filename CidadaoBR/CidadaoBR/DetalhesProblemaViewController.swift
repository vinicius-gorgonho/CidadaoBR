//
//  DetalhesProblemaViewController.swift
//  CidadaoBR
//
//  Created by Vinicius on 01/08/22.
//

import UIKit

class DetalhesProblemaViewController: UIViewController {

    var problema: Problema?
    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var Localizacao: UILabel!
    
    @IBOutlet weak var imageViewFoto: UIImageView!
    
    @IBOutlet weak var labelDescricao: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func prepareScreen(){
        if let problema = problema {
            if let image = problema.foto{
            imageViewFoto.image = UIImage(data: image)
            }
            labelNome.text = problema.nome
            labelDescricao.text =  problema.descricao
            Localizacao.text = problema.localizacao
                 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? ViewController{
           viewController.problema = problema
        }
        
         
        
    }
    

    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
