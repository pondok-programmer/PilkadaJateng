//
//  Optional+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

extension Optional {
    
    /// Default if nil
    ///
    /// - Parameter value: value provided if nil
    /// - Returns: return value unwrapped
    func or(_ value: Wrapped) -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return value
        }
    }
}

extension Optional where Wrapped: Equatable {
    func orFatalError(alsoIf fatalValue: Wrapped) -> Wrapped {
        switch self {
        case let .some(value):
            if value == fatalValue {
                fatalError("Couldn't value of \(fatalValue)")
            } else {
                return value
            }
        case .none:
            fatalError("Must not be nil")
        }
    }
}



