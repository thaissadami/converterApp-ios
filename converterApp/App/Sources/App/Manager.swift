//
//  File.swift
//  
//
//  Created by Thais Sadami on 18/10/21.
//

import Foundation

class Manager: NSObject {

    var symbolsList: [String]?

    private(set) static var sharedManager = Manager()

    fileprivate override init() {
        super.init()
    }

    static func resetManager() {
        sharedManager = Manager()
    }

    func setSymbolsList(symbolsList: [String]?) {
        UserDefaults.standard.set(symbolsList, forKey: "symbolsList")
        UserDefaults.standard.synchronize()
    }

    func getSymbolsList() -> [String]? {
        return UserDefaults.standard.stringArray(forKey: "symbolsList")
    }

}

