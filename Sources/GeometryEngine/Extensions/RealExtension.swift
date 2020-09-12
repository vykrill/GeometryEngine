// RealExtension.swift
// Created by Jérémy Goyette
// For GeometryEngine
// September 9, 2020
//
// 

import Numerics
extension Real {
    func isWithin(_ tolerance: Self, of value: Self) -> Bool {
        let delta = self - value

        return abs(delta) <= tolerance
    }
}