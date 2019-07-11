//
//  CITableViewContainer.swift
//  CountryInfo
//
//  Created by Chandan Singh on 11/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

protocol RefreshDataProtocol: class {
    func refreshCountryData()
}

class TableViewContainer: UIView {
    
    fileprivate var tableView: UITableView?
    fileprivate let cellId = Constants.CellIdentifiers.homeScreenTableCellId
    private let minimumRowHeight: CGFloat = 90.0
    
    weak var delegate: RefreshDataProtocol? = nil
    
    public var viewModel: CICountryInfoViewModel? {
        didSet {
            tableView?.reloadData()
            tableView?.refreshControl?.endRefreshing()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        configureRefreshControl()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI setup method
    func setupTableView()  {
        
        self.tableView = UITableView()
        if let tableView = self.tableView {
            tableView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            tableView.dataSource = self
            tableView.delegate = self
            
            self.addSubview(tableView)
            
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
            
            tableView.estimatedRowHeight = 90.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(CountryInfoCell.self, forCellReuseIdentifier: cellId)
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
            self.tableView?.refreshControl = refreshControl
        } else {
            
        }
    }
}

extension TableViewContainer: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rowsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryInfoCell
        
        //Pass on the viewModel to cell and it will be taken care there.
        cell.viewModel = viewModel!.infoCellViewModel(index: indexPath.row)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //return (UITableView.automaticDimension > minimumRowHeight) ? UITableView.automaticDimension : minimumRowHeight
    }
    
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return (UITableView.automaticDimension > minimumRowHeight) ? UITableView.automaticDimension : minimumRowHeight
    //    }
}
