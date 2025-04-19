//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    var name: String { get }
    func price() -> Int
}

class Item: SKU {
    var name: String
    var priceEach: Int
    
    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEach = priceEach
    }
    
    func price() -> Int {
        return self.priceEach
    }
}

class Receipt {
    var itemList: [SKU]
    
    init() {
        itemList = []
    }
    
    func items() -> [SKU] {
        return self.itemList
    }
    
    func output() -> String {
        var toPrint = "Receipt:\n"
        var total = 0.0
        for item in itemList {
            let price = Double(item.price()) / 100.0
            let name = item.name
            toPrint += "\(name): $\(String(format: "%.2f", price))\n"
            total += price
        }
        toPrint += "------------------\n"
        toPrint += "TOTAL: $\(String(format: "%.2f", total))"
        return toPrint
    }
    
    func total() -> Int {
        var total = 0
        for item in itemList {
            total += item.price()
        }
        return total
    }
}

class Register {
    var receipt: Receipt
    
    init() {
        self.receipt = Receipt()
    }
    
    func scan(_ item: SKU) {
        self.receipt.itemList.append(item)
    }
    
    func subtotal() -> Int {
        let currItems = self.receipt.items()
        var subtotal = 0
        for item in currItems {
            subtotal += item.price()
        }
        return subtotal
    }
    
    func total() -> Receipt {
        let currReceipt = self.receipt
        self.receipt = Receipt()
        return currReceipt
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

