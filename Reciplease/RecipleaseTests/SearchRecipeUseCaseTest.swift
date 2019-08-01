//
//  SearchRecipeUseCaseTest.swift
//  RecipleaseTests
//
//  Created by Christophe Bugnon on 01/08/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import XCTest
import Reciplease

class SearchRecipeUseCaseTest: XCTestCase {
    
    func test_init_DoesNotSendIngredientsDataOutput() {
        let (_, output) = makeSUT()
        
        XCTAssertTrue(output.messages.isEmpty)
    }
    
    func test_receiveWithEmptyIngredients_doesNotSendsEmptyIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "")
        
        XCTAssertTrue(output.messages.isEmpty)
    }
    
    func test_receive_sendsListIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes")
        
        XCTAssertEqual(output.messages, ["Tomatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithComa_sendsListIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes, Potatoes")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithoutComa_sendsListIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes Potatoes")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithoutCapitalized_sendsListIngredientsListDataOutputCapitalized() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "tomatoes potatoes")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithMultipleWhiteSpace_sendsListIngredientsListDataOutputWithoutWhiteSpace() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "tomatoes  potatoes")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithMultipleComma_sendsListIngredientsListDataOutputWithoutComma() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes,, Potatoes")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsStartWithCommaAndEndWithWhiteSpace_sendsListIngredientsListDataOutputWithoutCommaAndWhiteSpace() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: ",Tomatoes, Potatoes ")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes"])
    }
    
    func test_receivedMultipleIngredients_sendListIngredientsFormmated() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: ",Tomatoes,  Potatoes meal: orange,  ")
        
        XCTAssertEqual(output.messages, ["Tomatoes", "Potatoes", "Meal", "Orange"])
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: SearchRecipeUseCase, output: OutputSpy) {
        let output = OutputSpy()
        let sut = SearchRecipeUseCase(output: output)
        return (sut, output)
    }
    
    private class OutputSpy: SearchRecipeUseCaseOutput {
        var messages = [String]()
        
        func didReceived(ingredients: [String]) {
            messages = ingredients
        }
    }
}
