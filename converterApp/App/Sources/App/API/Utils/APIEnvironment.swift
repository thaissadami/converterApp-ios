//
//  File.swift
//  
//
//  Created by Thais Sadami on 15/10/21.
//

import Foundation

enum APIEnvironment {
//    case development
    case production

    func baseURL () -> String {
        return "http://\(domain())"
    }

    func baseURLAPI () -> String {
        return "http://\(domain())\(route())"
    }

    func domain() -> String {
        switch self {
//        case .development:
//            return "dev.api.exchangeratesapi.io"
        case .production:
            return "v6.exchangerate-api.com"
        }
    }

    func route() -> String {
        return "/v6/"
    }
}

