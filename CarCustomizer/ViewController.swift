//
//  ViewController.swift
//  CarCustomizer
//
//  Created by Anish Kochhar on 12/01/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CarStatistics: UILabel!
    
    let car  = Car(make: "Tesla", model: "Model X", topSpeed: 190, acceleration: 5.3, handling: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CarStatistics.text = car.displayStats()
    }
    


}

