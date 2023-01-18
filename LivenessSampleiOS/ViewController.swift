//
//  ViewController.swift
//  LivenessSampleiOS
//
//  Created by lucas.carvalho on 18/01/23.
//

import UIKit
import CSLivenessSDK

class ViewController: UIViewController {

    @IBOutlet weak var btnCallSDK: UIButton!
    private var livenessSdk: CSLiveness?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTapButton(_ sender: Any) {
        force(portrait: true)
        DispatchQueue.main.async {
            self.livenessSdk = CSLiveness(
                configurations: CSLivenessConfigurations(
                    clientId: "SEU CLIENT ID AQUI",
                    clientSecret: "SEU SECRET ID AQUI"
                )
            )
            
            self.livenessSdk?.delegate = self
            self.livenessSdk?.start(viewController: self, animated: true)
        }
    }
}


// MARK: - Clearsale liveness Delegate

extension ViewController: CSLivenessDelegate {
    func liveness(didOpen: Bool) {
        print(didOpen)
    }
    
    func liveness(error: CSLivenessError) {
        print(error)
        print("*********** \(error.rawValue) ***********")
        force(portrait: false)
    }
    
    func liveness(success: CSLivenessResult) {
        print(success)
        print("*********** \(success) ***********")
        force(portrait: false)
    }

    func force(portrait: Bool)  {
        DispatchQueue.main.async {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,forKey: "orientation")
        }
    }
}

