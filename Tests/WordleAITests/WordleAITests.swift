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
        let found = try XCTUnwrap(findOne(with: conditions))
        XCTAssertEqual(found, "proxy")
    }
    func testGenerateAGoodItemWithoutKnowledge() throws {
        let found = try XCTUnwrap(findOne())
        XCTAssertEqual(Set(found).count, 5)
    }
    func testContraditionRemoval() throws {
        var conditions: [Knowledge] = [
            NotAtPosition(character: "a", position: 0),
            CharAtPosition(character: "a", position: 0)
        ]
        var optimised = conditions.optimised()
        XCTAssertEqual(optimised.count, 1)
        XCTAssert(optimised[0].equals(another: conditions[1]))
        conditions = [
            NoCharacter(character: "a"),
            CharAtPosition(character: "a", position: 0)
        ]
        optimised = conditions.optimised()
        XCTAssertEqual(optimised.count, 1)
        XCTAssert(optimised[0].equals(another: conditions[1]))
        conditions = [
            NotAtPosition(character: "a", position: 0),
            NoCharacter(character: "a")
        ]
        optimised = conditions.optimised()
        XCTAssertEqual(optimised.count, 1)
        XCTAssert(optimised[0].equals(another: conditions[0]))

        conditions = [
            NotAtPosition(character: "a", position: 0),
            CharAtPosition(character: "a", position: 1)
        ]
        optimised = conditions.optimised()
        XCTAssertEqual(optimised.count, 2)
    }

    func testDuplicateRemoval() throws {
        let conditions: [Knowledge] = [
            NotAtPosition(character: "a", position: 0),
            NotAtPosition(character: "a", position: 0)
        ]
        XCTAssertEqual(conditions.optimised().count, 1)
    }
}
