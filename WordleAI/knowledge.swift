//
//  knowledge.swift
//  WordleAI
//
//  Created by Loyi Hsu on 2022/1/21.
//

import Foundation

protocol Knowledge {
    func enforce(on original: Set<String>) -> Set<String>
}

struct NoCharacter: Knowledge {
    var character: Character
    func enforce(on original: Set<String>) -> Set<String> {
        return original.filter({ !$0.contains(character) })
    }
}

struct NotAtPosition: Knowledge {
    var character: Character
    var position: Int
    func enforce(on original: Set<String>) -> Set<String> {
        guard (0..<5).contains(position) else {
            fatalError("Knowledge cannot be fullfilled.")
        }
        return original.filter({
            let position = $0.index($0.startIndex, offsetBy: position)
            return $0[position] != character && $0.contains(character)
        })
    }
}

struct CharAtPosition: Knowledge {
    var character: Character
    var position: Int
    func enforce(on original: Set<String>) -> Set<String> {
        guard (0..<5).contains(position) else {
            fatalError("Knowledge cannot be fullfilled.")
        }
        return original.filter({
            let position = $0.index($0.startIndex, offsetBy: position)
            return $0[position] == character
        })
    }
}
