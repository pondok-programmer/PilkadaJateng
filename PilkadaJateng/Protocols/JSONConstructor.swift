//
//  protocol JSONConstructor.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONConstructor {
    static func mapFromJSON(json: JSON) -> Self
}
