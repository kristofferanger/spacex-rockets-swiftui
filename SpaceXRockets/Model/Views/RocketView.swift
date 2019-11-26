//
//  RocketView.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import SwiftUI
 import SDWebImageSwiftUI

struct RocketView: View {
    
    var rocket: Rocket
    
    var body: some View {
        
        NavigationLink(destination: RocketDetailView(rocket: rocket)) {
            HStack (alignment: .center) {
                WebImage(url: URL(string: rocket.flickrImages.first!))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(rocket.rocketName)
                            .font( .headline)
                        Text(rocket.firstLaunchString)
                            .font(.subheadline)
                            .foregroundColor( .secondary)
                    }
                    TechDataView(diameter: rocket.diameterString,
                                 height: rocket.heightString,
                                 weight: rocket.weightString)
                }
            }
            .padding([.top, .bottom], 4)
        }
    }
}

struct TechDataView: View {
    
    var diameter: String
    var height: String
    var weight: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                HStack {
                    Image(systemName: "arrow.left.and.right")
                    Text(self.diameter)
                }
                .frame(maxWidth: geometry.size.width/3, alignment: .leading)
                HStack {
                    Image(systemName: "arrow.up.and.down")
                    Text(self.height)
                }
                .frame(maxWidth: geometry.size.width/3, alignment: .leading)
                HStack {
                    Image(systemName: "arrow.down.to.line")
                    Text(self.weight)
                }
                .frame(maxWidth: geometry.size.width/3, alignment: .leading)
            }
        }
    }
}


struct RocketView_Previews: PreviewProvider {
    static var previews: some View {

        RocketView(rocket: DataModel.mockRocket)
    }
}
