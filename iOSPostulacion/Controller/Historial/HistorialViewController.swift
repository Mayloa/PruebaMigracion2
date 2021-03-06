//
//  HistorialViewController.swift
//  iOSPostulacion
//
//  Created by Mayte López Aguilar on 05/03/21.
//

import UIKit

class HistorialViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var criterioSeleccionado = ""
    
    var historial: [String] = []
    let defaults = UserDefaults.standard
   
    override func viewDidLoad() {
        super.viewDidLoad()

        historial =  defaults.array(forKey: "SavedStringArray") as? [String] ?? [String]()
        
        
        // Aplicar color de fondo a la tabla
        self.tableView.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        //Para desaparecer todo lo que esta después de la última celda
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        //Cambiar el color del separador de las celdas
        self.tableView.separatorColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.ocultarHistorial), name: NSNotification.Name(rawValue: "ocultarHistorial"), object: nil)
        
    }
    
    @objc func ocultarHistorial(){
        self.dismiss(animated: true, completion: nil)
    }

}
