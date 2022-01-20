//
//  toolkit.swift
//  
//
//  Created by Loyi Hsu on 2022/1/21.
//

import Foundation

public func find(with knowledge: [Knowledge] = []) -> String? {
    if knowledge.isEmpty {
        // All the words that have 5 distinct characters
        let goodChoices = words.components(separatedBy: .newlines).filter({ Set($0).count == 5 })
        return goodChoices.randomElement()
    } else {
        var choices = Set(words.components(separatedBy: .newlines))
        for knowledge in knowledge {
            choices = knowledge.enforce(on: choices)
        }
        return choices.randomElement()
    }
}
