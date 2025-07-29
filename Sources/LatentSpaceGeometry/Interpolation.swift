//
//  Interpolation.swift
//  LatentSpaceGeometry
//
//  Created by Etienne Vautherin on 29/07/2025.
//

import FoundationModels

@Generable(description: """
    Conceptual continuum between two concepts:
    - concept0
    - concept1 
    """)
struct ContinuumDescriptor {
    let description: String
    
    @Guide(description: """
            Extract just the concise, generalized term describing the nature of concept0 (e.g., 'fiction character', 'river'), without mentioning any specific entities described elsewhere.
            """)
    let nature0: String
    
    @Guide(description: """
            Extract just the concise, generalized term describing the nature of concept1 (e.g., 'fiction character', 'river'), without mentioning any specific entities described elsewhere.
            """)
    let nature1: String
    
    static func continuum(
        between concept0: String,
        and concept1: String,
        in session: LanguageModelSession
    ) async throws -> Self {
        
        let response = try await session.respond(
            to: """
            Imagine a conceptual continuum between
            - \(concept0)
            - \(concept1)
            """,
            generating: Self.self,
            options: GenerationOptions(sampling: .greedy)
        )
        return response.content
    }
    
    func nature(
        in session: LanguageModelSession
    ) async throws -> ElementDescriptor {
        let response = try await session.respond(
            to: """
            Give the nature of a concept between \(nature0) and \(nature1).
            """,
            generating: ElementDescriptor.self,
            options: GenerationOptions(sampling: .greedy)
            )
        return response.content
    }
    
    func descriptor(
        between concept0: String,
        and concept1: String,
        nature: ElementDescriptor,
        in session: LanguageModelSession
    ) async throws -> ElementDescriptor {
        let response = try await session.respond(
            to: """
            Imagine a \(nature.name) between \(concept0) and \(concept1).
            Give the description of this \(nature.name).
            """,
            generating: ElementDescriptor.self,
            options: GenerationOptions(sampling: .greedy)
            )
        return response.content
    }
}

extension LanguageModelSession {
    public func geometricInterpolation(
        between concept0: String,
        and concept1: String
    ) async throws -> ElementDescriptor {
        let continuum = try await ContinuumDescriptor.continuum(between: concept0, and: concept1, in: self)
        let nature = try await continuum.nature(in: self)
        let descriptor = try await continuum.descriptor(between: concept0, and: concept1, nature: nature, in: self)
        return descriptor
    }
}

