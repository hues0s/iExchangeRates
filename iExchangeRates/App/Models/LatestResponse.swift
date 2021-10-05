//
//  LatestResponse.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import Foundation

struct LatestResponse: Codable {
    let success: Bool?
    let base: String?
    let date: String?
    let rates: [String: Double]?
}

struct Latest: Codable {
    let success: Bool?
    let base: String?
    let date: String?
    let rates: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case base
        case date
        case rates
    }
}

struct Rate: Equatable {
    let id: String
    let value: Double
    
    static func ==(lhs: Rate, rhs: Rate) -> Bool {
        return lhs.id == rhs.id
    }

}
