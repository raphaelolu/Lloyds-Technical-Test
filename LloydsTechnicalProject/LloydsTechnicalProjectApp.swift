//
//  LloydsTechnicalProjectApp.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import SwiftUI

@main
struct LloydsTechnicalProjectApp: App {
    let dependencies = Dependencies()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomepageView(factory: dependencies).navigationTitle("Lloyds Crypto")
            }
        }
    }
}
