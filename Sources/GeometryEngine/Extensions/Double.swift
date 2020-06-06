// Double.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 6th, 2020
//

import Foundation

extension Double {
    func rounded(toPlace place: Int) -> Double { 
        let factor = pow(10.0, Double(place))
        return (self * factor).rounded() / factor
    }
}