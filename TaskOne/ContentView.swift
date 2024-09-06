//
//  ContentView.swift
//  TaskOne
//
//  Created by Fahimah on 9/1/24.
//

import SwiftUI

struct ContentView: View {

    @State private var sunset: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            let sunrise = "8:10"
            let sunset = "18:02"
            let sunsetDate = getDate(dateString: sunset)
            VStack {
                SunsetView(sunsetDate: sunsetDate).frame(height: 100)
                HStack {
                    TimeView(symbol: "sunrise", text: "Sunrise", time: sunrise)
                    Spacer()
                    TimeView(symbol: "sunset", text: "Sunset", time: sunset)
                    
                }
                
            }
            .padding()
        }
    }
}

func getDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.date(from: dateString) ?? Date.now
}


struct SunsetView: View {
    @State var percent: CGFloat = 0.0
    var sunsetDate: Date
    var body: some View {
        VStack {
            
            ZStack {
                DottedShape().stroke(.gray, style: StrokeStyle(lineWidth: 3, dash: [4]))
                Partial(percent: percent)
                WeatherIcon(percent: percent, iconName: "sun.max.fill")
            }.onAppear {
                withAnimation(.linear(duration: 2)) {
                    let calendar = Calendar.current
                    let minutes = calendar.component(.minute, from: sunsetDate)
                    let hours = calendar.component(.hour, from: sunsetDate)
                    let passedMinutes = (hours * 60) + minutes
                    percent = CGFloat(passedMinutes) / (24 * 60)
                }
            }
            
        }
        
        
    }
    
}


struct DottedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let testPath = UIBezierPath()
        testPath.move(to: CGPoint(x: 0, y: rect.height))
        for x in stride(from: 0, to: rect.width, by: 2) {
            let angle = (x / rect.width) * 360
            let y = (rect.height / 2) * sin((-90 + angle) * (CGFloat.pi / 180))
            testPath.addLine(to: CGPoint(x: x, y: (rect.height / 2) - y))
        }
        let path = Path(testPath.cgPath)
        return path
    }
}

struct Partial: View, Animatable {
    var percent: CGFloat = 0.0
    var body: some View {
        Canvas { context, size in
            let percentPath = UIBezierPath()
            percentPath.move(to: CGPoint(x: 0, y: size.height))
            let percentWidth = size.width * (CGFloat(percent))
            for x in stride(from: 0, to: percentWidth, by: 2) { // [0, 2, 4, 6, 8, ... ,percentWidth]
                let angle = (x / size.width) * 360
                let y = (size.height / 2) * sin((-90 + angle) * (CGFloat.pi / 180)) // y = (nesfe height) + (nesfe height * sin(90 daraje shift yafte)
                percentPath.addLine(to: CGPoint(x: x, y: (size.height / 2) - y))
            }
            let finalPercentPth = Path(percentPath.cgPath)
            context.stroke(finalPercentPth, with: .color(.purple), style: StrokeStyle(lineWidth: 3))
        }
    }
    
    var animatableData: CGFloat {
            get {
                return percent
            }
            
            set {
                percent = newValue
            }
        }
}
struct PartialShape: Shape {
    var percent: CGFloat = 0.0
    func path(in rect: CGRect) -> Path {
        let percentPath = UIBezierPath()
        percentPath.move(to: CGPoint(x: 0, y: rect.height))
        let percentWidth = rect.width * (CGFloat(percent))
        for x in stride(from: 0, to: percentWidth, by: 2) {
            let angle = (x / rect.width) * 360
            let y = (rect.height / 2) * sin((-90 + angle) * (CGFloat.pi / 180))
            percentPath.addLine(to: CGPoint(x: x, y: (rect.height / 2) - y))
        }
        let finalPercentPth = Path(percentPath.cgPath)
        return finalPercentPth
    }
    
    var animatableData: CGFloat {
        get {
            return percent
        }
        
        set {
            percent = newValue
        }
    }
}

struct WeatherIcon: View, Animatable {
    var percent: CGFloat
    var iconName: String
    let imageWidth = 30
    let imageHeight = 30
    var body: some View {
        GeometryReader { proxy in
            let x: CGFloat = proxy.size.width * percent
            let angle: CGFloat =  360 * (x / proxy.size.width)
            let y = (proxy.size.height / 2) * sin((-90 + angle) * (CGFloat.pi / 180))
            Image(systemName: iconName).resizable().frame(width: CGFloat(imageWidth), height: CGFloat(imageHeight)).foregroundColor(.yellow).position(x: x , y: (proxy.size.height / 2) - y )
            
        }
    }
    
    var animatableData: CGFloat {
        get {
            return percent
        }
        
        set {
            percent = newValue
        }
    }
}
