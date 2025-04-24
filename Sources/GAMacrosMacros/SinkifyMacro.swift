//
//  SinkifyMacro.swift
//  GAMacros
//
//  Created by Gerson Arbigaus on 18/04/25.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct SinkifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> SwiftSyntax.ExprSyntax {
        guard node.arguments.count == 2,
              let publisher = node.arguments.first?.expression.description,
              let store = node.arguments.last?.expression.description else {
            fatalError("Expected the publisher and the store parameters")
        }

        guard let closure = node.trailingClosure?.statements.first?.item,
              let param = node.trailingClosure?.signature?.parameterClause?.description else {
            fatalError("Parameter clause expected")
        }

        let generated = """
            \(publisher)
                .sink { [weak self] \(param)in
                    guard let self = self else { return }
                    \(closure.description)
                }
                .store(in: &\(store))
            """

        return ExprSyntax(stringLiteral: generated)
    }
}
