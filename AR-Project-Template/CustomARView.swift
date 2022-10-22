//
//  CustomARView.swift
//  AR-Project-Template
//
//  Created by Zaid Neurothrone on 2022-10-22.
//

import ARKit
import Combine
import FocusEntity
import RealityKit
import SwiftUI

final class CustomARView: ARView {
  private var cancellables: Set<AnyCancellable> = []
  private var focusEntity: FocusEntity?
  
  required init(frame frameRect: CGRect) {
    super.init(frame: frameRect)
  }
  
  dynamic required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init() {
    self.init(frame: UIScreen.main.bounds)
    
    let session = self.session
    let config = ARWorldTrackingConfiguration()
    config.planeDetection = [.horizontal]
    session.run(config)
//
    self.addCoachingOverlay()
    
    subscribeToActionStream()
    
    focusEntity = FocusEntity(on: self, style: .classic(color: .purple))
    
//    if let focusEntity {
//
//    }
  }
  
  func subscribeToActionStream() {
    ARManager.shared
      .actionStream
      .sink { [weak self] action in
        switch action {
        case .placeBlock(let color):
          self?.placeBlockWith(color: color)
        case .removeAllAnchors:
          self?.scene.anchors.removeAll()
        }
      }
      .store(in: &cancellables)
  }
  
  func configurationExamples() {
    // Tracks the device relative to it's environment
    let config = ARWorldTrackingConfiguration()
    session.run(config)
    // Not supported in all regions, tracks w.r.t. global coordinates
    let _ = ARGeoTrackingConfiguration()
    
    // Tracks faces in the scene
    let _ = ARFaceTrackingConfiguration()
    
    // Tracks bodies in the scene
    let _ = ARBodyTrackingConfiguration()
  }
  
  func anchorExamples() {
    // Attach anchors at specific coordinates in the iPhone-centered coordinate system
    let coordinateAnchor = AnchorEntity(world: .zero)
    
    // Attach anchors to detect planes (this works best on devices with a LIDAR sensor)
    let _ = AnchorEntity(plane: .horizontal)
    let _ = AnchorEntity(plane: .vertical)
    
    // Attach anchors to tracked body parts, such as the face
    let _ = AnchorEntity(.face)
    
    // Attach anchors to tracked images, such as markers or visual codes
    let _ = AnchorEntity(.image(group: "group", name: "name"))
    
    // Add an anchor to the scene
    scene.addAnchor(coordinateAnchor)
  }
  
  func entityExamples() {
    // Load an entity from a usdz file
    let _ = try? Entity.load(named: "usdzFileName")
    
    // Load an entity from a reality file
    let _ = try? Entity.load(named: "realityFileName")
    
    // Generate an entity with code
    let box = MeshResource.generateBox(size: 1)
    let entity = ModelEntity(mesh: box)
    
    // Add entity to an anchor, so it's placed in the scene
    let anchor = AnchorEntity()
    anchor.addChild(entity)
  }
  
  func placeBlockWith(color: Color) {
    let boxMesh = MeshResource.generateBox(size: 0.05, cornerRadius: 0.02)
    let material = SimpleMaterial(color: UIColor(color), isMetallic: true)
    let entity = ModelEntity(mesh: boxMesh, materials: [material])
    
    let anchor = AnchorEntity(plane: .horizontal)
    anchor.addChild(entity)
    
    scene.addAnchor(anchor)
  }
}
