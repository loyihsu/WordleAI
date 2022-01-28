//
//  optimiser.swift
//  WordleAI
//
//  Created by Yu-Sung Loyi Hsu on 2022/1/28.
//

func conflictDispatcher(first: (Knowledge, Int), second: (Knowledge, Int), toRemove: inout [Int]) {
    if let firstItem = first.0 as? NoCharacter {
        if let secondItem = second.0 as? NotAtPosition {
            conflictFilter(first: (firstItem, first.1), second: (secondItem, second.1), toRemove: &toRemove)
        } else if let secondItem = second.0 as? CharAtPosition {
            conflictFilter(first: (firstItem, first.1), second: (secondItem, second.1), toRemove: &toRemove)
        }
    } else if let firstItem = first.0 as? NotAtPosition {
        if let secondItem = second.0 as? NoCharacter {
            conflictFilter(first: (firstItem, first.1), second: (secondItem, second.1), toRemove: &toRemove)
        } else if let secondItem = second.0 as? CharAtPosition {
            conflictFilter(first: (firstItem, first.1), second: (secondItem, second.1), toRemove: &toRemove)
        }
    } else if let firstItem = first.0 as? CharAtPosition {
        if let secondItem = second.0 as? NoCharacter {
            conflictFilter(first: (firstItem, first.1), second: (secondItem, second.1), toRemove: &toRemove)
        } else if let secondItem = second.0 as? NotAtPosition {
            conflictFilter(first: (firstItem, first.1), second: (secondItem, second.1), toRemove: &toRemove)
        }
    }
}

func conflictFilter(first: (NoCharacter, Int), second: (NotAtPosition, Int), toRemove: inout [Int]) {
    conflictSolver(first: first, second: second, toRemove: &toRemove)
}

func conflictFilter(first: (NoCharacter, Int), second: (CharAtPosition, Int), toRemove: inout [Int]) {
    conflictSolver(first: first, second: second, toRemove: &toRemove)
}

func conflictFilter(first: (NotAtPosition, Int), second: (NoCharacter, Int), toRemove: inout [Int]) {
    conflictSolver(first: second, second: first, toRemove: &toRemove)
}

func conflictFilter(first: (NotAtPosition, Int), second: (CharAtPosition, Int), toRemove: inout [Int]) {
    conflictSolver(first: first, second: second, toRemove: &toRemove)
}

func conflictFilter(first: (CharAtPosition, Int), second: (NoCharacter, Int), toRemove: inout [Int]) {
    conflictSolver(first: second, second: first, toRemove: &toRemove)
}

func conflictFilter(first: (CharAtPosition, Int), second: (NotAtPosition, Int), toRemove: inout [Int]) {
    conflictSolver(first: second, second: first, toRemove: &toRemove)
}

func conflictSolver(first: (NoCharacter, Int), second: (NotAtPosition, Int), toRemove: inout [Int]) {
    guard !toRemove.contains(first.1) else { return }
    guard !toRemove.contains(second.1) else { return }
    // Not at position implies has characater -> remove no character constraint
    if first.0.character == second.0.character {
        toRemove.append(first.1)
    }
}

func conflictSolver(first: (NoCharacter, Int), second: (CharAtPosition, Int), toRemove: inout [Int]) {
    guard !toRemove.contains(first.1) else { return }
    guard !toRemove.contains(second.1) else { return }
    // Character at position implies has character -> remove no chracter constraint
    if first.0.character == second.0.character {
        toRemove.append(first.1)
    }
}

func conflictSolver(first: (NotAtPosition, Int), second: (CharAtPosition, Int), toRemove: inout [Int]) {
    guard !toRemove.contains(first.1) else { return }
    guard !toRemove.contains(second.1) else { return }
    // Character at position is more believable than not at position
    if first.0.character == second.0.character && first.0.position == second.0.position {
        toRemove.append(first.1)
    }
}
