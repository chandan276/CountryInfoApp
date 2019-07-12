//
//  CINavigationController.swift
//  CountryInfo
//
//  Created by Chandan Singh on 11/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    //When adding contraints programmatically to viewControllers inside UINavigationController. It is better to handle these methods for better experience:
    
    override var shouldAutorotate: Bool {
        if let shouldRotate = self.topViewController?.shouldAutorotate {
            return shouldRotate
        }
        return super.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let orientation = self.topViewController?.supportedInterfaceOrientations {
            return orientation
        }
        return super.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let orientation = self.topViewController?.preferredInterfaceOrientationForPresentation {
            return orientation
        }
        return super.preferredInterfaceOrientationForPresentation
    }
}
