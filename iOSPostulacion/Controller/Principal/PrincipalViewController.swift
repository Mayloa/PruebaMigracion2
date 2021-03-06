//
//  ViewController.swift
//  iOSPostulacion
//
//  Created by M on 05/03/21.
//

import UIKit

class PrincipalViewController: UIViewController {

    let imageCache = NSCache<NSString, AnyObject>() // collecion utilizada para almacenar la lista de imagenes de de cada show y asi evitar que se carguen cada que la vista se desplaza.
    
   
    
 
    var  Products : [Product] = []
    var dataProducts : [Item] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaults = UserDefaults.standard
   
    let historialBusqueda : [String] = []
   
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        /// Se establece que tipo de contenedor se presentará
        let nib = UINib(nibName: "ContenedorDatosProducto", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "celda")
      
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width:(width - 45)  / 2, height: 220)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        self.collectionView!.collectionViewLayout = layout
    
        self.view.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
       
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.ocultarTeclado))
        dismissKeyboardGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(dismissKeyboardGesture)
        
        self.searchBarConfiguration()
        
       
  
    }
    
    /**
     Metodo utilizado para la configuracion de la search bar
     */
    func searchBarConfiguration(){
        //se asigna el delegado al searchBar para poder usar los metodos necesarios y se configuran las propiedades de la searchVar
        searchBar.delegate = self
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
        
        let Buscar_tiendas = "Buscar"
        searchBar.placeholder = "\(Buscar_tiendas)..."
        
        //Color del texto de los botones de la barra de busqueda
        searchBar.tintColor = UIColor.black
        searchBar.barTintColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)

        
    }

    
   
    
    /** Funcion que cancela la busqueda, recarga la atabla con todos los datos y oculta el boton de cancelar busqueda
     */
    func cancelarFiltros(){
        
        self.dataProducts = []
        searchBar.setShowsCancelButton(false, animated: true)
        
        //se quita la barra y se vuelve a mostrar el boton de busqueda
        searchBar.text = ""
        
        //se refresca los datos de la vista
        self.collectionView.reloadData()
        self.collectionView.isUserInteractionEnabled = true
        self.collectionView.isScrollEnabled = true
    }
    
    
    
    /** Funcion que habilita y desabilita el boton de cancelar, cuando se realiza una busqueda
     */
    @objc func ocultarTeclado() {
        
        searchBar.resignFirstResponder()
        
        if searchBar.text == ""{
                //Si no hay texto en la searchBar se oculta el boton cancelar.
                searchBar.setShowsCancelButton(false, animated: true)
                self.collectionView.isUserInteractionEnabled = true
                self.collectionView.isScrollEnabled = true
        }
        else{
            
            //Si hay texto escrito, dejamos habilitado el boton cancelar para que el usuario cancele el filtro.
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                   cancelButton.isEnabled = true
            }
        }
    
      
    }
    
    
    
    /**
     Funcion utilizada para consumir la api desde internet.
     *Si la peticion se ejecuta correctamente, se castean los datos a un arreglo temporal, posteriormente se almacenan en core data y se consultan los datos previamenten almacenados.
     */
    @objc func getDataWebService(criterio: String){
      
        let baseURL = "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/search?&query=[\(criterio)]"
      
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string:baseURL) as URL?
        request.setValue("adb8204d-d574-4394-8c1a-53226a40876e", forHTTPHeaderField: "X-IBM-Client-Id") //**
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
            if let data = data{
            do {
                let decoder = JSONDecoder()
                let productsReturns = try decoder.decode(Product.self, from: data)

            
                self.dataProducts = productsReturns.items
             
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            } catch {
                print("JSON Serialization error ", error)
            }
        }
        
        }).resume()
        
        
    }
    
    /**
     Funcion para obtener el valor seleccionado desde el historial de busqueda
     **/
    @IBAction func regresarPrincipal(segue: UIStoryboardSegue) {
       
       if let recibir = segue.source as? HistorialViewController {
        let criterio = recibir.criterioSeleccionado
        self.getDataWebService(criterio: criterio)
        self.searchBar.resignFirstResponder()
        self.searchBar.text = criterio
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistorial" {  // Se valida si el cambio de vista corresponde al historial de busqueda de la app.
            let pop: HistorialViewController = segue.destination as! HistorialViewController
            pop.popoverPresentationController?.backgroundColor = UIColor.white
            pop.popoverPresentationController!.delegate = self
            
            let presentacion = pop.popoverPresentationController
            presentacion?.permittedArrowDirections = .down
            presentacion?.delegate = self
            presentacion?.sourceRect = CGRect(x: 0, y: 0, width: 10, height: 30)
        }
    }
}













