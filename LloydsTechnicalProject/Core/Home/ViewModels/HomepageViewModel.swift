//
//  HomepageViewModel.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject{
    private let dataService:HompepageDataServicesProtocol
    @Published var allCurrencies:[Currency] = []
    @Published var preFilterCurrencyList:[Currency] = []
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText:String = ""
    @Published var sortOption: SortOptions = .price
    @Published  var state = State.loading
    
    init(dataService:HompepageDataServicesProtocol){
        self.dataService = dataService
        getCurrencies()
        addFilterSubscibers()
        resetEmptySearchStringSubscriber()
    }
    
    enum State:Equatable {
        case loading
        case failed(String)
        case loaded
    }
    
    enum SortOptions {
        case rank,rankReversed,price,prieReversed
    }
    
    private func getCurrencies(){
        dataService.sendRequest().sink {[weak self] result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                self?.state = .failed(error.localizedDescription)
            }
        } receiveValue: { [weak self ] currency in
            DispatchQueue.main.async {
                self?.allCurrencies = currency
                self?.preFilterCurrencyList = currency
                self?.state = .loaded
           }
            
        }.store(in: &cancellables)
    }
    
    private func addFilterSubscibers(){
        $searchText.combineLatest($allCurrencies,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCurrerncies)
            .sink { [weak self] returnedCurrencies in
                DispatchQueue.main.async {
                    self?.allCurrencies = returnedCurrencies
                }
            }.store(in: &cancellables)
    }
    
    private func resetEmptySearchStringSubscriber(){
        $searchText.sink { searchBarString in
            if searchBarString == "" {
                self.allCurrencies = self.preFilterCurrencyList
            }
        }.store(in: &cancellables)
    }
    
    func sortRank(){
        sortOption = sortOption == .rank ? .rankReversed : .rank
    }
    
    func sortPrice(){
        sortOption = sortOption == .price ? .prieReversed : .price
    }
    
     func filterAndSortCurrerncies(text:String, currencies:[Currency], sort:SortOptions) ->[Currency] {
        var filteredCurrencies = filterCurrenciesByText(text: text, currencies: currencies)
         sortCurrenciesByRankAndPrice(sort: sort, currencies: &filteredCurrencies)
        return filteredCurrencies
    }
    
    func sortCurrenciesByRankAndPrice(sort:SortOptions, currencies:inout[Currency]) {
        switch sort {
        case .rank:
            currencies.sort {$0.rank < $1.rank}
        case .rankReversed:
            currencies.sort {$0.rank > $1.rank}
        case .price:
            currencies.sort {$0.currentPrice > $1.currentPrice}
        case .prieReversed:
            currencies.sort { $0.currentPrice < $1.currentPrice}
        }
    }
    
    func filterCurrenciesByText(text:String,currencies:[Currency]) ->[Currency]{
        guard !text.isEmpty else {
            return currencies
        }
        let lowercaseText = text.lowercased()
        return  currencies.filter { currency in
            return  currency.name.lowercased().contains(lowercaseText) ||
            currency.symbol.lowercased().contains(lowercaseText) || currency.id.lowercased()
                .contains(lowercaseText)
        }
    }
}

