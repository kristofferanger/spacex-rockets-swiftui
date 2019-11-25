//
//  DataModel.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import Foundation
import Combine

// MARK: - DataModel

class DataModel: ObservableObject, Identifiable {
    
    @Published var rockets = Rockets()
    
    private var cancellable: AnyCancellable?
    private var decoder : JSONDecoder {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.spacexdata.com/v3/rockets") else {
            fatalError("URL could not be created")
        }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: Rockets.self, decoder: decoder)
        .replaceError(with:[])
        .eraseToAnyPublisher()
        .receive(on: RunLoop.main)
        .assign(to: \.rockets, on: self)
    }
}

