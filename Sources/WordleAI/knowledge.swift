/**
 # Runner (WordleAI)
 Created by Yu-Sung Loyi Hsu on 2022/1/21
 */

public protocol Knowledge {
    var type: KnowledgeType { get }
    func enforce(on original: Set<String>) -> Set<String>
    func equals(another: Knowledge) -> Bool
}

public enum KnowledgeType {
    case noCharacter, notAtPosition, charAtPosition
}

public struct NoCharacter: Knowledge, Equatable {
    public func equals(another: Knowledge) -> Bool {
        guard self.type == another.type else { return false}
        return self == another as! Self
    }

    public var type: KnowledgeType { return .noCharacter }
    var character: Character
    public init(character: Character) {
        let character = character.isUppercase ? Character(character.lowercased()) : character
        self.character = character
    }
    public func enforce(on original: Set<String>) -> Set<String> {
        return original.filter({ !$0.contains(character) })
    }
}

public struct NotAtPosition: Knowledge, Equatable {
    public func equals(another: Knowledge) -> Bool {
        guard self.type == another.type else { return false}
        return self == another as! Self
    }

    public var type: KnowledgeType { return .notAtPosition }
    var character: Character
    var position: Int
    public init(character: Character, position: Int) {
        let character = character.isUppercase ? Character(character.lowercased()) : character
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

public struct CharAtPosition: Knowledge, Equatable {
    public func equals(another: Knowledge) -> Bool {
        guard self.type == another.type else { return false}
        return self == another as! Self
    }
    public var type: KnowledgeType { return .charAtPosition }
    var character: Character
    var position: Int
    public init(character: Character, position: Int) {
        let character = character.isUppercase ? Character(character.lowercased()) : character
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

extension Array where Element == Knowledge {
    func optimised() -> [Element] {
        // Remove duplicates.
        var filtered = [Element]()
        for element in self where !filtered.contains(where: { knowledge in
            if knowledge.type == element.type {
                switch knowledge.type {
                case .noCharacter: return knowledge as! NoCharacter == element as! NoCharacter
                case .notAtPosition: return knowledge as! NotAtPosition == element as! NotAtPosition
                case .charAtPosition: return knowledge as! CharAtPosition == element as! CharAtPosition
                }
            }
            return false
        }) {
            filtered.append(element)
        }

        var toRemove = [Int]()

        // Remove conflicts
        for first in filtered.indices {
            for second in filtered.indices where first != second {
                conflictDispatcher(first: (filtered[first], first),
                               second: (filtered[second], second),
                               toRemove: &toRemove)
            }
        }

        toRemove.sort(by: >)

        for idx in toRemove {
            filtered.remove(at: idx)
        }

        return filtered
    }
}
