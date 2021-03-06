//
//  CollectionViewDataSource.swift
//  iOSPostulacion
//
//  Created by Principal on 05/03/21.
//

import Foundation
import UIKit

extension PrincipalViewController: UICollectionViewDelegate{ }


extension PrincipalViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataProducts.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! ContenedorDatosProducto
        
        let DATOS_PRODUCTO: Item!
    
        DATOS_PRODUCTO = self.dataProducts[indexPath.row]

        cell.nombreAfiliado.text = DATOS_PRODUCTO.title
        cell.imagen.loadImageUsingCache(withUrl:  DATOS_PRODUCTO.image!, imagenCache: imageCache)
        
        let precio = String(format: "%.2f", DATOS_PRODUCTO.price ?? "sin precio")
        cell.minOperacion.text = "$ \(precio)"
      
        
        return cell
    }

    
}

