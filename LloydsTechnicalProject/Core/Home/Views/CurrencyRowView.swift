//
//  CurrencyRowView.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import SwiftUI


struct CurrencyRowView: View {
    let currency:Currency
    var factory:ViewModelFactory
    
    var body: some View {
        HStack(spacing:0) {
            leftColum
            Spacer()
            rightColum
        }
        .font(.subheadline)
    }
}

extension CurrencyRowView{
    private var leftColum: some View {
        HStack{
            Text("\(currency.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CurrencyImageView(currency: currency, factory: factory)
                .frame(width: 30,height: 30)
            Text(currency.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
        }
    }
    private var rightColum : some View {
        VStack(alignment:.trailing){
            Text("\(currency.currentPrice.asCurrencyWithSixDecimals())").bold()
                .foregroundColor(Color.theme.accent)
            Text(currency.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((currency.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green: Color.theme.red)
        }.frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }
}
