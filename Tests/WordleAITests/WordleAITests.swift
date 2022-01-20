import XCTest
@testable import WordleAI

final class WordleAITests: XCTestCase {
    func testConditionSystem() throws {
        let conditions: [Knowledge] = [
            NotAtPosition(character: "p", position: 4),
            NotAtPosition(character: "r", position: 2),
            NotAtPosition(character: "o", position: 3),
            NotAtPosition(character: "x", position: 0),
            NotAtPosition(character: "y", position: 1),
        ]
        let found = try XCTUnwrap(find(with: conditions))
        XCTAssertEqual(found, "proxy")
    }
    func testGenerateAGoodItemWithoutKnowledge() throws {
        let found = try XCTUnwrap(find())
        XCTAssertEqual(Set(found).count, 5)
    }
}
