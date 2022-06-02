/// A Nimble matcher that succeeds when the actual value is the same instance
/// as the expected instance.
public func beIdenticalTo(_ expected: AnyObject?) -> Predicate<AnyObject> {
    return Predicate.define { actualExpression in
        let actual = try actualExpression.evaluate()

        let bool = actual === expected && actual !== nil
        return PredicateResult(
            bool: bool,
            message: .expectedCustomValueTo(
                "be identical to \(identityAsString(expected))",
                actual: "\(identityAsString(actual))"
            )
        )
    }
}

public extension Expectation where T == AnyObject {
    static func === (lhs: Expectation, rhs: AnyObject?) {
        lhs.to(beIdenticalTo(rhs))
    }

    static func !== (lhs: Expectation, rhs: AnyObject?) {
        lhs.toNot(beIdenticalTo(rhs))
    }
}

/// A Nimble matcher that succeeds when the actual value is the same instance
/// as the expected instance.
///
/// Alias for "beIdenticalTo".
public func be(_ expected: AnyObject?) -> Predicate<AnyObject> {
    return beIdenticalTo(expected)
}

#if canImport(Darwin)
    import class Foundation.NSObject

    public extension NMBPredicate {
        @objc class func beIdenticalToMatcher(_ expected: NSObject?) -> NMBPredicate {
            return NMBPredicate { actualExpression in
                let aExpr = actualExpression.cast { $0 as AnyObject? }
                return try beIdenticalTo(expected).satisfies(aExpr).toObjectiveC()
            }
        }
    }
#endif
