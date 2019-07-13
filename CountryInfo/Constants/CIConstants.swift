//
//  CIConstants.swift
//  CountryInfo
//
//  Created by Chandan Singh on 11/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    // Network Constants
    struct WebService {
        static let serviceUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    
    // App Constants
    struct App {
        
        // Home Screen Colors
        struct Colors {
            static let cellTitleColor = UIColor.black
            static let cellDescriptionColor = UIColor.darkGray
            static let defaultBackgroundColor = UIColor.white
            static let collectionViewBackgroundColor = UIColor.lightGray
            static let cellImageBorderColor = UIColor.red
        }
        
        // Home Screen Texts Font
        struct Font {
            static let cellTitleFont: CGFloat = 16.0
            static let cellDescriptionFont: CGFloat = 14.0
        }
        
        // Home Screen Images
        struct Images {
            static let placeholderImage = "PlaceholderImage"
        }
        
        struct Dimensions {
            static let cellImageBorderWidth: CGFloat = 1.0
            static let minimumRowHeight: CGFloat = 90.0
            static let cellImageWidth: CGFloat = 70.0
            static let cellImageHeight: CGFloat = 70.0
            static let collectionCellWidth = 200
            static let collectionCellHeight = 250
            static let collectionEdgeInset: CGFloat = 5
            static let collectionLineSpacing: CGFloat = 10
            static let minimumCellLabelHeight: CGFloat = 19.0
            static let minimumLabelLines = 0
            
            static let stickyConstraint: CGFloat = 0.0
            static let lowConstraint: CGFloat = 5.0
            static let mediumConstraint: CGFloat = 10.0
            static let highConstraint: CGFloat = 15.0
        }
    }
    
    //Cells used in the App
    struct CellIdentifiers {
        static let homeScreenTableCellId = "countryTableCellId"
        static let homeScreenCollectionCellId = "countryCollectionCellId"
    }
}
