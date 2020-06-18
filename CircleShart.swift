//
//  CircleShart.swift
//  Foodies
//
//  Created by App Designer2 on 13.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//

import SwiftUI

struct CircleShart: View {
    @State var startAngel = Angle()
    @State var circle = false
    @State var endAngle = Angle()
    @State var to : CGFloat = 100
    
    @ObservedObject var shart = Food()
    var body: some View {
        ZStack {
            if self.shart.rating == 0 {
                
            } else {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.gray.opacity(0.39),lineWidth: 10)
            .frame(width: 70, height: 70)
            
            withAnimation(.default) {
            Shart(startAngle: .degrees(0), circle: self.circle, endAngle: .degrees(Double(self.shart.rating)))
                .trim(from: 0, to: CGFloat(self.shart.rating))
            
            .stroke(Color.blue,style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 70, height: 70)
            .rotationEffect(Angle.init(degrees: -90))
            }
            
            VStack {
                if self.shart.rating == 0 {
                    
                } else {
                    Text("\(self.shart.prices!)%")
                .font(.headline)
                }
            }
           /* Circle()
                 
                .trim(from: CGFloat(self.shart.order) / 1, to: 1)
            .stroke(Color.red,lineWidth: 10)
            .frame(width: 100, height: 100)
            */
                .onAppear {
                    if self.shart.rating == 100 {
                        self.shart.rating = 0
                    }
                }
            }
        }
    }
}

struct CircleShart_Previews: PreviewProvider {
    static var previews: some View {
        CircleShart()
    }
}

struct Shart : Shape {
            var startAngle : Angle
            var circle : Bool
            var endAngle : Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: circle)
        
        
        return path
    }
    
    
}
