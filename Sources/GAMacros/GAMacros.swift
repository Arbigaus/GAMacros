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
public macro stringify<T>(_ value: T) -> (T, String) =
    #externalMacro(module: "GAMacrosMacros", type: "StringifyMacro")

/// A macro that produces a sink to a Publisher variable
/// For example:
///     #sinkify($foo, in: &fubar) { bar in
///         self.baz(item)
///     }
///
/// produces a sink to `$foo`:
///     $foo
///         .sink { [weak self] bar in
///             guard let self = self else { return }
///             self.baz(item)
///         }
///         .store(in: fubar)
///
@freestanding(expression)
public macro sinkify<Upstream: Publisher>(
    _ publisher: Upstream,
    in cancellables: Set<AnyCancellable>,
    _ body: @escaping (Upstream.Output) -> Void
) -> Void = #externalMacro(
    module: "GAMacrosMacros",
    type: "SinkifyMacro"
)
