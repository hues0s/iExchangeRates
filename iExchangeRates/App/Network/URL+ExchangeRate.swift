//
//  URL+ExchangeRate.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import Foundation

extension URL{
    
    static private let baseURL = "https://api.exchangerate.host/"
    
    private enum Endpoint: String {
        case latest = "latest"
    }
    
    static func latest(_ baseCurrencyId: String? = nil) -> URL {
        let endPoint = Endpoint.latest.rawValue
        if baseCurrencyId != nil {
            return URL(string: "\(baseURL)\(endPoint)?base=\(baseCurrencyId ?? "EUR")")!
        }
        return URL(string: "\(baseURL)\(endPoint)")!
        
    }
    
}
