//
//  GAMacrosPlugin.swift
//  GAMacros
//
//  Created by Gerson Arbigaus on 24/04/25.
//

import SwiftCompilerPlugin

@main
struct GAMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        SinkifyMacro.self,
    ]
}
