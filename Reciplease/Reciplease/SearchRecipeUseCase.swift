//
//  SearchRecipeUseCase.swift
//  Reciplease
//
//  Created by Christophe Bugnon on 01/08/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public protocol SearchRecipeUseCaseOutput {
    func didReceived(ingredients: Set<String>)
    func sendError(_ error: String)
    func didDelete()
}

public final class SearchRecipeUseCase {
    private var emptyList = true
    let output: SearchRecipeUseCaseOutput
    
    public init(output: SearchRecipeUseCaseOutput) {
        self.output = output
    }
    
    public func receive(ingredients: String) {
        emptyList = ingredients.isEmpty
        if !ingredients.isEmpty {
            output.didReceived(ingredients: Set(ingredients.validatorIngredients()))
        } else {
            output.sendError("No ingredients !")
        }
    }
    
    public func delete() {
        emptyList ? output.sendError("No ingredients in your list !")
            : output.didDelete()
    }
    
    public func search(completion: () -> Void) {
        emptyList ? output.sendError("You need to get ingredients in your list to search recipe !") : completion()
    }
}
