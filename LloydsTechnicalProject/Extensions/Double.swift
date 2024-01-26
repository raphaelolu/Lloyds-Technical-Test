//
//  Double.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation

extension Double {
    
    private var curencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWithTwoDecimals() -> String{
        let number = NSNumber(value: self)
        return curencyFormatter2.string(from:number) ?? "$0.00"
    }
    
    private var curencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWithSixDecimals() -> String{
        let number = NSNumber(value: self)
        return curencyFormatter6.string(from:number) ?? "$0.00"
    }
    
    func asNumberString() -> String {
        return String(format:"%.2f",self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
