//
//  LloydsTechnicalProjectTests.swift
//  LloydsTechnicalProjectTests
//
//  Created by raphael olumofe on 25/01/2024.
//

import XCTest
@testable import LloydsTechnicalProject

final class HomepageViewModelHomepageViewModelTests: XCTestCase {

    var dependencies:Dependencies?
    var sut:HomeViewModel?
    
    override func setUpWithError() throws {
        dependencies = Dependencies()
        sut = dependencies?.makeHomePageViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_sortCurrenciesByRankAndPrice_sortsByCurrentPriceInReversedOrder() throws {
        // Given
        var currenncies = MockCurrencyData.returnCurrencyArray()
        //When
        sut?.sortCurrenciesByRankAndPrice(sort: .prieReversed, currencies: &currenncies)
        for index in 0..<currenncies.count - 1 {
            let leftItem = currenncies[index]
            let rightItem = currenncies[index + 1]
            //Then
            XCTAssertGreaterThanOrEqual(rightItem.currentPrice,leftItem.currentPrice)
        }
    }
    
    func test_sortCurrenciesByRankAndPrice_sortsByCurrentPrice() throws {
        // Given
        var currencies = MockCurrencyData.returnCurrencyArray()
        //When
        sut?.sortCurrenciesByRankAndPrice(sort: .price, currencies: &currencies)
        for index in 0..<currencies.count - 1 {
            let leftItem = currencies[index]
            let rightItem = currencies[index + 1]
            //Then
            XCTAssertGreaterThanOrEqual(leftItem.currentPrice,rightItem.currentPrice)
        }
    }
    
    func test_sortCurrenciesByRankAndPrice_ordersByRank() throws {
        // Given
        var currencies = MockCurrencyData.returnCurrencyArray()
        //When
        sut?.sortCurrenciesByRankAndPrice(sort: .rank, currencies: &currencies)
        for index in 0..<currencies.count - 1 {
            let leftItem = currencies[index]
            let rightItem = currencies[index + 1]
            //Then
            XCTAssertLessThanOrEqual(leftItem.rank, rightItem.rank)
        }
    }
    
    func test_sortCurrenciesByRankAndPrice_ordersByRankReversed() throws {
        // Given
        var currencies = MockCurrencyData.returnCurrencyArray()
        //When
        sut?.sortCurrenciesByRankAndPrice(sort: .rankReversed, currencies: &currencies)
        
        for index in 0..<currencies.count - 1 {
            let leftItem = currencies[index]
            let rightItem = currencies[index + 1]
            //Then
            XCTAssertGreaterThanOrEqual(leftItem.rank, rightItem.rank)
        }
    }
    
    func test_filterCurrenciesByText_ReturnsArrayContainingMatchedCurrenciesByName() throws {
        //Given
        let currencies = MockCurrencyData.returnCurrencyArray()
        let currencyNameSubString = "it"
        //When
        let filteredCurrencies = sut?.filterCurrenciesByText(text: currencyNameSubString, currencies: currencies)
        //Then
        XCTAssertEqual("Bitcoin", filteredCurrencies?[0].name)
        XCTAssertEqual(1, filteredCurrencies?.count)
    }
    
    func test_filterCurrenciesByText_returnsArrayContainingMatchedCurrenciesByID() throws {
        //Given
        let  currencies = MockCurrencyData.returnCurrencyArray()
        let currencyIdSubString = "er-n"
        //When
        let filteredcurrency = sut?.filterCurrenciesByText(text: currencyIdSubString, currencies: currencies)
        //Then
        XCTAssertEqual("casper-network", filteredcurrency?[0].id)
        XCTAssertEqual(1, filteredcurrency?.count)
    }
    //TODO
    func test_filterCurrenciesByText_returnsArrayContainingMatchedCurrencyBySymbol() throws {
        //Given
        let currencies = MockCurrencyData.returnCurrencyArray()
        let symbolSubString = "sp"
        //When
        let filteredcurrencies = sut?.filterCurrenciesByText(text: symbolSubString, currencies: currencies)
        //Then
        XCTAssertEqual("cspr", filteredcurrencies?[0].symbol)
        XCTAssertEqual("Casper Network", filteredcurrencies?[0].name)
        XCTAssertEqual(1, filteredcurrencies?.count)
    }
    
    func test_filterAndSortCurrerncies_sortsByPriceAndSubstrings() throws {
        //Given
        let subString =  "-net"
        let filteredAndSortedArray = sut?.filterAndSortCurrerncies(text: subString, currencies: MockCurrencyData.returnCurrencyArray(), sort: .price)
        
        guard let filteredAndSortedArray = filteredAndSortedArray,filteredAndSortedArray.count >= 1 else {
            XCTFail("No items in filtered and sorted array")
            return
        }
        //Then
        for item in filteredAndSortedArray {
            XCTAssertTrue(item.name.contains(subString) || item.id.contains(subString) || item.symbol.contains(subString))
        }
        
        guard filteredAndSortedArray.count >= 1 else {
            XCTFail("No items in filtered and sorted array")
            return
        }
        
        for index in 0..<filteredAndSortedArray.count - 1 {
            let leftCurrency = filteredAndSortedArray[index]
            let rightCurrency = filteredAndSortedArray[index + 1]
            XCTAssertGreaterThanOrEqual(leftCurrency.currentPrice,rightCurrency.currentPrice)
        }
    }
    
    func test_filterAndSortCurrerncies_sortsByPriceReversedAndSubstrings() throws {
        //Given
        let subString = "-network"
        
        //When
        let filteredAndSortedArray = sut?.filterAndSortCurrerncies(text: "-network", currencies: MockCurrencyData.returnCurrencyArray(), sort: .prieReversed)
        guard let filteredAndSortedArray = filteredAndSortedArray,filteredAndSortedArray.count >= 1 else {
            XCTFail("No items in filtered and sorted array")
            return
        }
        
        //Then
        for item in filteredAndSortedArray {
            XCTAssertTrue(item.name.contains(subString) || item.id.contains(subString) || item.symbol.contains(subString))
        }
        
        
        for index in 0..<filteredAndSortedArray.count - 1 {
            let leftCurrency = filteredAndSortedArray[index]
            let rightCurrency = filteredAndSortedArray[index + 1]
            XCTAssertGreaterThanOrEqual(rightCurrency.currentPrice,leftCurrency.currentPrice)
        }
    }
    
    func test_filterAndSortCurrerncies_sortsByRankAndSubstrings() throws {
        //Given
        let subString = "shold"
        
        //When
        let filteredAndSortedArray = sut?.filterAndSortCurrerncies(text: subString, currencies: MockCurrencyData.returnCurrencyArray(), sort: .rank)
        guard let filteredAndSortedArray = filteredAndSortedArray,filteredAndSortedArray.count >= 1 else {
            XCTFail("No items in filtered and sorted array")
            return
        }
        
        //Then
        for item in filteredAndSortedArray {
            XCTAssertTrue(item.name.contains(subString) || item.id.contains(subString) || item.symbol.contains(subString))
        }
        
        for index in 0..<filteredAndSortedArray.count - 1 {
            let leftCurrency = filteredAndSortedArray[index]
            let rightCurrency = filteredAndSortedArray[index + 1]
            XCTAssertLessThanOrEqual(leftCurrency.rank, rightCurrency.rank)
        }
    }
    
    func test_filterAndSortCurrerncies_sortsByRankReversedAndSubstrings() throws {
        //Given
        let substring = "xeth"
        
        //When
        let filteredAndSortedArray = sut?.filterAndSortCurrerncies(text: substring, currencies: MockCurrencyData.returnCurrencyArray(), sort: .rankReversed)
        guard let filteredAndSortedArray = filteredAndSortedArray,filteredAndSortedArray.count >= 1 else {
            XCTFail("No items in filtered and sorted array")
            return
        }
        
        //Then
        for item in filteredAndSortedArray {
            XCTAssertTrue(item.name.contains(substring) || item.id.contains(substring) || item.symbol.contains(substring))
        }
        
        for index in 0..<filteredAndSortedArray.count - 1 {
            let leftCurrency = filteredAndSortedArray[index]
            let rightCurrency = filteredAndSortedArray[index + 1]
            XCTAssertLessThanOrEqual(rightCurrency.rank, leftCurrency.rank)
        }
    }
}
