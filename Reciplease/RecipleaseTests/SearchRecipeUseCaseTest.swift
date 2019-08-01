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
        
        XCTAssertTrue(output.ingredients.isEmpty)
    }
    
    func test_receiveWithEmptyIngredients_doesNotSendsEmptyIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "")
        
        XCTAssertTrue(output.ingredients.isEmpty)
    }
    
    func test_receiveWithEmptyIngredients_sendsFormattedErrorDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "")
        
        XCTAssertEqual(output.error, "No ingredients !")
    }
    
    func test_receive_sendsListIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes"])
    }
    
    func test_receiveTwiceWithTheSameIngredient_sendsListIngredientsListDataOutputWithOneIngredient() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes, Tomatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes"])
    }
    
    func test_receiveWithIngredients_DoesNotSendsFormattedErrorDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes")
        
        XCTAssertNil(output.error)
    }
    
    func test_receiveWithMultipleIngredientsWithComa_sendsListIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes, Potatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithoutComa_sendsListIngredientsListDataOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes Potatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithoutCapitalized_sendsListIngredientsListDataOutputCapitalized() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "tomatoes potatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithMultipleWhiteSpace_sendsListIngredientsListDataOutputWithoutWhiteSpace() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "tomatoes  potatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsWithMultipleComma_sendsListIngredientsListDataOutputWithoutComma() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes,, Potatoes")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes"])
    }
    
    func test_receiveWithMultipleIngredientsStartWithCommaAndEndWithWhiteSpace_sendsListIngredientsListDataOutputWithoutCommaAndWhiteSpace() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: ",Tomatoes, Potatoes ")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes"])
    }
    
    func test_receivedMultipleIngredients_sendListIngredientsFormmated() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: ",Tomatoes,  Potatoes meal: orange,  ")
        
        XCTAssertEqual(output.ingredients, ["Tomatoes", "Potatoes", "Meal", "Orange"])
    }
    
    func test_deleteWithNonEmptyList_notifiesOutput() {
        let (sut, output) = makeSUT()
        
        sut.receive(ingredients: "Tomatoes")
        sut.delete()
        
        XCTAssertEqual(output.deleteCallcount, 1)
    }
    
    func test_deleteWithEmptyList_notifiesOutputWithAnError() {
        let (sut, output) = makeSUT()

        sut.delete()

        XCTAssertEqual(output.deleteCallcount, 0)
        XCTAssertEqual(output.error, "No ingredients in your list !")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: SearchRecipeUseCase, output: OutputSpy) {
        let output = OutputSpy()
        let sut = SearchRecipeUseCase(output: output)
        return (sut, output)
    }
    
    private class OutputSpy: SearchRecipeUseCaseOutput {
        var ingredients = Set<String>()
        var error: String?
        var deleteCallcount = 0
        
        func didReceived(ingredients: Set<String>) {
            self.ingredients = ingredients
        }
        
        func sendError(_ error: String) {
            self.error = error
        }
        
        func didDelete() {
            deleteCallcount += 1
        }
    }
}
