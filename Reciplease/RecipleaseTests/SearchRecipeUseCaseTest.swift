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
        let (_, output) = makeSUT()
        
        XCTAssertTrue(output.messages.isEmpty)
    }
    
    func test_receive_sendsEmptyIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive()
        
        XCTAssertTrue(output.messages.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: SearchRecipeUseCase, output: OutputSpy) {
        let output = OutputSpy()
        let sut = SearchRecipeUseCase(output: output)
        return (sut, output)
    }
    
    private class OutputSpy: SearchRecipeUseCaseOutput {
        var messages = [String]()
        
    }
}
