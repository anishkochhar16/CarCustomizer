//
//  ViewController.swift
//  CarCustomizer
//
//  Created by Anish Kochhar on 12/01/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentPositions = 0
    var remainingFunds = 0 {
        didSet {
            RemainingFunds.text = "Remaining Funds: \(remainingFunds)"

        }
    }
    
    @IBOutlet weak var ECUPackage: UISwitch!
    @IBOutlet weak var NitroPackage: UISwitch!
    @IBOutlet weak var EngineExhaustPackage: UISwitch!
    @IBOutlet weak var TiresPackage: UISwitch!
    @IBOutlet weak var CarStatistics: UILabel!
    @IBOutlet weak var RemainingFunds: UILabel!
    
    var starterCars = StarterCars()
    
    var car: Car? {
        didSet {
            CarStatistics.text = car?.displayStats()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        car = starterCars.cars[currentPositions]
        remainingFunds = 1000

    }
    
    
    @IBAction func NextCar(_ sender: Any) {
        
        EngineExhaustPackage.isOn = false
        TiresPackage.isOn = false
        ECUPackage.isOn = false
        NitroPackage.isOn = false
        remainingFunds = 1000
        
        currentPositions += 1
        if currentPositions >= (starterCars.cars.count) {
            currentPositions = 0
        }
        
        car = starterCars.cars[currentPositions]
        
    }
    @IBAction func EngineExhaustPackageToggle(_ sender: Any) {
        if EngineExhaustPackage.isOn {
            car?.topSpeed += 5
            remainingFunds -= 250
        } else {
            car?.topSpeed -= 5
            remainingFunds += 250
        }
        validFunds()
    }
    

    @IBAction func TiresPackageToggle(_ sender: Any) {
        if TiresPackage.isOn {
            car?.handling += 1
            remainingFunds -= 250
        } else {
            car?.handling -= 1
            remainingFunds += 250
        }
        validFunds()
    }
    
    @IBAction func NitroPackageToggle(_ sender: Any) {
        if NitroPackage.isOn {
            car?.acceleration -= 0.5
            remainingFunds -= 500
        } else {
            car?.acceleration += 0.5
            remainingFunds += 500
        }
        validFunds()
    }
  
    @IBAction func ECUPackageToggle(_ sender: Any) {
        if ECUPackage.isOn {
            car?.topSpeed += 10
            remainingFunds -= 500
        } else {
            car?.topSpeed -= 10
            remainingFunds += 500
        }
        validFunds()
    }
    
    func validFunds ()  {
        if remainingFunds < 250 {    // i.e. none are buyable
            if ECUPackage.isOn == false {
                ECUPackage.isEnabled = false
            }
            if EngineExhaustPackage.isOn == false {
                EngineExhaustPackage.isEnabled = false
            }
            if TiresPackage.isOn == false {
                TiresPackage.isEnabled = false
            }
            if NitroPackage.isOn == false {
                NitroPackage.isEnabled = false
            }
        } else if remainingFunds < 500 {    // only engine package and tires package are buyable
            if NitroPackage.isOn == false {
                NitroPackage.isEnabled = false
            }
            if ECUPackage.isOn == false {
                ECUPackage.isEnabled = false
            }
        } else {
            NitroPackage.isEnabled = true
            EngineExhaustPackage.isEnabled = true
            ECUPackage.isEnabled = true
            TiresPackage.isEnabled = true
        }
    }
    

}

