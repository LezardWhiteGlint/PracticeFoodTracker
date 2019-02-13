//
//  PracticeFoodTrackerTests.swift
//  PracticeFoodTrackerTests
//
//  Created by Lezardvaleth on 2019/2/8.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import XCTest
@testable import PracticeBoobsTracker

class PracticeBoobsTrackerTests: XCTestCase {
    //MARK: Boob class tests
    func testBoobInitializationSucceeds() {
        //Zero rating
        let zeroRatingBoob = Boob.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingBoob)
        //Highest positive rating
        let positiveRatingBoob = Boob.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingBoob)
    }
    // Confirm that the boob initialier returns nil when passed a negative rating or an empty name.
    func testBoobInitializationFails() {
        //Negative rating
        let negativeRatingBoob = Boob.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingBoob)
        //Empty string
        let emptyStringBoob = Boob.init(name: "", photo: nil, rating: 1)
        XCTAssertNil(emptyStringBoob)
        let largeRatingBoob = Boob.init(name: "Really Large Yeah", photo: nil, rating: 6)
        XCTAssertNil(largeRatingBoob)
    }
}
