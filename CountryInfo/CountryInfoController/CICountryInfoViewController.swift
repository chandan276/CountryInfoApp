//
//  CICountryInfoViewController.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit
import SVProgressHUD

class CICountryInfoViewController: UIViewController {

    fileprivate var tableContainerView: TableViewContainer?
    fileprivate var viewModel = CICountryInfoViewModel()
    
    override func loadView() {
        super.loadView()
        
        //Load initial View
        setupTableContainerView()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Update the layout when device orientation changes
        self.tableContainerView?.frame = self.viewFrame
    }
    
    //MARK: Rotation Handler Methods
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
    
    //MARK: WebService Methods
    func getCountryData() {
        SVProgressHUD.show()
        viewModel.getCountryData { [weak self] (countryInfoViewModel) in
            
            if let self = self {
                if let error = self.viewModel.errorString {
                    CIAlertPresenter.showAlertMessage(viewController: self, titleString: "", messageString: error)
                } else {
                    self.viewModel = countryInfoViewModel
                    self.title = self.viewModel.screenTitle
                }
                self.tableContainerView?.viewModel = self.viewModel
                SVProgressHUD.dismiss()
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
