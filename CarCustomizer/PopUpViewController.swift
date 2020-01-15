//
//  PopUpViewController.swift
//  CarCustomizer
//
//  Created by Anish Kochhar on 15/01/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var SummaryLabel: UILabel!
    var car: Car?
    var remainingFunds: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        SummaryLabel.text = (car?.summaryStats())! + "\n\nRemaining funds: \(remainingFunds)"
        
        showAnimate()
    }
    
    @IBAction func CloseWindow(_ sender: Any) {
//        self.view.removeFromSuperview()
        removeAnimate()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
            }
            
        })
    }
    
    

}
