//
//  CICountryInfoCollectionCell.swift
//  CountryInfo
//
//  Created by Chandan Singh on 11/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit
import SDWebImage

class CountryInfoCollectionCell: UICollectionViewCell {
    
    public var viewModel: CIInfoCellViewModel? {
        didSet {
            let imageUrl = URL(string: viewModel?.imageUrl ?? "")
            self.countryInfoImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: Constants.App.Images.placeholderImage), options: SDWebImageOptions.refreshCached) { (image, error, cacheType, url) in
                
                //self.countryInfoImageView.image = image
            }
            self.countryInfoTitleLabel.text = viewModel?.title
            self.countryInfoDescriptionLabel.text = viewModel?.description
        }
    }
    
    private let countryInfoImageView : UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let countryInfoTitleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Constants.App.Colors.cellTitleColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.App.Font.cellTitleFont)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private let countryInfoDescriptionLabel : UILabel = {
        let desriptionLabel = UILabel()
        desriptionLabel.textColor = Constants.App.Colors.cellDescriptionColor
        desriptionLabel.font = UIFont.systemFont(ofSize: Constants.App.Font.cellDescriptionFont)
        desriptionLabel.textAlignment = .left
        desriptionLabel.numberOfLines = 0
        return desriptionLabel
    }()
}
