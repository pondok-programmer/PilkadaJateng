//
//  NetworkManager.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkManager {
    func url(for urlString: String) -> URL? {
        return URL(string: urlString)
    }
    
    func get(from url: URL, completion: @escaping (JSON?, Error?) -> () ) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data {
                completion(JSON(data), nil)
            }
        }
        
        dataTask.resume()
    }
}
