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

    @State private var currentImageIndex = 0
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                // TODO: make a nice transation between images
                WebImage(url: URL(string: nextRocketImageUrl))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .frame(maxWidth: .infinity, maxHeight: 300)
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: 70)
                    .opacity(0.25)
                    .blur(radius: 15)
                HStack {
                    Text(rocket.rocketName)
                        .font( .largeTitle)
                        .foregroundColor( .white)
                    Spacer()
                    }
                    .padding()
            }
            
            Text(rocket.rocketDescription)
                .lineLimit(nil)
                .padding()
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.startTimer()
        }
    }
    
    private var nextRocketImageUrl: String {
        return rocket.flickrImages[currentImageIndex]
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                        if self.currentImageIndex < self.rocket.flickrImages.count-1 {
                self.currentImageIndex += 1
            }
            else {
                self.currentImageIndex = 0
            }
        }
    }
}



struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {

        RocketDetailView(rocket: DataModel.mockRocket)
    }
}
