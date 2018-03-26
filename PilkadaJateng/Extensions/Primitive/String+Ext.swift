//
//  String+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

extension String {
    func removeChar(_ chars: [Character]) -> String {
        let string = String(chars)
        return components(separatedBy: CharacterSet(charactersIn: string)).joined()
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
}

extension String {
    struct BoolRepresentation {
        static let `default` = BoolRepresentation(true: "true", false: "false")
        let `true`: String
        let `false`: String
    }
    
    func toBool(_ representation: BoolRepresentation = .default) -> Bool {
        if self == representation.true {
            return true
        } else if self == representation.false {
            return false
        } else {
            #if DEBUG
            fatalError("Bool representation not set for string value \(self)")
            #else
            return false
            #endif
        }
    }
}

extension String {
    func toInt() -> Int? {
        return Int(self)
    }
}
