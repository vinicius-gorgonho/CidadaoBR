//
//  ProblemTableViewCell.swift
//  CidadaoBR
//
//  Created by Vinicius on 01/08/22.
//

import UIKit
import Foundation

class ProblemaTableViewCell: UITableViewCell {


    
    @IBOutlet weak var lblNome: UILabel!
    
    @IBOutlet weak var lblDataCadastro: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    func configureWith(_ problema: Problema){
   
    
    lblNome.text = problema.nome
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "pt-br")
    dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
    lblDataCadastro.text = dateFormatter.string(for: problema.dataCadastro)
    
        
    }
}
