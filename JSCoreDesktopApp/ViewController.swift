//
//  ViewController.swift
//  JSCoreDesktopApp
//
//  Created by Aleksei Ustinov on 31.10.2021.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewDidDisappear() {
        NSApplication.shared.terminate(self)
    }


}

