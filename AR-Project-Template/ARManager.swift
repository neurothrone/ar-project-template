//
//  ARManager.swift
//  AR-Project-Template
//
//  Created by Zaid Neurothrone on 2022-10-22.
//

import Combine

final class ARManager {
  static let shared: ARManager = .init()
  private init() {}
  
  var actionStream = PassthroughSubject<ARAction, Never>()
}
