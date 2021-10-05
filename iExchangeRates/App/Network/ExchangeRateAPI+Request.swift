//
//  ExchangeRateApi+Request.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import Combine
import Foundation


extension ExchangeRateAPI {

    static func latest(baseCurrencyId: String? = nil) -> AnyPublisher<LatestResponse, APIError> {
        return send(URL.latest(baseCurrencyId), method: .GET)
    }
    
}
