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

public class HomePresenter: NetworkAPI {

    private weak var view: HomeViewable?
    public var viewController: HomeViewController?

    public override init() {
    }

    public override func successResult(response:AFDataResponse<Data>) {
        do {
            let response = try JSONDecoder().decode(SymbolResponse.self, from: response.data ?? Data())
            let dict = response.rates
            let sortList = dict?.keys.map{ $0 }.sorted { $0 < $1 }
            Manager.sharedManager.setSymbolsList(symbolsList: sortList)
            self.viewController?.result = Manager.sharedManager.getSymbolsList()
        } catch {
            print(error.localizedDescription)
        }

        viewController?.stopLoading()
    }

    public override func failure(error:AFDataResponse<Data>){

        do {
            let errorResult = try JSONDecoder().decode(ErrorResult.self, from: error.data ?? Data())
            self.viewController?.showAlert(errorResult.errors?[0] ?? "")
        } catch {
            print(error.localizedDescription)
        }

        viewController?.stopLoading()
    }
}

extension HomePresenter: HomeViewPresenting {

    public func getSymbols() {
        self.viewController?.startLoading()
        makeRequest(method: .get, url: Constants.URL.rates + "AED", parameters: nil)
    }

    public func didSelectCurrency(_ currency: String) {
        if let viewController = self.viewController {
            if viewController.mainView.valueTextField.textField.text?.count ?? 0 > 0 {
                let presenter = ConversionRatePresenter()
                let vc = ConversionRateViewController(presenter: presenter)
                var rate = Rate()

                let textInput = self.viewController?.mainView.valueTextField.textField.text ?? ""
                let newString = textInput.replacingOccurrences(of: ",", with: ".")
                rate.fromValue = Float(newString)
                rate.fromCurrency = currency
                vc.rate = rate
                self.viewController?.navigationController?.pushViewController(vc, animated: true)
            }else{
                viewController.showAlert("Informe um valor para conversão antes de selecionar uma moeda")
            }
        }
    }
}

protocol HomeViewable: AnyObject {
    func showAlert(_ message: String)
    func startLoading()
    func stopLoading()
}
