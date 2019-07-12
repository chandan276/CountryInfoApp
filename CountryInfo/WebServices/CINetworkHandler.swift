//
//  CINetworkHandler.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

class CINetworkHandler: NSObject {
    
    class func getCountryData(_ strURL: String, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void) {
        
        guard let url = URL(string: strURL) else {
            print("Error: cannot create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let d = data {
                //Returns a String initialized by converting given data into Unicode characters using a ASCII encoding.
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    
                    //Returns a Data containing a representation of the String encoded using a UTF8 encoding.
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        success(jsonData)
                    } else {
                        failure(err!)
                    }
                }
            } else {
                failure(err!)
            }
            }.resume()
    }
}
