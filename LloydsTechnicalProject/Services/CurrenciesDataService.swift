//
//  CurrenciesDataService.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation
import Combine

protocol HompepageDataServicesProtocol {
    func sendRequest() -> AnyPublisher<[Currency],NetworkingError>
}

class HompepageDataServices:HompepageDataServicesProtocol {
    
        func sendRequest() -> AnyPublisher<[Currency],NetworkingError> {
            guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en") else {
                precondition(false, "Invalid URL")
            }
            return URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap { try NetworkingManager.handldeURLResponse(output: $0, url: url)
                }
                .decode(type: [Currency].self, decoder: JSONDecoder())
                .mapError { error -> NetworkingError in
                    return NetworkingError.badURLResponse(url: url)
                }
                .eraseToAnyPublisher()
        }
}
