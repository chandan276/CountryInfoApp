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
    
    //MARK: View Model
    public var viewModel: CIInfoCellViewModel? {
        didSet {
            LazyImageLoad.setImageOnImageViewFromURL(imageView: (self.countryInfoImageView), url: viewModel?.imageUrl ?? "") { [weak self] (image) in
                if let self = self {
                    if image == nil {
                        self.countryInfoImageView.image = UIImage(named: Constants.App.Images.placeholderImage)
                    }
                }
            }
            self.countryInfoTitleLabel.text = viewModel?.title
            self.countryInfoDescriptionLabel.text = viewModel?.description
        }
    }
    
    //MARK: UI Elements
    private let countryInfoImageView : UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.roundCorners(cornerRadius: Double(Constants.App.Dimensions.cellImageWidth / 2))
        return imageView
    }()
    
    private let countryInfoTitleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Constants.App.Colors.cellTitleColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.App.Font.cellTitleFont)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private let countryInfoDescriptionLabel : UILabel = {
        let desriptionLabel = UILabel()
        desriptionLabel.textColor = Constants.App.Colors.cellDescriptionColor
        desriptionLabel.font = UIFont.systemFont(ofSize: Constants.App.Font.cellDescriptionFont)
        desriptionLabel.textAlignment = .center
        desriptionLabel.numberOfLines = 0
        return desriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Add the UI elements and provide contraints
        self.backgroundColor = Constants.App.Colors.defaultBackgroundColor
        self.contentView.clipsToBounds = true
        
        addSubview(countryInfoImageView)
        addSubview(countryInfoTitleLabel)
        addSubview(countryInfoDescriptionLabel)
        
        //Set Contraint for each element in the cell
        countryInfoImageView.anchor(top: topAnchor, left: nil, bottom: countryInfoTitleLabel.topAnchor, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: Constants.App.Dimensions.cellImageWidth, height: Constants.App.Dimensions.cellImageHeight, enableInsets: false)
        countryInfoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        countryInfoTitleLabel.anchor(top: countryInfoImageView.bottomAnchor, left: leftAnchor, bottom: countryInfoDescriptionLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: self.frame.size.width - 15, height: 0, enableInsets: false)
        countryInfoTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        countryInfoDescriptionLabel.anchor(top: countryInfoTitleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: self.frame.size.width - 15, height: 0, enableInsets: false)
        countryInfoDescriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
