//
//  File.swift
//  
//
//  Created by Thais Sadami on 15/10/21.
//

import Foundation

public class RequestModel: Codable{

    init() {
    }

    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

    func toJSONDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] ?? [:]

        } catch {
            return nil
        }
    }
}

