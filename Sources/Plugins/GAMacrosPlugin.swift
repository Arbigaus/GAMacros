//
//  GAMacrosPlugin.swift
//  GAMacros
//
//  Created by Gerson Arbigaus on 24/04/25.
//

import SwiftCompilerPlugin

@main
public struct GAMacrosPlugin: CompilerPlugin {
    public let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        SinkifyMacro.self,
    ]
}
