//
//  Helper.swift
//  Finance
//
//  Created by Gautam Menon on 26/08/23.
//

import Foundation

public let currencyy: NumberFormatter = {
    let num = NumberFormatter()
    num.numberStyle = .currency
    num.maximumFractionDigits = 0
    num.currencyCode = "INR"
    return num
}()
