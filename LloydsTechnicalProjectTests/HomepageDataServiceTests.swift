//
//  HomepageDataServiceTests.swift
//  LloydsTechnicalProjectTests
//
//  Created by raphael olumofe on 25/01/2024.
//

import XCTest
@testable import LloydsTechnicalProject

final class HomepageDataServiceTests: XCTestCase {
    let sut = Currency.self
 
    func test_currencyModel_isDecodedCorrectly() {
        let decoder = JSONDecoder()
        do {
            let currencyModel = try decoder.decode(sut, from: cannedCurrencyListData())
            XCTAssertEqual(currencyModel.id, "casper-network")
            XCTAssertEqual(currencyModel.marketCapRank, 8.8)
            XCTAssertEqual(currencyModel.symbol, "cspr")
            XCTAssertEqual(currencyModel.atl, 0.0)
        } catch {
            XCTFail("Failed to decode: \(error).")
        }
    }
    
    func cannedCurrencyListData() -> Data {
        
        let mockCurrencyData = MockCurrencyData.returnCurrency()
        let jsonEncoder = JSONEncoder()
        let jsonData = (try? jsonEncoder.encode(mockCurrencyData))!
        return jsonData
    }
}
