//
//  CIInfoCellViewModel.swift
//  CountryInfo
//
//  Created by Chandan Singh on 10/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

class CIInfoCellViewModel {

    private let countryData: CountryData
    
    init(data: CountryData) {
        self.countryData = data
    }
    
    //Title of the cell
    var title: String {
        return countryData.title ?? kTitleUnavailableText
    }
    
    //Description of the cell
    var description: String {
        return countryData.description ?? kDescriptionUnavailableText
    }
    
    //Imgage url to fetch image for the cell
    var imageUrl: String {
        return countryData.imageHref ?? ""
    }
}
