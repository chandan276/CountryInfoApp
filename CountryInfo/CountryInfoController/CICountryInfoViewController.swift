//
//  CICountryInfoViewController.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CICountryInfoViewController: UITableViewController {

    fileprivate let cellId = "countryTableCellId"
    fileprivate var viewModel = CICountryInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Country Info"
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CountryInfoCell.self, forCellReuseIdentifier: cellId)
        
        configureRefreshControl()
        getCountryData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: PullToRefresh Methods
    @objc private func refreshData(_ sender: Any) {
        // Fetch Country Data
        getCountryData()
    }
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Country Data ...")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    //MARK: Get Data from Server
    func getCountryData() {
        viewModel.getCountryData { [weak self] (countryInfoViewModel) in
            if let self = self {
                self.viewModel = countryInfoViewModel
                self.title = self.viewModel.screenTitle
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension CICountryInfoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryInfoCell
        cell.viewModel = viewModel.infoCellViewModel(index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView.rowHeight < 60.0 {
//            return 90.0
//        }
//        return UITableView.automaticDimension
//    }
}
