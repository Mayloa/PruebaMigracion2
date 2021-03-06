//
//  ExtensionTableView.swift
//  iOSPostulacion
//
//  Created by Principal on 05/03/21.
//

import Foundation
import UIKit

extension HistorialViewController : UITableViewDelegate{
    
   
    
}

extension HistorialViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.historial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistorialCell
        
        cell.buscado.text = self.historial[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.criterioSeleccionado = self.historial[indexPath.row]
        print("valor seleccionado" , self.criterioSeleccionado)
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "ocultarBusqueda", sender: self)
    }
}
