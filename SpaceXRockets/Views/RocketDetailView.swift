//
//  RocketDetailView.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RocketDetailView: View {

    var rocket: Rocket

    var body: some View {
        
        VStack {
            
            HeaderImage(imageUrls: self.rocket.flickrImages,
                        rocketName: self.rocket.rocketName)
            
            Text(rocket.rocketDescription)
                .lineLimit(nil)
                .padding()
            
            HStack(spacing: 40) {
                VStack(spacing: 20) {
                    DataBlock(header: "DIAMETER", value: rocket.diameterString)
                    DataBlock(header: "PROPELLANT CAPACITY", value: rocket.propellantCapacityString)
                }
                VStack(spacing: 20) {
                    DataBlock(header: "HEIGHT", value: rocket.heightString)
                    DataBlock(header: "MASS", value: rocket.weightString)
                }
            }
            .padding()
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct HeaderImage: View {
    
    var imageUrls: [String]
    var rocketName: String
    
    @State private var currentImageIndex = 0
        
    var body: some View {
        
        ZStack (alignment: .bottom) {
            GeometryReader { geometry in
                HStack (alignment:.top, spacing: 0) {
                    ForEach (self.rocketImageUrls, id: \.self) { imageUrl in
                        WebImage(url: URL(string:imageUrl))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .frame(minWidth: geometry.size.width)
                    }
                }
                .animation(.easeInOut(duration:1))
            }
            
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 70)
                .opacity(0.25)
                .blur(radius: 15)
            HStack {
                Text(self.rocketName)
                    .font( .largeTitle)
                    .foregroundColor( .white)
                Spacer()
                }
                .padding()
        }
        .onAppear {
            self.startTimer()
        }
    }
    
    private var rocketImageUrls: [String] {
        let previous = imageUrls[currentImageIndex == 0 ? imageUrls.count-1 : currentImageIndex-1]
        let current = imageUrls[currentImageIndex]
        let next = imageUrls[currentImageIndex == imageUrls.count-1 ? 0 : currentImageIndex+1]
        return [previous, current, next]
    }
    
    private var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            
            if self.currentImageIndex < self.imageUrls.count-1 {
                self.currentImageIndex += 1
            }
            else {
                self.currentImageIndex = 0
            }
        }
    }
}


struct DataBlock: View {
    
    var header: String
    var value: String
    
    var body: some View {
        VStack {
            Text(header)
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
                .background(Color.secondary)
            Text(value)
                .font(.title)
        }
    }
}


struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {

        RocketDetailView(rocket: DataModel.mockRocket)
    }
}
