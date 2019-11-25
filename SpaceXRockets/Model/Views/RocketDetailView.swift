//
//  RocketDetailView.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import SwiftUI

struct RocketDetailView: View {
    
    var rocket: Rocket
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {

        RocketDetailView(rocket: DataModel.mockRocket)
    }
}
