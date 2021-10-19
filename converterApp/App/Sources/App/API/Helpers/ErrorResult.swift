//
//  File.swift
//  
//
//  Created by Thais Sadami on 15/10/21.
//

import Foundation

class ErrorResult: RequestModel {
    let success: Bool?
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case success
        case errors
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.errors = try container.decodeIfPresent([String].self, forKey: .errors)

        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(success, forKey: .success)
        try container.encodeIfPresent(errors, forKey: .errors)
        try super.encode(to: encoder)
    }
}
