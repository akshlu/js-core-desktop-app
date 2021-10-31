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
        let button = NSButton(title: "Press me", target: nil, action: nil)
        self.view.addSubview(button)
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

