//
//  finder.swift
//  WordleAI
//
//  Created by Loyi Hsu on 2022/1/21.
//

import Foundation

public class Finder {
    var past = Set<String>()

    public init() {
        reset()
    }

    public func reset() {
        past = []
    }

    public func findOne(with knowledge: [Knowledge] = []) -> String? {
        let all = findAll(with: knowledge)
        let weighted = all.flatMap({ [String](repeating: $0, count: Set($0).count) })
        if let one = weighted.randomElement() {
            past.insert(one)
            return one
        }
        return nil
    }

    public func findAll(with knowledge: [Knowledge] = []) -> Set<String> {
        let knowledge = knowledge.optimised()
        if knowledge.isEmpty {
            // All the words that have 5 distinct characters
            return Set(words.components(separatedBy: .newlines).filter({ Set($0).count == 5 }))
        } else {
            var choices = Set(words.components(separatedBy: .newlines))
            choices = choices.filter({ !past.contains($0) })
            for knowledge in knowledge {
                choices = knowledge.enforce(on: choices)
            }
            return choices
        }
    }
}
