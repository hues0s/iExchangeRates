//
//  DetailRateView.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import SwiftUI

struct DetailRateView: View {
    
    var rate: Rate?
    init(result: Rate? = nil) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.boldSystemFont(ofSize: 30)]
        self.rate = result
    }
    
    var body: some View {
        VStack {
            
        }
    }
}
