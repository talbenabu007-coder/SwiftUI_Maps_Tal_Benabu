//
//  Location.swift
//  Maps
//
//  Created by Tal Benabu on 03/10/2026.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
  //  let id = UUID().uuidString
    let name:String
    let cityName:String
    let coordinates:CLLocationCoordinate2D
    let description:String
    let imageNames:[String]
    let link:String
    
    var id:String {
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}


