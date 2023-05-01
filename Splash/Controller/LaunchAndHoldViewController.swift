//
//  LaunchAndHoldViewController.swift
//  Splash
//
//  Created by Akshay Somkuwar on 01/05/23.
//

import UIKit

extension UIWindow {
    static var key: UIWindow! {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

class LaunchAndHoldViewController: UIViewController {
    var timer: Timer?
    let delayTime: Double = 5
    var currentTime: Double = 0
    @IBOutlet weak var timerTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Timer of 5 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: true)
    }
    
    @objc func dismissSplashController() {
        if currentTime < delayTime {
            timerTextLabel.text = "You will be redirected to feeds screen in \(delayTime - currentTime)s"
            currentTime += 1
        } else if currentTime == delayTime {
            timer?.invalidate()
            let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
            let rootVC = mainVC.instantiateViewController(withIdentifier: "FeedViewController")
            UIWindow.key.rootViewController = rootVC
            UIWindow.key.makeKeyAndVisible()
        }
    }

}
