// The Swift Programming Language
// https://docs.swift.org/swift-book

import Combine

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "GAMacrosMacros", type: "StringifyMacro")

@freestanding(expression)
public macro sinkify<Upstream: Publisher>(
    _ publisher: Upstream,
    in cancellables: Set<AnyCancellable>,
    _ body: @escaping (Upstream.Output) -> Void
) -> Void = #externalMacro(
    module: "GAMacrosMacros",
    type: "SinkifyMacro"
)
