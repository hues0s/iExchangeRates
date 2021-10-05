//
//  ContentView.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            RateListView().navigationBarTitle(Text("Rates"))
            DetailRateView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
