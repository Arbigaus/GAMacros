//
//  SinkifyMacroTest.swift
//  GAMacros
//
//  Created by Gerson Arbigaus on 24/04/25.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import GAMacrosMacros

let testSinkifyMacros: [String: Macro.Type] = [
    "sinkify": SinkifyMacro.self,
]

final class SinkifyMacroTest: XCTestCase {

    func testMacro() throws {
        let inputSource = """
            #sinkify(self.$banana, in: trash) { banana in
                print(banana)
            }
            """

        let expected = """
            self.$banana
                .sink { [weak self] banana in
                    guard let self = self else {
                        return
                    }
            
                print(banana)
                }
                .store(in: &trash)
            """
        assertMacroExpansion(
            inputSource,
            expandedSource: expected,
            macros: testSinkifyMacros
        )
    }
}
