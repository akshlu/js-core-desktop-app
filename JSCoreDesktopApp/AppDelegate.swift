import Cocoa
import JavaScriptCore
import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
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

            let factorial = context.objectForKeyedSubscript("factorial")
            if (factorial != nil) {
                let result = factorial?.call(withArguments: [6]).toString()
                let alert = NSAlert()
                alert.messageText = result!
                alert.alertStyle = NSAlert.Style.informational
                alert.addButton(withTitle: "OK")
                alert.runModal()

            }
        } catch {
            
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("exit")
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

