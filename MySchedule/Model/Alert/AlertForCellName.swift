//
//  AlertForCellName.swift
//  MySchedule
//
//  Created by Максим on 07.10.2021.
//

import UIKit

extension UIViewController {
   
    func alertForCellName(label: UILabel, name: String, placeholder: String) {
      
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else { return }
            label.text = text
        }
        
        alert.addTextField { tfAlert in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)

        
        present(alert, animated: true, completion: nil)
    }
}