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
    
    override func loadView() {
        super.loadView()
        
        //Load initial View
        self.setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kDefaultHomePageTitle
        self.view.backgroundColor = Constants.App.Colors.defaultBackgroundColor
        
        //Get Data from server
        getCountryData()
        
        //Check the network and show error when unreachable
        ConnectionManager.sharedInstance.reachability.whenUnreachable = { [weak self] reachability in
            if let self = self {
                self.showOfflineAlert()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableContainerView?.frame = self.viewFrame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    var viewFrame: CGRect {
        return CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
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
            
            tableContainerView.translatesAutoresizingMaskIntoConstraints = true
            view.addConstraint(NSLayoutConstraint(item: tableContainerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: tableContainerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: tableContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: tableContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        }
    }
    
    func setupCollectionContainerView() {
        collectionContainerView = CollectionViewContainer(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        if let collectionContainerView = collectionContainerView {
            collectionContainerView.delegate = self
            self.view.addSubview(collectionContainerView)
            
            collectionContainerView.translatesAutoresizingMaskIntoConstraints = true
            view.addConstraint(NSLayoutConstraint(item: collectionContainerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: collectionContainerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: collectionContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: collectionContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
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
