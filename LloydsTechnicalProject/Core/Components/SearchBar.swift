//
//  SearchBar.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchBarText:String
    var body: some View {
      
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchBarText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
                .disableAutocorrection(true)
            TextField("Search by name or symbol", text:$searchBarText)
                .overlay(Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(Color.theme.accent)
                    .opacity(searchBarText.isEmpty ? 0.0  : 1.0)
                         
                    .onTapGesture {
                        UIApplication.shared.endEditting()
                        
                        searchBarText = ""
                    }
                    ,alignment: .trailing)
        }.font(.headline)
            .padding()
            .background(RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.background)
            .shadow(color:Color.theme.accent.opacity(0.15), radius: 10,x:0.0,y:0)
            ).padding()
    }
}

#Preview {
    Group {
        SearchBarView(searchBarText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        SearchBarView(searchBarText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
