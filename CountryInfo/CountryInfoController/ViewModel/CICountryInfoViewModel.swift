//
//  CICountryInfoViewModel.swift
//  CountryInfo
//
//  Created by Chandan Singh on 10/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

class CICountryInfoViewModel {
    private var countryDataModel: Response?
    
    public var screenTitle: String {
        guard let title = countryDataModel?.title else {
            return "Country Info"
        }
        
        return title
    }
    
    public var rowsCount: Int {
        guard let count = countryDataModel?.countryData?.count else {
            return 0
        }
        
        return count
    }
    
    public func infoCellViewModel(index: Int) -> CIInfoCellViewModel? {
        if rowsCount > 0 {
            guard let dataModel = countryDataModel else {
                return nil
            }
            
            guard let countryData = dataModel.countryData else {
                return nil
            }
            
            let cellModel = CIInfoCellViewModel(data: countryData[index])
            return cellModel
        }
        return nil
    }
}

extension CICountryInfoViewModel {
    
    func getCountryData(completion: @escaping (CICountryInfoViewModel) -> ()) {
        CINetworkHandler.getCountryData("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", success: { (jsonData) in
            do {
                let decoder = JSONDecoder()
                self.countryDataModel = try decoder.decode(Response.self, from: jsonData as! Data)
                
                DispatchQueue.main.async {
                    completion(self)
                }
            } catch {
                
            }
        }) { (error) in
            
        }
    }
}
