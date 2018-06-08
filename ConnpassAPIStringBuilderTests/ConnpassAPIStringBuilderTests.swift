//
//  ConnpassAPIStringBuilderTests.swift
//  ConnpassAPIStringBuilderTests
//
//  Created by hmhm on 2018/06/07.
//  Copyright © 2018 hmhm. All rights reserved.
//

@testable import ConnpassAPIStringBuilder
import XCTest

class ConnpassAPIStringBuilderTests: XCTestCase {
}

/*
 * ConnpassAPIQueryStringBuilder
 */
extension ConnpassAPIStringBuilderTests {
    // queryが反映されているか
    func testEventId() {
        let request = "https://connpass.com/api/v1/event/?event_id=0"
        let urlStr = ConnpassAPIQueryBuilder().eventId(0).string()
        XCTAssertEqual(request, urlStr)
    }
    
    // 1つのqueryに複数の値を入れたらどうか
    func testEventIds() {
        let request = "https://connpass.com/api/v1/event/?event_id=0&event_id=1"
        let urlStr = ConnpassAPIQueryBuilder().eventId(0, 1).string()
        XCTAssertEqual(request, urlStr)
    }
    
    // queryが複数だとどうか
    func testMultiQuery() {
        let request = "https://connpass.com/api/v1/event/?keyword=swift&start=30"
        let urlStr = ConnpassAPIQueryBuilder().keywordAnd("swift").start(30).string()
        XCTAssertEqual(request, urlStr)
    }
    
    // dateが2桁に変換されているかどうか
    func testDate() {
        let request = "https://connpass.com/api/v1/event/?ymd=20180607"
        let urlStr = ConnpassAPIQueryBuilder().date(.init(year: 2018, month: 6, day: 7)).string()
        XCTAssertEqual(request, urlStr)
    }
    
    // orderが数値に変換されているかどうか
    func testOrder() {
        let request = "https://connpass.com/api/v1/event/?order=1"
        let urlStr = ConnpassAPIQueryBuilder().order(.update).string()
        XCTAssertEqual(request, urlStr)
    }
    
    // countの最大値が100になっているか
    func testCountMax() {
        let request = "https://connpass.com/api/v1/event/?count=100"
        let urlStr = ConnpassAPIQueryBuilder().count(200).string()
        XCTAssertEqual(request, urlStr)
    }
    
    // countの最小値が1になっているか
    func testCountMin() {
        let request = "https://connpass.com/api/v1/event/?count=1"
        let urlStr = ConnpassAPIQueryBuilder().count(0).string()
        XCTAssertEqual(request, urlStr)
    }
}

/*
 * ConnpassAPIQueryDictionaryBuilder
 */
extension ConnpassAPIStringBuilderTests {
    // queryが格納されているか
    func testDictionaryEventId() {
        // valueがあっているかどうか
        let key = "event_id"
        let value = 0
        let dictionary = ConnpassAPIQueryBuilder().eventId(value).dictionary()
        let actual = dictionary[key] as! Int
        XCTAssertEqual(value, actual)
        
        // keyが1つしかないかどうか
        let keys = [key]
        let actualKeys = dictionary.keys.map { (key) -> String in
            key
        }
        XCTAssertEqual(keys, actualKeys)
    }

    // 1つのqueryに複数の値を入れたらどうか
    func testDictionaryEventIds() {
        let key = "event_id"
        let value = [0, 1]
        let dictionary = ConnpassAPIQueryBuilder().eventId(0, 1).dictionary()
        let actual = dictionary[key] as! [Int]
        XCTAssertEqual(value, actual)
        
        let keys = [key]
        let actualKeys = dictionary.keys.map { (key) -> String in
            key
        }
        XCTAssertEqual(keys, actualKeys)
    }

    // queryが複数だとどうか
    func testDictionaryMultiQuery() {
        let key1 = "keyword"
        let key2 = "start"
        let value1 = ["swift", "kotlin"]
        let value2 = 30
        let dictionary = ConnpassAPIQueryBuilder().keywordAnd("swift", "kotlin").start(value2).dictionary()
        let actual1 = dictionary[key1] as! [String]
        let actual2 = dictionary[key2] as! Int
        XCTAssertEqual(value1, actual1)
        XCTAssertEqual(value2, actual2)

        let keys = [key1, key2]
        let actualKeys = dictionary.keys.map { (key) -> String in
            key
        }
        XCTAssertEqual(keys, actualKeys)
    }
}
