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
    
    #expect(result == "meowing")
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
