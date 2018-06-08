//
//  ConnpassAPIStringBuilderTests.swift
//  ConnpassAPIStringBuilderTests
//
//  Created by hmhm on 2018/06/07.
//  Copyright © 2018 hmhm. All rights reserved.
//

import XCTest
@testable import ConnpassAPIStringBuilder

class ConnpassAPIStringBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    // queryが反映されているか
    func testEventId() {
        let request = "https://connpass.com/api/v1/event/?event_id=0"
        let urlStr = ConnpassAPIQueryBuilder().eventId(0).build()
        XCTAssertEqual(request, urlStr)
    }
    
    // 1つのqueryに複数の値を入れたらどうか
    func testEventIds() {
        let request = "https://connpass.com/api/v1/event/?event_id=0&event_id=1"
        let urlStr = ConnpassAPIQueryBuilder().eventId(0, 1).build()
        XCTAssertEqual(request, urlStr)
    }

    // queryが複数だとどうか
    func testMultiQuery() {
        let request = "https://connpass.com/api/v1/event/?keyword=swift&start=30"
        let urlStr = ConnpassAPIQueryBuilder().keywordAnd("swift").start(30).build()
        XCTAssertEqual(request, urlStr)
    }
    
    // dateが2桁に変換されているかどうか
    func testDate() {
        let request = "https://connpass.com/api/v1/event/?ymd=20180607"
        let urlStr = ConnpassAPIQueryBuilder().date(.init(year: 2018, month: 6, day: 7)).build()
        XCTAssertEqual(request, urlStr)
    }
    
    // orderが数値に変換されているかどうか
    func testOrder() {
        let request = "https://connpass.com/api/v1/event/?order=1"
        let urlStr = ConnpassAPIQueryBuilder().order(.update).build()
        XCTAssertEqual(request, urlStr)
    }

    // countの最大値が100になっているか
    func testCountMax() {
        let request = "https://connpass.com/api/v1/event/?count=100"
        let urlStr = ConnpassAPIQueryBuilder().count(200).build()
        XCTAssertEqual(request, urlStr)
    }
    
    // countの最小値が1になっているか
    func testCountMin() {
        let request = "https://connpass.com/api/v1/event/?count=1"
        let urlStr = ConnpassAPIQueryBuilder().count(0).build()
        XCTAssertEqual(request, urlStr)
    }

}
