//
//  float4x4+Extension.swift
//  ARKitDemo
//
//  Created by Neo Nguyen on 5/11/18.
//  Copyright © 2018 Neo. All rights reserved.
//

import UIKit
import ARKit

extension float4x4{
    var translation : float3{
        let translation = self.columns.3
        return float3.init(translation.x, translation.y, translation.z)
    }
}
