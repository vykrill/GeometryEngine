// common.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 5th, 2020
//
// contains global variables commonly used in the Geometry Engine

import Foundation

/// The constant pi, in a shorter form.
let π = Double.pi

func areApproximatelyEquals(_ n1: Double, and n2: Double, precision: Int = 5) -> Bool {
    n1.rounded(toPlace: precision, rule: .towardZero) == n2.rounded(toPlace: precision, rule: .towardZero)
}
