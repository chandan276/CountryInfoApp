//
//  CIAlertPresenter.swift
//  CountryInfo
//
//  Created by Chandan Singh on 10/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CIAlertPresenter {
    
    static func showAlertMessage(viewController: UIViewController, titleString:String, messageString:String) -> Void {
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title: kAlertOkButtonText, style: .cancel, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
