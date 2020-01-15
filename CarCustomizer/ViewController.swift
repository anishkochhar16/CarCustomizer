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
    var timeRemaining = 30
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
    @IBOutlet weak var RemaingTimeDisplay: UILabel!
    
    var starterCars = StarterCars()
    
    var car: Car? {
        didSet {
            CarStatistics.text = car?.displayStats()
        }
    }
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        car = starterCars.cars[currentPositions]
        remainingFunds = 1000
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        RemaingTimeDisplay.text = "30"
    }
    
    
    @IBAction func NextCar(_ sender: Any) {
        
        resetAllButtons()
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
        if remainingFunds == 250 {
            TiresPackage.isEnabled = true
            EngineExhaustPackage.isEnabled = true
        }
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
        }  else if remainingFunds < 500 {    // only engine package and tires package are buyable
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
    
    @objc func countdown() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            RemaingTimeDisplay.text = "\(timeRemaining)"
        } else {
            timer?.invalidate()
            NitroPackage.isEnabled = false
            EngineExhaustPackage.isEnabled = false
            ECUPackage.isEnabled = false
            TiresPackage.isEnabled = false
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpView") as! PopUpViewController
            popOverVC.car = car
            popOverVC.remainingFunds = remainingFunds
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
            
        }
    }
    @IBAction func Reset(_ sender: Any) {
        car = starterCars.cars[currentPositions]
        timeRemaining = 30
        resetAllButtons()
        remainingFunds = 1000
        self.view.setNeedsDisplay()
    }
    
    func resetAllButtons() {
        EngineExhaustPackage.isOn = false
        TiresPackage.isOn = false
        ECUPackage.isOn = false
        NitroPackage.isOn = false
        NitroPackage.isEnabled = true
        EngineExhaustPackage.isEnabled = true
        ECUPackage.isEnabled = true
        TiresPackage.isEnabled = true
    }
    

}

