//
//  Extensions+String.swift
//  Reciplease
//
//  Created by Christophe Bugnon on 01/08/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

extension String {
    func validatorIngredients() -> [String] {
        return self.components(separatedBy: .punctuationCharacters)
            .joined(separator: " ")
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map { $0.capitalized }
    }
}
