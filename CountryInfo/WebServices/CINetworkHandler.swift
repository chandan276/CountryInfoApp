//
//  CINetworkHandler.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation
import Alamofire

class CINetworkHandler: NSObject {
    
    class func getCountryData(_ strURL: String, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: strURL)!) { (data, res, err) in
            
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        success(jsonData)
                    } else {
                        failure(err!)
                    }
                }
            }
            }.resume()
    }
}
