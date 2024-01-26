//
//  Colour.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColour")
    let background = Color("BackgroundColour")
    let green = Color("GreenColour")
    let red  = Color("RedColour")
    let secondaryText = Color("SecondaryTextColour")
}

