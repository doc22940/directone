//
//  PlaceSearch.swift
//  DirectOne
//
//  Created by Robert on 16.02.19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation
import MapKit
import DropDown

protocol PlaceSearchDelegate {
    var placeSearchResult : [MKLocalSearchCompletion] {get set}
}

class PlaceSearch : NSObject {
    private let searchCompleter = MKLocalSearchCompleter()
    private(set) var searchResults = [MKLocalSearchCompletion]()
    var delegate : PlaceSearchDelegate?
    
    func findPlace(_ term : String) {
        searchCompleter.queryFragment = term
    }
    func getCoordiantes(for place : String, completionHandler:@escaping (CLLocationCoordinate2D?, Error?)->()) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = place
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start {
            response, error in
            if error != nil {
                completionHandler(nil, error)
            } else {
                completionHandler(response?.mapItems.first?.placemark.coordinate, nil)
            }
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
    }
}

extension PlaceSearch : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        delegate?.placeSearchResult = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
