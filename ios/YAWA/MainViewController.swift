//
//  MainViewController.swift
//  YAWA
//
//  Created by Fu Yuan on 16/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit
import React

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onReactYAWAClick(_ sender: UIButton) {
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")
        let mockData:NSDictionary = ["scores":
            [
                ["name":"Alex", "value":"42"],
                ["name":"Joel", "value":"10"]
            ]
        ]
        
//        let rootView = RCTRootView(
//            bundleURL: jsCodeLocation,
//            moduleName: "RNHighScores",
//            initialProperties: mockData as [NSObject : AnyObject],
//            launchOptions: nil
//        )
        
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "FlatListBasics",
            initialProperties: mockData as [NSObject : AnyObject],
            launchOptions: nil
        )
        
        let vc = UIViewController()
        vc.view = rootView
        self.present(vc, animated: true, completion: nil)
    }
    
}
