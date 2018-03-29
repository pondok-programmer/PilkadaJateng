//
//  Array+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    
    /// Update array if element is in.
    /// Append as new element if is not in
    /// - Parameter element: value to be updated
    mutating func update(_ element: Element) {
        if !self.contains(element) {
            self.append(element)
        } else {
            if let index = self.index(of: element) {
                self[index] = element
            }
        }
    }
}
