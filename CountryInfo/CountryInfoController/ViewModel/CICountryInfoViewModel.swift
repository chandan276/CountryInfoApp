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
    private(set) var errorMessage: String? = nil
    
    public var screenTitle: String {
        guard let title = countryDataModel?.title else {
            return kDefaultHomePageTitle
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
    
    var errorString : String? {
        get {
            return errorMessage
        }
    }
}

extension CICountryInfoViewModel {
    
    func getCountryData(completion: @escaping (CICountryInfoViewModel) -> ()) {
        CINetworkHandler.getCountryData(Constants.WebService.serviceUrl, success: { (jsonData) in
            do {
                let decoder = JSONDecoder()
                self.countryDataModel = try decoder.decode(Response.self, from: jsonData as! Data)
                
                DispatchQueue.main.async {
                    completion(self)
                }
            } catch {
                self.errorMessage = kNetworkError
            }
        }) { (error) in
            self.errorMessage = kNetworkError
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
