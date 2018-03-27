//
//  BeritaItem.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONInitializable {
    init(_ json: JSON)
}

struct BeritaItem {
    var title: String
    var content: String
    var date: Date
}

struct BeritaItemList {
    var items: [BeritaItem]
}

extension BeritaItem: JSONInitializable {
    init(_ json: JSON) {
        title = json["title"].string.or("")
        content = json["content"].string.or("")
        date = json["date"].string.or("")
            .toDate(format: "yyyy-MM-dd hh:mm:ss") // 2014-03-07 09:15:48
            .or(Date())
    }
}

extension BeritaItemList: JSONInitializable {
    init(_ json: JSON) {
        items = json["posts"].map({ (_, json) -> BeritaItem in
            return BeritaItem(json)
        })
    }
}
