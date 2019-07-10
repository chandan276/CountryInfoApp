//
//  CICountryInfoViewController.swift
//  CountryInfo
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit

class CICountryInfoViewController: UITableViewController {

    let cellId = "countryTableCellId"
    //var products : [Product]  = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        CINetworkHandler.getCountryData("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", success: { (jsonData) in
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(Response.self, from: jsonData as! Data)
            } catch {
                
            }
        }) { (Error) in
            
        }
        
        createProductArray()
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
//        let currentLastItem = products[indexPath.row]
//        cell.product = currentLastItem
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3//products.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func createProductArray() {
//        products.append(Product(productName: "Glasses", productImage: #imageLiteral(resourceName: "glasses") , productDesc: "This is best Glasses I've ever seen"))
//        products.append(Product(productName: "Desert", productImage: #imageLiteral(resourceName: "desert") , productDesc: "This is so yummy"))
//        products.append(Product(productName: "Camera Lens", productImage:  #imageLiteral(resourceName: "cameralens"), productDesc: "I wish I had this camera lens"))
    }
}

