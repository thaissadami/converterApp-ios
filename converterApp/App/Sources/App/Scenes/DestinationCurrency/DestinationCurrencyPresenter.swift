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

public class DestinationCurrencyPresenter: NetworkAPI {

    private var dispatchGroup: DispatchGroup?
    private weak var view: DestinationCurrencyViewable?
    public var viewController: DestinationCurrencyViewController?

    private var conversionRateCurrencyDestiny: Float?
    private var conversionRateCurrency: Float?

    public override init() {
    }

    func attach(_ view: DestinationCurrencyViewable) {
        self.view = view
    }

    public override func failure(error:AFDataResponse<Data>){

        do {
            let errorResult = try JSONDecoder().decode(ErrorResult.self, from: error.data ?? Data())
            self.view?.showAlert(errorResult.errors?[0] ?? "")
        } catch {
            print(error.localizedDescription)
        }

        view?.stopLoading()
    }
}

extension DestinationCurrencyPresenter: DestinationCurrencyViewPresenting {

    public func didSelectCurrency(_ currency: String) {
        self.view?.startLoading()

        dispatchGroup = DispatchGroup()

        getRateFromCurrency()
        getRateCurrency()

        dispatchGroup?.notify(queue: .main) {
            self.view?.stopLoading()
            self.getFinalConversion()
        }
    }

    func getRateFromCurrency() {
        dispatchGroup?.enter()
        guard let fromCurrency = viewController?.rate?.fromCurrency else { return }
        guard let destinyCurrency = viewController?.rate?.destinyCurrency else { return }

        let url = APIEnvironment.production.baseURLAPI() + Constants.URL.rates + fromCurrency
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { response in
            if let status = response.response?.statusCode {
                if (status >= 200 && status <= 300){
                    do {
                        let response = try JSONDecoder().decode(SymbolResponse.self, from: response.data ?? Data())
                        let dict = response.rates
                        self.conversionRateCurrencyDestiny = Float(dict?[destinyCurrency] ?? 0.0)
                    } catch {
                        print(error.localizedDescription)
                    }
                }else{
                    self.failure(error:response)
                }
            }
            self.dispatchGroup?.leave()
        }
    }

    func getRateCurrency() {
        dispatchGroup?.enter()
        guard let rateCurrency = viewController?.rate?.rateCurrency else { return }
        guard let destinyCurrency = viewController?.rate?.destinyCurrency else { return }

        let url = APIEnvironment.production.baseURLAPI() + Constants.URL.rates + rateCurrency
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { response in
            if let status = response.response?.statusCode {
                if (status >= 200 && status <= 300){
                    do {
                        let response = try JSONDecoder().decode(SymbolResponse.self, from: response.data ?? Data())
                        let dict = response.rates
                        self.conversionRateCurrency = Float(dict?[destinyCurrency] ?? 0.0)
                    } catch {
                        print(error.localizedDescription)
                    }
                }else{
                    self.failure(error:response)
                }
            }
            self.dispatchGroup?.leave()
        }
    }

    func getFinalConversion() {

        guard let value = viewController?.rate?.fromValue else { return }
        guard let conversionRate = viewController?.rate?.rateValue else { return }

        guard let rateCurrencyDestiny = conversionRateCurrencyDestiny else { return }
        guard let rateCurrency = conversionRateCurrency else { return }

        let finalConversionRate = rateConverter(value: value, conversionRateCurrencyDestiny: rateCurrencyDestiny, conversionRate: conversionRate, conversionRateCurrency: rateCurrency)

        self.view?.setFinalConversionRate(finalConversionRate)
    }

    func rateConverter(value: Float, conversionRateCurrencyDestiny: Float, conversionRate: Float, conversionRateCurrency: Float) -> Float{
        let a = value * Float(conversionRateCurrencyDestiny)
        let b = conversionRate * Float(conversionRateCurrency)
        return a - b
    }
}

protocol DestinationCurrencyViewable: AnyObject {
    func setFinalConversionRate(_ result: Float)
    func showAlert(_ message: String)
    func startLoading()
    func stopLoading()
}
