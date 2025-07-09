import Testing
import FoundationModels
@testable import LatentSpaceGeometry

@Test func capitalCityTranslation() async throws {
    let session = LanguageModelSession()
    
    let result = try await session.geometricTranslation(from: "France", to: "Paris", on: "Italy")
    
    #expect(result == "Rome")
}

@Test func soundProductionTranslation() async throws {
    let session = LanguageModelSession()
    
    let result = try await session.geometricTranslation(from: "dog", to: "barking", on: "cat")
    
    #expect(result == "meow")
}

@Test func tributaryTranslation() async throws {
    let session = LanguageModelSession()
    
    let result = try await session.geometricTranslation(
        from: "Rhône River",
        to: "Saône River",
        on: "Mississippi River"
    )
    
    #expect(result == "Missouri River")
}

@Test func jeanValjeanTranslation() async throws {
    let session = LanguageModelSession()
    
    let result = try await session.geometricTranslation(
        from: "Victor Hugo",
        to: "Jean Valjean",
        on: "Charles Dickens"
    )
    
    #expect(result == "Oliver Twist")
}

@Test func scroogeTranslation() async throws {
    let session = LanguageModelSession()
    
    let result = try await session.geometricTranslation(
        from: "Charles Dickens",
        to: "character Scrooge", // Scrooge personality trait overrides the character
        on: "Victor Hugo"
    )
    
    #expect(result == "Jean Valjean")
}
