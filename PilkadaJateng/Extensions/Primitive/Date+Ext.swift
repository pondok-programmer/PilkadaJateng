//
//  Date+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let f = DateFormatter()
        f.dateFormat = format
        return f.string(from: self)
    }
}
