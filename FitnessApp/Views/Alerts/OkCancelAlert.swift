//
//  OkCancelAlert.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 29.08.2022.
//

import UIKit
import SwiftUI

extension UIViewController {
    
    func okCancelAlert (title: String, message: String?, complitionHandler: @escaping() -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            complitionHandler()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
