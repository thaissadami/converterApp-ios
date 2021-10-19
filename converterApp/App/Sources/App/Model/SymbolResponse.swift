//
//  File.swift
//  
//
//  Created by Thais Sadami on 15/10/21.
//

class SymbolResponse: RequestModel {
    public let result: String?
    public let rates: [String:Double]?
    public let base: String?

    enum CodingKeys: String, CodingKey {
        case result
        case rates = "conversion_rates"
        case base = "base_code"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rates = try container.decodeIfPresent([String:Double].self, forKey: .rates)
        self.result = try container.decodeIfPresent(String.self, forKey: .result)
        self.base = try container.decodeIfPresent(String.self, forKey: .base)

        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(rates, forKey: .rates)
        try container.encodeIfPresent(result, forKey: .result)
        try container.encodeIfPresent(base, forKey: .base)

        try super.encode(to: encoder)
    }
}
