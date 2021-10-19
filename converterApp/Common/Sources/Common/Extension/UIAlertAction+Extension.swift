//
//  File.swift
//  
//
//  Created by Thais Sadami on 18/10/21.
//

import Foundation
import UIKit

extension UIAlertAction {
    public func showAlert(viewController: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
