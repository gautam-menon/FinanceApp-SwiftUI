//
//  Constants.swift
//  Finance
//
//  Created by Gautam Menon on 26/08/23.
//

import Foundation
import SwiftUI

let appName = "Luchha 2.0"
let appColor = Color("appColor")
let secondaryColor = Color("secondaryColor")
let primaryColor = Color("primaryColor")
let backgroundColor = Color(.tertiarySystemBackground)
let rupeeSign = "₹"
let filterWidth = UIScreen.main.bounds.width / CGFloat(SortTypes.allCases.count) - 10

enum SortTypes: String, CaseIterable, Identifiable{
    var id: String {
        return self.rawValue
    }
    var isDescending: Bool {
        switch self {
            
        case .Latest:
            return true
        case .Oldest:
            return false
        case .HighToLow:
            return false
        case .LowToHigh:
            return true
        }
    }
    var text: String {
        switch self {
        case .HighToLow:
           return "amount"
        case .LowToHigh:
            return "amount"
        case .Latest:
            return "timeStamp"
        case .Oldest:
            return "timeStamp"
        }
    }
    
    case Latest = "Latest"
    case Oldest = "Oldest"
    case HighToLow = "High to Low"
    case LowToHigh = "Low to High"
}
