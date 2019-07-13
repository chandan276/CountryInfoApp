//
//  CountryInfoTests.swift
//  CountryInfoTests
//
//  Created by Chandan Singh on 09/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import XCTest
@testable import CountryInfo

class CountryInfoTests: XCTestCase {
    
    var title: String?
    var homeViewModel: CICountryInfoViewModel?
    var dataModel: Response?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        homeViewModel = CICountryInfoViewModel()
        dataModel = Response(title: "About Canada", countryData: [])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeViewModel = nil
        dataModel = nil
        
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    /*
    This method check data coming from server or not
     */
    func testServerData() {
        let expectation = XCTestExpectation(description: "Get data from server")
        homeViewModel?.getCountryData(completion: { (viewModel) in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    /*
     This method is used for checking network avialablity is there or not
     */
    func testNetworkAvialability(){
        ConnectionManager.isReachable { (connectionmanager) in
            if (ConnectionManager.sharedInstance.reachability).connection != .none {
                XCTAssertTrue(true, "Suceess")
            }
        }
    }
    
    /*
     This method is used for Testing navigation bar Title of ContainerViewController.
     */
    func testNavBarTitle(){
        if let title = dataModel!.title {
            XCTAssertEqual(title, "About Canada")
        }
    }
    
    /*
     This method is used for Testing number of rows in ContainerTableView
     */
    func testNumbersOfRowOfContainerTableView(){
        guard let tableRows = dataModel!.countryData else {
            return
        }

        XCTAssertEqual(tableRows.count, 0)
    }
    
    /*
     This method is used for Testing UIAlertController.
     */
    func testAlertPresentation(){
        CIAlertPresenter.showAlertMessage(viewController: UIViewController(), titleString: "Test", messageString: "Test Message")
    }
    
    /*
     This method is used for Testing Image load.
     */
    func testImageLoading(){
        LazyImageLoad.setImageOnImageViewFromURL(imageView: UIImageView(), url: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg") { [weak self] (image) in
            if let _ = self, let _ = image {
                XCTAssert(true)
            }
        }
    }
    
    /*
     This method is used for Testing user device type.
     */
    func testUserDeviceType(){
        let userDeviceType = CIUtils.getCurrentDevice()
        if userDeviceType == .iPhone {
            XCTAssertTrue(true, "iPhone")
        } else if userDeviceType == .iPad {
            XCTAssertTrue(true, "iPad")
        } else {
            XCTAssertFalse(false)
        }
    }
}
