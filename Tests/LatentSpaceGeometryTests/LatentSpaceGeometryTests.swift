import Testing
import FoundationModels
@testable import LatentSpaceGeometry

@Test func capitalCityTranslation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricTranslation(from: "France", to: "Paris", on: "Italy")
    
    #expect(element.name == "Rome")
}

@Test func tributaryTranslation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricTranslation(
        from: "Rhône River",
        to: "Saône River",
        on: "Mississippi River"
    )
    
    #expect(element.name == "Missouri River")
}

@Test func soundProductionTranslation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricTranslation(from: "dog", to: "barking", on: "cat")
    
    #expect(element.name == "meow")
}

@Test func jeanValjeanTranslation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricTranslation(
        from: "Victor Hugo",
        to: "Jean Valjean",
        on: "Charles Dickens"
    )
    
    #expect(element.name == "Oliver Twist")
}

@Test func scroogeTranslation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricTranslation(
        from: "Charles Dickens",
        to: "Scrooge character", // Scrooge personality traits override the character
        on: "Victor Hugo"
    )
    
    #expect(element.name == "Jean Valjean")
}

@Test func matterStateInterpolation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricInterpolation(
        between: "steam",
        and: "ice"
    )
    
    #expect(element.name == "water")
}

@Test func polygonInterpolation() async throws {
    let session = LanguageModelSession()
    
    let element = try await session.geometricInterpolation(
        between: "equilateral triangle",
        and: "equilateral pentagon"
    )
    
    #expect(element.name == "square")
}
