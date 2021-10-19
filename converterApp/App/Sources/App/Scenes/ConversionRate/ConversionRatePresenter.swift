//
//  File.swift
//
//
//  Created by Thais Sadami on 14/10/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import Common

public class ConversionRatePresenter: NetworkAPI {

    private weak var view: ConversionRateViewable?
    public var viewController: ConversionRateViewController?

    public override init() {
    }
}

extension ConversionRatePresenter: ConversionRateViewPresenting {

    public func didSelectCurrency(_ currency: String) {
        if let viewController = self.viewController {
            if viewController.mainView.valueTextField.textField.text?.count ?? 0 > 0 {
                let presenter = DestinationCurrencyPresenter()
                let vc = DestinationCurrencyViewController(presenter: presenter)
                presenter.attach(vc)

                let textInput = self.viewController?.mainView.valueTextField.textField.text ?? ""
                let newString = textInput.replacingOccurrences(of: ",", with: ".")
                viewController.rate?.rateValue = Float(newString)
                viewController.rate?.rateCurrency = currency
                vc.rate = viewController.rate
                self.viewController?.navigationController?.pushViewController(vc, animated: true)
            }else{
                viewController.showAlert("Informe um valor para conversão antes de selecionar uma moeda")
            }
        }
    }
}

protocol ConversionRateViewable: AnyObject {
    func showAlert(_ message: String)
    func startLoading()
    func stopLoading()
}
