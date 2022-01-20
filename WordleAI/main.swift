//
//  main.swift
//  WordleAI
//
//  Created by Loyi Hsu on 2022/1/20.
//

import Foundation

let knowledge: [Knowledge] = [ ]

if knowledge.isEmpty {
    let goodChoices = words.components(separatedBy: .newlines).filter({ Set($0).count == 5 })   // All the words that have 5 distinct characters
    print(goodChoices.randomElement() ?? "No choice can be made.")
} else {
    var choices = Set(words.components(separatedBy: .newlines))
    for knowledge in knowledge {
        choices = knowledge.enforce(on: choices)
    }
    print(choices.randomElement() ?? "No choice can be made.")
}
