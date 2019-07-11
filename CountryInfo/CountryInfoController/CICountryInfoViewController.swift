//
//  CICountryInfoViewController.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CICountryInfoViewController: UITableViewController {

    fileprivate let cellId = Constants.CellIdentifiers.homeScreenTableCellId
    fileprivate var viewModel = CICountryInfoViewModel()
    
    private let minimumRowHeight: CGFloat = 90.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kDefaultHomePageTitle
        
        //Check the User device type
        if CIUtils.getCurrentDevice() == .iPhone {
            //Configure TableView for iPhone
            setupTableView()
        } else {
            //Configure CollectionView for iPad
        }
        
        //Add Pull to refresh control
        configureRefreshControl()
        
        //Get Data from server
        getCountryData()
        
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
    func setupTableView()  {
        self.tableView.estimatedRowHeight = 90.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CountryInfoCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK: PullToRefresh Methods
    @objc private func refreshData(_ sender: Any) {
        // Fetch Country Data on Refresh
        getCountryData()
    }
    
    func configureRefreshControl() {
        //Create instance of RefreshControl and add it to UI
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: kPullToRefreshText)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        //Check the device type and add the refresh control to available UI
        if CIUtils.getCurrentDevice() == .iPhone {
            tableView.refreshControl = refreshControl
        } else {
            
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
                    self.tableView.reloadData()
                }
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func showOfflineAlert() {
        CIAlertPresenter.showAlertMessage(viewController: self, titleString: "", messageString: kOfflineMessage)
    }
}

extension CICountryInfoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryInfoCell
        
        //Pass on the viewModel to cell and it will be taken care there.
        cell.viewModel = viewModel.infoCellViewModel(index: indexPath.row)
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //return (UITableView.automaticDimension > minimumRowHeight) ? UITableView.automaticDimension : minimumRowHeight
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return (UITableView.automaticDimension > minimumRowHeight) ? UITableView.automaticDimension : minimumRowHeight
//    }
}
