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
        /*Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
         
         //let utf8Data = String(decoding: responseObject, as: UTF8.self).data(using: .utf8)
         print(responseObject)
         
         if responseObject.result.isSuccess {
         success(responseObject.result.value! as! [String : Any])
         }
         if responseObject.result.isFailure {
         let error : Error = responseObject.result.error!
         failure(error)
         }
         }*/
        
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        success(jsonData)
                        do {
                            //let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                            
                            
                            
//                            if let arr = json["rows"] as? [[String: Any]] {
//                                debugPrint(arr)
//                            }
                        } catch {
                            NSLog("ERROR \(error.localizedDescription)")
                            failure(error)
                        }
                    } else {
                        
                    }
                }
            }
            }.resume()
    }
}
