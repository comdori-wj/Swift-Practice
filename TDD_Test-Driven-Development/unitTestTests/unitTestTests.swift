//
//  unitTestTests.swift
//  unitTestTests
//
//  Created by Wonji Ha on 2023/09/25.
//

import XCTest
@testable import unitTest

final class unitTestTests: XCTestCase {

    let sut = StringCalculator()
    
    func test_nil_입력하면0이_출력됨() {
        
        let result = sut.compute(input : nil)
        XCTAssertEqual(0, result)
        
    }
        
    func test_1을입력하면_1이_출력됨() {
        let result = sut.compute(input: "1")
        print(result)
        XCTAssertEqual(1, result)
        
    }
    
    func test_1_2를_입력하면_3이출력됨() {
        // input1, input2가 아니라 input: "1,2"임
        let result = sut.compute3(input: "1,2")
        XCTAssertEqual(3, result)
    }
    
    func test_1_2_3_를_입력하면_6출력() {
        // 1, 2:3을 입력
        let result = sut.compute4(input: "1,2:3")
        XCTAssertEqual(6, result)
    }

    func test2() {
        let result = sut.sum(input: "1,2")
        XCTAssertEqual(3, result)
        print(result)
    }
    


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
