//
//  JitenshaTests.swift
//  JitenshaTests
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import XCTest
@testable import Jitensha

class JitenshaTests: XCTestCase {
    
    var session:Session! = nil
    var place:Place! = nil
    
    override func setUp() {
        super.setUp()
        self.session = Session()
        self.session.email = "crossover@crossover.com"
        self.session.accessToken = "token"
        
        self.place = Place()
        self.place.id = "123456789"
        self.place.name = "Some Place"
        self.place.lat = 35.70
        self.place.lng = 139.73
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Session Model Tests
    
    func testSession() {
        XCTAssert(self.session != nil, "NOT Valid Session")
    }
    
    func testSessionEmail() {
        XCTAssert(self.session.email == "crossover@crossover.com", "NOT Session Email")
    }
    
    func testSessionToken() {
        XCTAssert(self.session.accessToken == "token", "NOT Session Token")
    }
    
    //MARK: Place Model Tests
    
    func testPlace() {
        XCTAssert(self.place != nil, "NOT Valid Place")
    }
    
    func testPlaceID() {
        XCTAssert(self.place.id == "123456789", "NOT Place ID")
    }
    
    func testPlaceName() {
        XCTAssert(self.place.name == "Some Place", "NOT Place Name")
    }
    
    func testPlaceLatitude() {
        
        NSLog("\(self.place.lat)")
        
        XCTAssert(self.place.lat == 35.7, "NOT Place Latitude")
    }
    
    func testPlaceLongitude() {
        NSLog("\(self.place.lng)")
        
        XCTAssert(self.place.lng == 139.73, "NOT Place Longitude")
    }
    
    //MARK : Integration Tests
    
    func testLoginAPICall() {
        let readyExpectation = expectationWithDescription("ready")
        
        let email = "crossover@crossover.com"
        let pass = "crossover"
        
        APIManager.sharedInstance.getSession(email, password: pass, completion: {
            (sessionObject, error) in
            
            if error == nil {
                
                XCTAssertTrue(error == nil, "Error Is Present")
                XCTAssertTrue(sessionObject != nil, "Invalid Session")
                
                // And fulfill the expectation...
                readyExpectation.fulfill()
            }
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testRegisterAPICall() {
        let readyExpectation = expectationWithDescription("ready")
        
        let email = "crossover@crossover.com"
        let pass = "crossover"
        
        APIManager.sharedInstance.register(email, password: pass, completion: {
            (sessionObj, error) in
            
            XCTAssertTrue(error == nil, "Error Is Present")
            XCTAssertTrue(sessionObj != nil, "Invalid Session")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testPlacesAPICall() {
        let readyExpectation = expectationWithDescription("ready")
        
        
        APIManager.sharedInstance.getPlaces({
            (places, error) in
            
            XCTAssertTrue(error == nil, "Error Is Present")
            XCTAssertTrue(places.count > 0, "Invalid Places")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testPaymentAPICall() {
        let readyExpectation = expectationWithDescription("ready")
        
        let number = "1234123412341234"
        let name = "Hayao Miyazaki"
        let exp = "11/20"
        let code = "754"
        
        APIManager.sharedInstance.payment(number, name: name, exp: exp, code: code, completion: {
            (message, error) in
            
            XCTAssertTrue(error == nil, "Error Is Present")
            XCTAssertTrue(message == "Rent operation has been completed", "Invalid Message")
            
            // And fulfill the expectation...
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
}
