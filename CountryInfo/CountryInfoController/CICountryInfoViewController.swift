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
        tableView.register(CountryInfoCell.self, forCellReuseIdentifier: cellId)
        
        configureRefreshControl()
        getCountryData()
    }
    
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Country Data ...")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Country Data
        getCountryData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryInfoCell
        cell.viewModel = viewModel.infoCellViewModel(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
