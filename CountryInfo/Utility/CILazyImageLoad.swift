//
//  CILazyImageLoad.swift
//  CountryInfo
//
//  Created by Chandan Singh on 12/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class LazyImageLoad {
    
    static func setImageOnImageViewFromURL(imageView : UIImageView, url:String?, response:@escaping (_ image : UIImage?) -> Void) {
        
        guard let urlString = url else {
            return
        }
        
        guard let pathURL = getURLFromString(url: urlString) else {
            response(nil)
            return
        }
        
        imageView.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setImage(with: pathURL, completed: { (image, error, type, url) in
            response(image)
        })
    }
    
    class func getURLFromString(url : String) -> URL?
    {
        let removePercentEncodeURL  = url.removingPercentEncoding
        let urlWithEscapeString = removePercentEncodeURL?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        if urlWithEscapeString == nil {
            return nil
        }
        
        let  strURL : URL? = URL(string: (urlWithEscapeString)!)
        return strURL
    }
}
