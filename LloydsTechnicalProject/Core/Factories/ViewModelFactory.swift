//
//  ViewModelFactory.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation

protocol ViewModelFactory {
    
    func makeHomePageViewModel()-> HomeViewModel
    func makeCurrencyImageViewModel(currency:Currency)-> CurrencyImageViewModel
    func makeCurrencyDetailViewModel(currency:Currency)-> DetailViewModel
}

struct Dependencies{
    
    private let currencyImageService:CurrencyImageServiceProtocol
    private let homepageService:HompepageDataServicesProtocol
    
    init(currencyImageService:CurrencyImageServiceProtocol = CurrencyImageService() ,homepageService:HompepageDataServicesProtocol = HompepageDataServices()) {
        self.currencyImageService = currencyImageService
        self.homepageService = homepageService
    }
}

extension Dependencies:ViewModelFactory {
    
    func makeCurrencyDetailViewModel(currency: Currency) -> DetailViewModel {
        return DetailViewModel(currency: currency)
    }
    
    func makeCurrencyImageViewModel(currency: Currency) -> CurrencyImageViewModel {
        return CurrencyImageViewModel(currency: currency)
    }
    func makeHomePageViewModel() -> HomeViewModel {
        return HomeViewModel(dataService: homepageService)
    }
}
