//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Neo Nguyen on 5/11/18.
//  Copyright © 2018 Neo. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet internal weak var sceneView : ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBox()
        self.addTapGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.sceneView.session.pause()
    }
    
    func addBox(x: Float = 0, y: Float = 0, z: Float = -2)  {
        let box = SCNBox.init(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode.init()
        boxNode.geometry = box
        boxNode.position = SCNVector3.init(x, y, z)
        
        self.sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    func addTapGestureToSceneView()  {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        self.sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTap(withGestureRecognizer recognizer : UIGestureRecognizer)  {
        let tapLocation = recognizer.location(in: self.sceneView)
        let hitTestResults = self.sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            let hitTestResultsWithFeaturePoints = self.sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first{
                let translator = hitTestResultWithFeaturePoints.worldTransform.translation
                self.addBox(x: translator.x, y: translator.y, z: translator.z)
            }
            return
            
        }
        node.removeFromParentNode()
    }
}
