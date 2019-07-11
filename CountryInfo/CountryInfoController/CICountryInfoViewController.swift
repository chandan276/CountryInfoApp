//
//  CICountryInfoViewController.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CICountryInfoViewController: UIViewController {

    fileprivate var tableContainerView: TableViewContainer?
    fileprivate var collectionContainerView: CollectionViewContainer?
    fileprivate var viewModel = CICountryInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kDefaultHomePageTitle
        
        //Load initial View
        self.setupView()
        
        //Get Data from server
        getCountryData()
        
        //Check the network and show error when unreachable
        ConnectionManager.sharedInstance.reachability.whenUnreachable = { [weak self] reachability in
            if let self = self {
                self.showOfflineAlert()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI setup method
    func setupView() {
        //Check the User device type
        if CIUtils.getCurrentDevice() == .iPhone {
            //Configure TableView for iPhone
            setupTableContainerView()
        } else {
            //Configure CollectionView for iPad
            setupCollectionContainerView()
        }
    }
    
    func setupTableContainerView() {
        tableContainerView = TableViewContainer(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        if let tableContainerView = tableContainerView {
            tableContainerView.delegate = self
            self.view.addSubview(tableContainerView)
            
            tableContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
            tableContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
            tableContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
            tableContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        }
    }
    
    func setupCollectionContainerView() {
        collectionContainerView = CollectionViewContainer(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        if let collectionContainerView = collectionContainerView {
            collectionContainerView.delegate = self
            self.view.addSubview(collectionContainerView)
            
            collectionContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
            collectionContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
            collectionContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
            collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        }
    }
    
    func loadRespectiveViewModel() {
        if CIUtils.getCurrentDevice() == .iPhone {
            self.tableContainerView?.viewModel = viewModel
        } else {
            self.collectionContainerView?.viewModel = viewModel
        }
    }
    
    //MARK: WebService Methods
    func getCountryData() {
        viewModel.getCountryData { [weak self] (countryInfoViewModel) in
            
            if let self = self {
                if let error = self.viewModel.errorString {
                    CIAlertPresenter.showAlertMessage(viewController: self, titleString: "", messageString: error)
                } else {
                    self.viewModel = countryInfoViewModel
                    self.title = self.viewModel.screenTitle
                }
                self.loadRespectiveViewModel()
            }
        }
    }
    
    func showOfflineAlert() {
        CIAlertPresenter.showAlertMessage(viewController: self, titleString: "", messageString: kOfflineMessage)
    }
}

extension CICountryInfoViewController: RefreshDataProtocol {
    
    func refreshCountryData() {
        self.getCountryData()
    }
}
