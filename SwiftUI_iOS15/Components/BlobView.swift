//
//  BlobView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 24.02.2024.
//

import SwiftUI

struct BlobView: View {
    @State var isAppear = false
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            
            let angle = Angle.degrees(now.remainder(dividingBy: 3) * 30)
            let x = cos(angle.radians)
            
            let angle2 = Angle.degrees(now.remainder(dividingBy: 6) * 5)
            let x2 = cos(angle2.radians)
            
            let angle3 = Angle.degrees(now.remainder(dividingBy: 1) * 20)
            let x3 = cos(angle3.radians)
            
            Canvas { context, size in
                context.fill(path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), x: x, x2: x2, x3: x3), with: .foreground)
            }
            .frame(width: 400, height: 414)
            .foregroundStyle(
                .linearGradient(
                    colors: [.pink, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .rotationEffect(.degrees(isAppear ? 360 : 0))
        }
        .onAppear {
            withAnimation(
                .linear(duration: 30)
                .repeatForever(autoreverses: false)
                .delay(1)
            ) {
                isAppear = true
            }
        }
    }
    
    func path(in rect: CGRect, x: Double, x2: Double, x3: Double) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(
            to: CGPoint(x: 0.9923*width, y: 0.42593*height)
        )
        path.addCurve(
            to: CGPoint(x: 0.6355*width*x2, y: height),
            control1: CGPoint(x: 0.92554*width*x3, y: 0.77749*height*x2),
            control2: CGPoint(x: 0.91864*width*x2, y: height*x3)
        )
        path.addCurve(
            to: CGPoint(x: 0.08995*width*x2, y: 0.60171*height),
            control1: CGPoint(x: 0.35237*width*x, y: height*x3),
            control2: CGPoint(x: 0.2695*width*x3, y: 0.77304*height)
        )
        path.addCurve(
            to: CGPoint(x: 0.34086*width, y: 0.06324*height*x),
            control1: CGPoint(x: -0.0896*width*x3, y: 0.43038*height*x3),
            control2: CGPoint(x: 0.00248*width*x3, y: 0.23012*height*x)
        )
        path.addCurve(
            to: CGPoint(x: 0.9923*width, y: 0.42593*height),
            control1: CGPoint(x: 0.67924*width*x3, y: -0.10364*height*x),
            control2: CGPoint(x: 1.05906*width*x3, y: 0.07436*height*x2)
        )
        path.closeSubpath()
        return path
    }
}

struct BlobView_Previews: PreviewProvider {
    static var previews: some View {
        BlobView()
    }
}
