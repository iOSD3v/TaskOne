//
//  TimeView.swift
//  TaskOne
//
//  Created by Fahimah on 9/1/24.
//

import SwiftUI

struct TimeView: View {
    
    var symbol: String = "sunrise"
    var text: String = "something"
    var time: String = "4:00"
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .foregroundColor(.purple)
            VStack {
                Text(text)
                    .foregroundColor(.gray)
                Text(time)
                    .foregroundColor(.white)
            }
        }
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView()
    }
}
