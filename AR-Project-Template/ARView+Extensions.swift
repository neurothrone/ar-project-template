//
//  ARView+Extensions.swift
//  AR-Project-Template
//
//  Created by Zaid Neurothrone on 2022-10-22.
//

import ARKit
import RealityKit

extension ARView {
  func addCoachingOverlay() {
    let overlay = ARCoachingOverlayView()
    overlay.goal = .horizontalPlane
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.session = self.session
    
    self.addSubview(overlay)
  }
}
