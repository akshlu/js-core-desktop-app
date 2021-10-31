//
//  ViewController.swift
//  JSCoreDesktopApp
//
//  Created by Aleksei Ustinov on 31.10.2021.
//

import Cocoa
import JavaScriptCore

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let context = JSContext() else {
            fatalError("Can't create JSContext")
        }

        let consoleLog: @convention(block) (String) -> Void = { message in
            print("JS Log: " + message)
        }

        context.setObject(consoleLog, forKeyedSubscript: "log" as NSString)


        context.exceptionHandler = { context, exception in
            print("JS Error: " + exception!.toString())
        }


        guard let url = Bundle.main.url(forResource: "main", withExtension: "js") else {
            fatalError("Missing main.js")
        }
        
        do {
            context.evaluateScript(try String(contentsOf: url), withSourceURL: url)

            let main = context.objectForKeyedSubscript("main")
            if (main != nil) {
                let result: Dictionary<String, Any> = main?.call(withArguments: []).toDictionary() as! Dictionary<String, Any>
                self.drawUI(dict: result, parentView: self.view)

            }
        } catch {
            
        }
        
        // Do any additional setup after loading the view.
//        let button = NSButton(title: "Press me", target: nil, action: nil)
//        self.view.addSubview(button)
    }
    
    func drawUI(dict: Dictionary<String, Any>, parentView: NSView) {
        print("type", dict["type"]!)
        
        var component: NSView
        
        switch dict["type"] as! String {
        case "View":
            component = NSView(frame: parentView.frame)
        case "Button":
            component = NSButton(title: dict["title"] as! String, target: nil, action: nil)
        default:
            component = NSView()
        }
        
        parentView.addSubview(component)
        
        if let children = dict["children"] as? NSMutableArray {
            children.forEach { item in
                drawUI(dict: item as! Dictionary<String, Any>, parentView: component)
            }
        }
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
