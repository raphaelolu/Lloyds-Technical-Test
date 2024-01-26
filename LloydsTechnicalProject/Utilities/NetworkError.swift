//
//  NetworkError.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation

enum NetworkingError:LocalizedError {
    case badURLResponse(url:URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url : let url): return "bad url response from URL \(url)"
        case .unknown: return "Unknown error occoured"
        }
    }
}
