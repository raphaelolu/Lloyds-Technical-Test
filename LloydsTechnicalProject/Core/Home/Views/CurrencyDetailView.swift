//
//  CurrencyDetailView.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import SwiftUI

struct CurrencyDetailView: View {
    
    let currency:Currency
    let factory:ViewModelFactory
    let viewMmodel:DetailViewModel
    
    
    init(currency:Currency,factory:ViewModelFactory) {
        self.factory = factory
        self.currency = currency
        self.viewMmodel = factory.makeCurrencyDetailViewModel(currency: currency)
    }
    var body: some View {
        Spacer()
        VStack{
            Text("Aditional Details")
                .font(.headline)
            Divider()
        }
        
        VStack(alignment:.leading){
            Text(viewMmodel.return24HourHigh())
                .padding([.top])
                .navigationTitle(currency.name)
            Text(viewMmodel.return24HourLow())
            Spacer()
        }
    }
}
