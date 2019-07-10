//
//  CICountryDataModel.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

struct Response: Codable {
    let title: String?
    let countryData: [CountryData]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case countryData = "rows"
    }
}

struct CountryData: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}
