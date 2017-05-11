//
//  Currencies.swift
//  CurrencyExchange
//
//  Created by Trajon Felton on 5/7/17.
//  Copyright © 2017 Trajon Felton. All rights reserved.
//

import Foundation

class Currency {
    var name : String
    var check : Bool
    var isoCode : String
    var symbol : String
    init(name: String, check: Bool, isoCode: String, symbol : String){
        self.name = name
        self.check = check
        self.isoCode = isoCode
        self.symbol = symbol
    }
    
class list {
    var c = [Currency(name: "US Dollar", check: false, isoCode: "USD", symbol: "\u{0024}"), Currency(name: "British Pound", check: false, isoCode: "GBP", symbol: "\u{00A3}"), Currency(name: "Canadian Dollar", check: false, isoCode: "CAD", symbol: "\u{0024}"), Currency(name: "Australlian Dollar", check: false, isoCode: "AUD", symbol: "\u{0024}"), Currency(name: "Indian Rupee", check: false, isoCode: "INR", symbol: "\u{20B9}"), Currency(name: "Euro", check: false, isoCode: "EUR",symbol: "\u{20AC}")]
    static let shared = list()
    }
}
