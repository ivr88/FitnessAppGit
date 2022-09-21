//
//  SimpleAlert.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 25.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertOK (title: String, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(ok)
        
        present(alertController, animated: true, completion: nil)
    }
}

