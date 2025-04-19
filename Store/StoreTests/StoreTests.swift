//
//  StoreTests.swift
//  StoreTests
//
//  Created by Ted Neward on 2/29/24.
//

import XCTest

final class StoreTests: XCTestCase {

    var register = Register()

    override func setUpWithError() throws {
        register = Register()
    }

    override func tearDownWithError() throws { }

    func testBaseline() throws {
        XCTAssertEqual("0.1", Store().version)
        XCTAssertEqual("Hello world", Store().helloWorld())
    }
    
    func testOneItem() {
        register.scan(Item(name: "Beans (8oz Can)", priceEach: 199))
        XCTAssertEqual(199, register.subtotal())
        
        let receipt = register.total()
        XCTAssertEqual(199, receipt.total())

        let expectedReceipt = """
Receipt:
Beans (8oz Can): $1.99
------------------
TOTAL: $1.99
"""
        XCTAssertEqual(expectedReceipt, receipt.output())
    }
    
    func testThreeSameItems() {
        register.scan(Item(name: "Beans (8oz Can)", priceEach: 199))
        register.scan(Item(name: "Beans (8oz Can)", priceEach: 199))
        register.scan(Item(name: "Beans (8oz Can)", priceEach: 199))
        XCTAssertEqual(199 * 3, register.subtotal())
    }
    
    func testThreeDifferentItems() {
        register.scan(Item(name: "Beans (8oz Can)", priceEach: 199))
        XCTAssertEqual(199, register.subtotal())
        register.scan(Item(name: "Pencil", priceEach: 99))
        XCTAssertEqual(298, register.subtotal())
        register.scan(Item(name: "Granols Bars (Box, 8ct)", priceEach: 499))
        XCTAssertEqual(797, register.subtotal())
        
        let receipt = register.total()
        XCTAssertEqual(797, receipt.total())

        let expectedReceipt = """
Receipt:
Beans (8oz Can): $1.99
Pencil: $0.99
Granols Bars (Box, 8ct): $4.99
------------------
TOTAL: $7.97
"""
        XCTAssertEqual(expectedReceipt, receipt.output())
    }

/* MY TESTS START HERE */
    
    func testAddingOneItem() {
        let item = Item(name: "Organic Mango", priceEach: 120)
        register.scan(item)
        
        XCTAssertEqual(120, register.subtotal())
        let receipt = register.total()
        
        let expectedReceipt = """
Receipt:
Organic Mango: $1.20
------------------
TOTAL: $1.20
"""
        XCTAssertEqual(expectedReceipt, receipt.output())
    }
    
    func testEmptyReceipt() {
        XCTAssertEqual(0, register.subtotal())
        let receipt = register.total()
        XCTAssertEqual(0, receipt.total())
        XCTAssertEqual(0, receipt.items().count)
        let expectedReceipt = """
Receipt:
------------------
TOTAL: $0.00
"""
        XCTAssertEqual(expectedReceipt, receipt.output())
    }
    
    func testScanningDecimals() {
        let item1 = Item(name: "Apple", priceEach: 97)
        let item2 = Item(name: "Onion", priceEach: 121)
        register.scan(item1)
        XCTAssertEqual(97, register.subtotal())
        register.scan(item2)
        XCTAssertEqual(218, register.subtotal())
    }
    
    func testTotalClearsReceipt() {
        let item1 = Item(name: "Almonds", priceEach: 425)
        let item2 = Item(name: "Parmesan Cheese", priceEach: 650)
        register.scan(item1)
        register.scan(item2)
        XCTAssertEqual(1075, register.subtotal())
        let _ = register.total()
        XCTAssertEqual(0, register.subtotal())
    }
    
    func testItemsStoringCorrect() {
        let item = Item(name: "Avocado", priceEach: 89)
        XCTAssertEqual("Avocado", item.name)
        XCTAssertEqual(89, item.priceEach)
    }
}
