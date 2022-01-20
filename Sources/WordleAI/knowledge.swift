//
//  knowledge.swift
//  WordleAI
//
//  Created by Loyi Hsu on 2022/1/21.
//

public protocol Knowledge {
    func enforce(on original: Set<String>) -> Set<String>
}

public struct NoCharacter: Knowledge {
    var character: Character
    public init(character: Character) {
        self.character = character
    }
    public func enforce(on original: Set<String>) -> Set<String> {
        return original.filter({ !$0.contains(character) })
    }
}

public struct NotAtPosition: Knowledge {
    var character: Character
    var position: Int
    public init(character: Character, position: Int) {
        self.character = character
        self.position = position
    }
    public func enforce(on original: Set<String>) -> Set<String> {
        guard (0..<5).contains(position) else {
            fatalError("Knowledge cannot be fullfilled.")
        }
        return original.filter({
            let position = $0.index($0.startIndex, offsetBy: position)
            return $0[position] != character && $0.contains(character)
        })
    }
}

public struct CharAtPosition: Knowledge {
    var character: Character
    var position: Int
    public init(character: Character, position: Int) {
        self.character = character
        self.position = position
    }
    public func enforce(on original: Set<String>) -> Set<String> {
        guard (0..<5).contains(position) else {
            fatalError("Knowledge cannot be fullfilled.")
        }
        return original.filter({
            let position = $0.index($0.startIndex, offsetBy: position)
            return $0[position] == character
        })
    }
}
