//
//  SearchRecipeUseCaseTest.swift
//  RecipleaseTests
//
//  Created by Christophe Bugnon on 01/08/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest

protocol SearchRecipeUseCaseOutput {
    
}

final class SearchRecipeUseCase {
    init(output: SearchRecipeUseCaseOutput) {
        
    }
    
    func receive() {
        
    }
}

class SearchRecipeUseCaseTest: XCTestCase {
    
    func test_init_DoesNotSendIngredientsDataOutput() {
        let output = OutputSpy()
        _ = SearchRecipeUseCase(output: output)
        
        XCTAssertTrue(output.messages.isEmpty)
    }
    
    func test_receive_sendsEmptyIngredientsListDataOutput() {
        let output = OutputSpy()
        let sut = SearchRecipeUseCase(output: output)
        
        sut.receive()
        
        XCTAssertTrue(output.messages.isEmpty)
    }
    
    class OutputSpy: SearchRecipeUseCaseOutput {
        var messages = [String]()
        
    }
}
