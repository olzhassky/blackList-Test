//
//  blackListTests.swift
//  blackListTests
//
//  Created by Olzhas Zhakan on 19.07.2023.
//

import XCTest
import RealmSwift

@testable import blackList

final class blackListTests: XCTestCase {
    var table: TableViewController!
    var menuVC: MenuViewController!
    
    override func setUpWithError() throws {
        table = TableViewController()
        menuVC = MenuViewController()
        
    }

    override func tearDownWithError() throws {
        table = nil
        menuVC = nil
    }

    func testExample() throws {
        let product = ProductClass()
        XCTAssertEqual(product.name, "")
        XCTAssertEqual(product.amount, 0)
        XCTAssertEqual(product.selected, false)
    }
    func textHomeButton() {
        menuVC.homeButton.sendActions(for: .touchUpInside)

    }
    
}
