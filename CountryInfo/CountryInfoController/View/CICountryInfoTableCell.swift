//
//  CICountryInfoTableCell.swift
//  CountryInfo
//
//  Created by Chandan Singh on 10/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CountryInfoCell: UITableViewCell {
    
    var minHeight: CGFloat?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add the UI elements and provide contraints
        addSubview(countryInfoImageView)
        addSubview(countryInfoTitleLabel)
        addSubview(countryInfoDescriptionLabel)
        
        //Set Contraint for each element in the cell
        countryInfoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: Constants.App.Dimensions.cellImageWidth, height: Constants.App.Dimensions.cellImageHeight, enableInsets: false)
        
        countryInfoTitleLabel.anchor(top: topAnchor, left: countryInfoImageView.rightAnchor, bottom: countryInfoDescriptionLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: self.frame.size.width - countryInfoImageView.frame.size.width - 15, height: 0, enableInsets: false)
        
        countryInfoDescriptionLabel.anchor(top: countryInfoTitleLabel.bottomAnchor, left: countryInfoImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: self.frame.size.width - countryInfoImageView.frame.size.width - 15, height: 0, enableInsets: false)
    }
    
    //Adopted for miminum Cell height
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
