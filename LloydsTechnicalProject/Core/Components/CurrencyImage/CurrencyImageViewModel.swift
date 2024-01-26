//
//  CurrencyImageViewModel.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation
import SwiftUI
import Combine

class CurrencyImageViewModel:ObservableObject{
      
    @Published var image:UIImage? = nil
    private var cancellables = Set<AnyCancellable>()
    private let dataService = CurrencyImageService()
    private let currency:Currency
    @Published var state = State.loading
    
    init(currency: Currency){
    self.currency = currency
        getCurrencyImage(currency:  currency)
        addSubscribers()
    }
    
    enum State:Equatable {
         case loading
         case failed(String)
         case loaded
     }
    
    func  getCurrencyImage(currency:Currency){
        dataService.getCurrencyImage(currency:  currency)
   }
    
    private func addSubscribers(){
        dataService.$image.sink {[weak self ] result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                self?.state = .failed(error.localizedDescription)
            }
        } receiveValue: { [weak self] returnedImage in
            self?.image = returnedImage
            self?.state = .loaded
        }.store(in: &cancellables)
    }
}

