//
//  ContentView.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
     @ObservedObject var model = DataModel()
    
    var body: some View {
        NavigationView {
            List(model.rockets.sorted{ $0.firstFlight > $1.firstFlight } ) { rocket in
                RocketView(rocket: rocket)
            }
            .onAppear {
                self.model.loadData()
            }
            .navigationBarTitle("Rockets")
            .navigationBarItems(leading:
                    Image("spacex_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100)
            )
        }.accentColor(.white)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        RocketView(rocket: DataModel.mockRocket)
    }
}


