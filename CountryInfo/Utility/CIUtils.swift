//
//  CIUtils.swift
//  CountryInfo
//
//  Created by Chandan Singh on 11/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation
import UIKit

enum UserDeviceType: String {
    case iPhone, iPad, Others
}

class CIUtils {
    
    static func getCurrentDevice() -> UserDeviceType {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .iPhone
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return .iPad
        }
        return .Others
    }
}
