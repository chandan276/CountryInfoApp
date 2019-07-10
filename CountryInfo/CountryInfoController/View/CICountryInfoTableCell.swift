//
//  CICountryInfoTableCell.swift
//  CountryInfo
//
//  Created by Chandan Singh on 10/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CountryInfoCell : UITableViewCell {
    
    public var viewModel: CIInfoCellViewModel? {
        didSet {
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
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private let countryInfoDescriptionLabel : UILabel = {
        let desriptionLabel = UILabel()
        desriptionLabel.textColor = .black
        desriptionLabel.font = UIFont.systemFont(ofSize: 16)
        desriptionLabel.textAlignment = .left
        desriptionLabel.numberOfLines = 0
        return desriptionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(countryInfoImageView)
        addSubview(countryInfoTitleLabel)
        addSubview(countryInfoDescriptionLabel)
        
        countryInfoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        countryInfoTitleLabel.anchor(top: topAnchor, left: countryInfoImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        countryInfoDescriptionLabel.anchor(top: countryInfoTitleLabel.bottomAnchor, left: countryInfoImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
