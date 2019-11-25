//
//  RocketView.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import SwiftUI

struct RocketView: View {
    
    var rocket: Rocket
    
    var body: some View {
        Text(rocket.rocketName)
    }
}

struct RocketView_Previews: PreviewProvider {
    static var previews: some View {

        RocketView(rocket: DataModel.exampleRocket)
    }
}
