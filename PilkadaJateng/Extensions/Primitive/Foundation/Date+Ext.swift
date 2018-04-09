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
        f.locale = Locale(identifier: "id_ID")
        return f.string(from: self)
    }
}
