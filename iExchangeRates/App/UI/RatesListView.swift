//
//  RatesListView.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import SwiftUI

struct RateListView: View {
    @EnvironmentObject
    var viewModel: AnyViewModel<RatesListState, RatesListInput>
    
    @State private var selection: String = "EUR"
    
    var body: some View {
        VStack() {
            picker(rates: self.viewModel.state.rates)
            Text("Base currency")
            content
        }
    }
    
    private var content: some View {
        switch viewModel.state.dataState {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Color.clear.eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded:
            return self.rateList(rates: self.viewModel.state.rates).eraseToAnyView()
        }
    }

    private func picker(rates: [Rate]) -> some View {
        Picker("Select one option", selection: $selection) {
            ForEach(rates, id: \.id) { rate in
                Text("\(rate.id)").foregroundColor(.blue)
            }
        }.onChange(of: selection, perform: { value in
            //self.viewModel.state.baseCurrencyId = selection
            self.viewModel.trigger(.reloadPage)
        })
    }
    
    
    
    private func rateList(rates: [Rate]) -> some View {
        List {
            ForEach(rates, id: \.id) { rate in
                NavigationLink(destination: DetailRateView(result: rate)) {
                    VStack(spacing: 10) {
                        Text("\(rate.id) · \(rate.value)").frame(maxWidth: .infinity, alignment: Alignment.leading)
                    }
                }
            }
        }
    }
}
