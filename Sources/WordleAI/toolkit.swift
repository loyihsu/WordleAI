//
//  toolkit.swift
//  
//
//  Created by Loyi Hsu on 2022/1/21.
//

import Foundation

public func findOne(with knowledge: [Knowledge] = []) -> String? {
    return findAll(with: knowledge).randomElement()
}

public func findAll(with knowledge: [Knowledge] = []) -> Set<String> {
    if knowledge.isEmpty {
        // All the words that have 5 distinct characters
        return Set(words.components(separatedBy: .newlines).filter({ Set($0).count == 5 }))
    } else {
        var choices = Set(words.components(separatedBy: .newlines))
        for knowledge in knowledge {
            choices = knowledge.enforce(on: choices)
        }
        return choices
    }
}
