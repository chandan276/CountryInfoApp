//
//  CICollectionViewContainer.swift
//  CountryInfo
//
//  Created by Chandan Singh on 11/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CollectionViewContainer: UIView {

    fileprivate var collectionView: UICollectionView?
    fileprivate let cellId = Constants.CellIdentifiers.homeScreenCollectionCellId
    
    weak var delegate: RefreshDataProtocol? = nil
    
    public var viewModel: CICountryInfoViewModel? {
        didSet {
            collectionView?.reloadData()
            collectionView?.refreshControl?.endRefreshing()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        configureRefreshControl()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI setup method
    func setupCollectionView()  {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: layout)
        if let collectionView = self.collectionView {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = Constants.App.Colors.collectionViewBackgroundColor
            self.addSubview(collectionView)
            
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
            
            collectionView.register(CountryInfoCollectionCell.self, forCellWithReuseIdentifier: cellId)
        }
    }
    
    //MARK: PullToRefresh Methods
    @objc private func refreshData(_ sender: Any) {
        // Fetch Country Data on Refresh
        if let refreshDelegate = delegate {
            refreshDelegate.refreshCountryData()
        }
    }
    
    func configureRefreshControl() {
        //Create instance of RefreshControl and add it to UI
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: kPullToRefreshText)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        //Check the device type and add the refresh control to available UI
        if CIUtils.getCurrentDevice() == .iPhone {
            self.collectionView?.refreshControl = refreshControl
        } else {
            
        }
    }
}

extension CollectionViewContainer: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.rowsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CountryInfoCollectionCell
        
        //Pass on the viewModel to cell and it will be taken care there.
        cell.viewModel = viewModel!.infoCellViewModel(index: indexPath.row)
        
        return cell
    }
}
