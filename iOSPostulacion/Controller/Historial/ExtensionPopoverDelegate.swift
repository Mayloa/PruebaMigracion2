//
//  ExtensionPopoverDelegate.swift
//  iOSPostulacion
//
//  Created by Mayte López Aguilar on 05/03/21.
//

import Foundation
import UIKit


extension PrincipalViewController: UIPopoverPresentationControllerDelegate {
    
    /**
     Metodo que pide al delegado qué nuevo estilo de presentación utilizar.
     */
    func adaptivePresentationStyle(for controller:
        UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    /**
     Funcion que pide al delegado que se muestre el controlador de vista cuando se adapta al estilo de presentación especificado.
     */
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
    
    /**
     Funcion que  dice al delegado que el popover fue cerrado.
     */
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
    
    /**
     Pregunta al delegado si debe descartarse la ventana emergente.
     */
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
      
        return true
    }
}
