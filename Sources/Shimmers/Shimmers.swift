import SwiftUI

public struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    let active: Bool
    
    let curve: ShimmerCurve
    let duration: Double
    let autoreverses: Bool
    let gradientMask: GradientMask
    
    public func body(content: Content) -> some View {
        content
            .modifier(AnimatedMask(phase: phase, active: active, gradientMask: gradientMask))
            .task(id: active, taskAction)
    }
    
    @MainActor @Sendable
    private func taskAction() async {
        let animation = active ? curve.animation(duration: duration).repeatForever(autoreverses: autoreverses) : curve.animation(duration: duration)
        let transaction = Transaction(animation: animation)
        
        withTransaction(transaction) {
            phase = active ? 0.8 : 0
        }
    }
}

/// An enumeration of supported Animation type
public enum ShimmerCurve {
    case linear
    case easeIn
    case easeOut
    case easeInOut
    
    func animation(duration: Double) -> Animation {
        switch self {
        case .linear:
            return .linear(duration: duration)
        case .easeIn:
            return .easeIn(duration: duration)
        case .easeOut:
            return .easeOut(duration: duration)
        case .easeInOut:
            return .easeInOut(duration: duration)
        }
    }
}

public extension View {
    /// Adds an animated shimmering effect to any view, typically to show that
    /// an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - curve: The animation type. Default: `.linear`
    ///   - duration: The duration of a shimmer cycle in seconds. Default: `1.5`.
    ///   - autoreverses: Whether to bounce (reverse) the animation back and forth. Defaults to `false`.
    ///   - gradientMask: The gradient mask configuration
    func shimmer(
        active: Bool = true,
        curve: ShimmerCurve = .linear,
        duration: Double = 1.5,
        autoreverses: Bool = false,
        gradientMask: GradientMask
    ) -> some View {
        modifier(ShimmerModifier(active: active, curve: curve, duration: duration, autoreverses: autoreverses, gradientMask: gradientMask))
    }
}
