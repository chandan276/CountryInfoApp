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
    
    var title: String {
        return countryData.title ?? "Title not available"
    }
    
    var description: String {
        return countryData.description ?? "Description not available"
    }
    
    var imageUrl: String {
        return countryData.imageHref ?? ""
    }
}
