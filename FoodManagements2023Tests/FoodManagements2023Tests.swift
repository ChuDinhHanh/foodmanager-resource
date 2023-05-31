//
//  FoodManagements2023Tests.swift
//  FoodManagements2023Tests
//
//  Created by CNTT on 4/20/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import XCTest
@testable import FoodManagements2023

class FoodManagements2023Tests: XCTestCase {
    func testSucceedMealCreate() {
        let nameNotEmpty = Meal(name:"Mon moi", ratingValue:3, imgMeal:nil)
        XCTAssertNotNil(nameNotEmpty)
        let ratingZero = Meal(name: "dgf0", ratingValue: 0, imgMeal: nil)
        XCTAssertNotNil(ratingZero)
        let ratingMax = Meal(name: "dgf0", ratingValue: 5, imgMeal: nil)
        XCTAssertNotNil(ratingMax)
    }
    
    func testFailMealCreate() {
         let nameEmpty = Meal(name:"", ratingValue:3, imgMeal:nil)
         XCTAssertNil(nameEmpty)
         let negativeRatingValue = Meal(name: "dgf0", ratingValue: -1, imgMeal: nil)
         XCTAssertNil(negativeRatingValue)
         let overMaxRatingValue = Meal(name: "dgf0", ratingValue: 6, imgMeal: nil)
         XCTAssertNil(overMaxRatingValue)
    }
}
