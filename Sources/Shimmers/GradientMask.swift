import SwiftUI

/// An animatable modifier to interpolate between `phase` values.
struct AnimatedMask: Animatable, ViewModifier {
    var phase: CGFloat
    let active: Bool
    let gradientMask: GradientMask
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func body(content: Content) -> some View {
        content
            .mask(mask)
    }

    private var mask: some View {
        gradientMask
            .gradient(phase: phase)
            .scaleEffect(3)
            .overlay(Rectangle().opacity(active ? 0 : 1))
    }
}

/// A slanted, animatable gradient between transparent and opaque to use as mask.
public struct GradientMask {
    public init(edgeOpacity: Double = 0.3,
                centerOpacity: Double = 1,
                startPoint: UnitPoint = .topLeading,
                endPoint: UnitPoint = .bottomTrailing) {
        self.edgeOpacity = edgeOpacity
        self.centerOpacity = centerOpacity
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    let edgeOpacity: Double
    let centerOpacity: Double
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    func gradient(phase: Double) -> some View {
        LinearGradient(gradient:
            Gradient(stops: [
                .init(color: .black.opacity(edgeOpacity), location: phase),
                .init(color: .black.opacity(centerOpacity), location: phase + 0.1),
                .init(color: .black.opacity(edgeOpacity), location: phase + 0.2)
            ]),
            startPoint: startPoint,
            endPoint: endPoint)
    }
}
