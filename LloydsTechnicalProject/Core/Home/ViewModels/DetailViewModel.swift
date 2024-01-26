//
//  DetailViewModel.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation

class DetailViewModel {
    let currency:Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
    
    func return24HourHigh() -> String{
        guard let twentyFourHigh = currency.high24H?.asCurrencyWithSixDecimals() else {
            return "24 hour High unavailable"
        }
        return "24 Hour Low: \(twentyFourHigh)"
    }
    
    func return24HourLow() -> String{
        guard let twentyFourLow = currency.low24H?.asCurrencyWithSixDecimals() else {
            return "24 hour Low unavailable"
        }
        return "24 Hour Low: \(twentyFourLow)"
    }
}
