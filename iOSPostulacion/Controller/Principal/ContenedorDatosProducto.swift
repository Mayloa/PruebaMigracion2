//
//  ContenedorTiendaCompleto.swift
//  EjemploSwift3
//
//  Created by Sergio Alexandro Santis Pérez on 8/30/19.
//  Copyright © 2019 Usuario Principal. All rights reserved.
//

import UIKit

class ContenedorDatosProducto: UICollectionViewCell {
    @IBOutlet weak var tarjeta: UIView!
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombreAfiliado: UILabel!
    @IBOutlet weak var porcentaje: UILabel!
    @IBOutlet weak var ofertaCantidad: UILabel!
    @IBOutlet weak var lineaInferior: UIView!
    @IBOutlet weak var minOperacion: UILabel!
    @IBOutlet weak var maxOperacion: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.ofertaCantidad.isHidden = false
//        self.lineaInferior.isHidden = false
//        self.ofertaCantidad.text = "Ofertas Especiales"
        
           self.tarjetaCustom()
        
        
    }
    
    func tarjetaCustom() {
        self.tarjeta.layer.cornerRadius = 30
    }
    
}
