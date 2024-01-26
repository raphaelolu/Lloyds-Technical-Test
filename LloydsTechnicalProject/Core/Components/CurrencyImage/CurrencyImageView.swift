//
//  CurrencyImageView.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import SwiftUI

struct CurrencyImageView: View {

    @StateObject var viewModel:CurrencyImageViewModel
    private let factory:ViewModelFactory
    
    init(currency:Currency,factory:ViewModelFactory) {
        self.factory = factory
        _viewModel = StateObject(wrappedValue:factory.makeCurrencyImageViewModel(currency: currency))
    }
                                 
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loaded:
                if let image = viewModel.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            case .failed(_):
                Image(systemName: "questionMark")
                    .foregroundColor(Color.theme.secondaryText)
            case .loading:
                ProgressView()
            }
        }
    }
}
