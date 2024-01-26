//
//  UIApplication.swift
//  LloydsTechnicalProject
//
//  Created by raphael olumofe on 25/01/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditting(){
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil,for:nil)
    }
}

