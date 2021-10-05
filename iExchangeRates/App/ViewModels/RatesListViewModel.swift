//
//  RatesListViewModel.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import UIKit
import Combine
import SwiftUI

enum ModelDataState: Equatable {
    static func == (lhs: ModelDataState, rhs: ModelDataState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    case idle
    case loading
    case loaded
    case error(Error)
}

struct RatesListState {
    var baseCurrencyId: String = ""
    var rates: [Rate] = []
    var dataState: ModelDataState = .idle
    mutating func changeViewModelState(newViewModelState: ModelDataState) { dataState = newViewModelState }
    
}

enum RatesListInput {
    case reloadPage
}

class RatesListViewModel: ViewModel {
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published
    var state: RatesListState

    init(state: RatesListState) {
        self.state = state
        self.state.changeViewModelState(newViewModelState: .loading)
        loadRates()
    }
    
    func loadRates() {
        do {
            ExchangeRateAPI.latest(baseCurrencyId: self.state.baseCurrencyId).sink(receiveCompletion: { completion
                in
                switch completion {
                case .failure(let error):
                    self.state.changeViewModelState(newViewModelState: .error(error))
                    switch error {
                    case .serverError(code: let code, message: let reason):
                        print("Server error: \(code), reason: \(reason)")
                    case .decodingError:
                        print("Decoding error \(error)")
                    case .internalError:
                        print("Internal error \(error)")
                    }
                default: break
                }
            }){ (ratesResponse) in
                if let results = ratesResponse.rates {
                    self.state.changeViewModelState(newViewModelState: .loaded)
                    //print("Rates: \(results)")
                    for (key, value) in results {
                        let newRate = Rate(id: key, value: value)
                        if (!self.state.rates.contains(newRate)){
                            self.state.rates.append(newRate)
                        }
                    }
                    
                }
            } .store(in: &cancellableSet)
        }
    }
    
    func trigger(_ input: RatesListInput) {
        switch input {
        case .reloadPage:
            self.loadRates()
        }
    }
    
    deinit {
        cancellableSet.removeAll()
    }
    
}
