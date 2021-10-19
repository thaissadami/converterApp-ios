//
//  File.swift
//
//
//  Created by Thais Sadami on 15/10/21.
//

import Foundation
import Alamofire
import SwiftyJSON

public class NetworkAPI {

    var headers: HTTPHeaders = [.contentType("application/json")]
    let baseURL: String = APIEnvironment.production.baseURLAPI()

    public typealias GenericCompletion<T> = (_ result: Swift.Result<T, Error>) -> Void

    public func makeRequest(method: HTTPMethod, url:String, parameters: Parameters?){
        let fullURL = baseURL.appending(url)

        AF.request(fullURL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in

            if let status = response.response?.statusCode {
                if (status >= 200 && status <= 300){
                    self.successResult(response: response)
                }else{
                    self.failure(error:response)
                }
            }
        }
    }

    public func successResult(response:AFDataResponse<Data>){

    }

    public func failure(error:AFDataResponse<Data>){

    }
    
}
