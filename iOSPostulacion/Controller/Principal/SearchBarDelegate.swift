//
//  SearchBarDelegate.swift
//  iOSPostulacion
//
//  Created by Principal on 05/03/21.
//

import Foundation
import UIKit

extension PrincipalViewController: UISearchBarDelegate{
    //funcion que se activa cuando presiona el boton cancelar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        self.cancelarFiltros()
        
}

 
    //se activa cuando se esta escribiendo
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
       
        let historial = defaults.array(forKey: "SavedStringArray") ?? [String]()
        
        if historial.count > 0{
            self.performSegue(withIdentifier: "showHistorial", sender: self)
        }
        
       
    }
    

    
    
    //metodo que se ejecuta cuando se presiona el boton de buscar en el teclado, en este caso se configuró para que se ocultara el teclado y se mantuviera el filtro de busqueda.
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name("ocultarHistorial"), object: self, userInfo: nil)
        
        
        //si se puede obtener el texto de la busqueda, se llama al metodo de busqueda y se refrescan los datos de la vista
        if let TEXTO_A_BUSCAR = searchBar.text{
            self.getDataWebService(criterio: TEXTO_A_BUSCAR)
            
            if searchBar.text != ""{
                //guardar historial
                var historial = defaults.array(forKey: "SavedStringArray") as? [String] ?? [String]()
                var existe = false
                for datos in historial{
                    if TEXTO_A_BUSCAR == datos{
                        existe = true
                        break
                    }
                }
                if !existe{
                    historial.append(TEXTO_A_BUSCAR)
                    defaults.set(historial, forKey: "SavedStringArray")
                }
            }
            
            self.collectionView.reloadData()
        }
        
        if searchBar.text == ""{ //Si no hay texto en la searchBar se oculta el boton cancelar.
            searchBar.setShowsCancelButton(false, animated: true)
            self.collectionView.isUserInteractionEnabled = true
            self.collectionView.isScrollEnabled = true
        }else{ //Si hay texto escrito, dejamos habilitado el boton cancelar para que el usuario cancele el filtro.
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }
      
    }
}
