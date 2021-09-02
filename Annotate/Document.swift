//
//  Document.swift
//  Annotate
//
//  Created by Quaternion Works on 2021-08-27.
//

import Cocoa

class Document: NSDocument {
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        // Sets the view controller's represented object as content
        if let contentVC = windowController.contentViewController as? ViewController {
            // contentVC.representedObject = base
            contentVC.representedObject = platform
        }
        Swift.print("(1.3) made window controllers (Document)")
        let currentUrL: String = self.presentedItemURL?.absoluteString ?? ("not accessible")
        Swift.print("(1.4) current document url is " + currentUrL + " (Document)")
    }
    
    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        // throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        Swift.print("(2.1) save is called (Document)")
        let currentUrL: String = self.presentedItemURL?.absoluteString ?? ("not accessible")
        Swift.print("(2.2) current document url is " + currentUrL + " (Document)")
        // return saveJSON()
        return savePlatform()
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override read(from:ofType:) instead.
        // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
        // throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        // loadJSON(data)
        loadPlatform(data)
        Swift.print("(3.07) read is called (Document)")
        let currentUrL: String = self.presentedItemURL?.absoluteString ?? ("not accessible")
        manager.currentURL = currentUrL
        Swift.print("(3.08) current document url is " + currentUrL + " (Document)")
        Swift.print("(3.09) current base.directoryPath is " + platform.directoryPath + " (Document)")
        Swift.print("(3.10) current manager.directoryPath is " + manager.directoryPath + " (Document)")
    }
}
