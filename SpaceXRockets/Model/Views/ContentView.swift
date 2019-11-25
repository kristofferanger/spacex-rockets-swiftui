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
            List(model.rockets) { rocket in
                RocketView(rocket: rocket)
            }
            .onAppear(perform: {
                self.model.loadData()
            })
            .navigationBarTitle("Rockets")
            .navigationBarItems(leading:
                    Image("spacex_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100)
            )
        }
    }
}
