//
//  ContentView.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import SwiftUI

struct HomepageView: View {
    @StateObject private var viewModel:HomeViewModel
    private let factory: ViewModelFactory
    @State private var selected:Currency? = nil
    
    init(factory:ViewModelFactory){
        self.factory = factory
        _viewModel = StateObject(wrappedValue: factory.makeHomePageViewModel())
    }
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack{
                switch viewModel.state {
                case .failed(let error):
                    Text(error)
                case .loaded:
                    SearchBarView(searchBarText: $viewModel.searchText)
                    columnTitles
                    allCourrenciesList
                        .transition(.move(edge: .leading))
                case .loading:
                    Spacer()
                    ProgressView()
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomepageView {
    private var allCourrenciesList: some View {
        List{
            ForEach(viewModel.allCurrencies){ currency in
                NavigationLink {
                    CurrencyDetailView(currency: currency, factory: factory)
                } label: {
                    CurrencyRowView(currency: currency, factory: factory)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
        }
        .listStyle(PlainListStyle()) }
    
    private var columnTitles: some View {
        HStack{
            HStack(spacing:4){
                Text("Rank")
                Image(systemName: "chevron.down").opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0).rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180 ))
            }.onTapGesture {
                withAnimation(.default) {
                    viewModel.sortRank()
                }
            }
            Spacer()
            HStack(spacing:4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .prieReversed) ? 1.0 : 0.0).rotationEffect(Angle(degrees: viewModel.sortOption == .price  ? 0 : 180 ))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortPrice()
                }
            }
            
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
    }
    
}
