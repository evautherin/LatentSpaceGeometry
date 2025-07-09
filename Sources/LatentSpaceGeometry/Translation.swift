//
//  Translation.swift
//  LatentSpaceGeometry
//
//  Created by Etienne Vautherin on 03/07/2025.
//

import FoundationModels


@Generable(description: "Conceptual Element")
struct ElementDescriptor {
    let description: String
    let name: String
}

@Generable(description: "Conceptual relationship")
struct RelationshipDescriptor {
    let description: String
    
    @Guide(description: """
            Extract just the concise, generalized term describing the nature of the concept that brings the relationship (e.g., 'fiction character', 'river'), without mentioning any specific entities described elsewhere.
            """)
    let nature: String
    
    @Guide(description: """
            Extract and provide just the concise, generalized term naming the conceptual relationship (e.g., 'capital city', 'parent company'), without mentioning any specific entities described elsewhere.
            """)
    let name: String
    
    static func semanticVector(
        from source: String,
        to target: String,
        in session: LanguageModelSession
    ) async throws -> Self {
        
        let response = try await session.respond (
            to: """
            Give the nature of \(target) and the main notion that usually makes to think about \(target) when the \(source) is mentioned.
            Name this notion by removing any specific reference to the \(source)"
            """,
            generating: Self.self,
            options: GenerationOptions(sampling: .greedy)
        )
        return response.content
    }
    
    func apply(to element: String, in session: LanguageModelSession) async throws -> ElementDescriptor {
        let response = try await session.respond (
            to: """
            Give the \(nature) associated to \(name) that makes to thing about \(element).
            """,
            generating: ElementDescriptor.self,
            options: GenerationOptions(sampling: .greedy)
            )
        return response.content
    }
}

extension LanguageModelSession {
    /// Performs a conceptual translation of an element using a learned relationship between two conceptual domains.
    ///
    /// - Parameters:
    ///   - source: The source conceptual domain or context.
    ///   - target: The target conceptual domain or context.
    ///   - element: The specific item in the source domain to translate.
    /// - Returns: The result of translating the provided element from the source context to the target context, as a `String`.
    /// - Throws: Rethrows errors from underlying language model operations if translation or relationship inference fails.
    public func geometricTranslation(
        from source: String,
        to target: String,
        on element: String
    ) async throws -> String {
        let vector = try await RelationshipDescriptor.semanticVector(from: source, to: target, in: self)
        let result = try await vector.apply(to: element, in: self)
        return result.name
    }
}

