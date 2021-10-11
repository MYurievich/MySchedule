//
//  AlertOk.swift
//  MySchedule
//
//  Created by Максим on 11.10.2021.
//

import UIKit

extension UIViewController {
   
    func alertOk(title: String, message: String?) {
      
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
