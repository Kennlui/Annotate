//
//  ViewController.swift
//  Annotate
//
//  Created by Quaternion Works on 2021-08-27.
//

import Cocoa

struct Manage {
    var buttonStatus: [String] = []
    var currentURL: String = "TBD"
    var directoryPath: String = ""
    var documentNumber: Int = 0
    var hide: Bool = true
    var imageInventory: [NSImage] = []
//    var imageList: [String] = []                // base data structure only
    var imageStrList: [String] = []
    var pageCount: Int = 1
    var textList: [String] = []
    var edit: Bool = false
}

var manager = Manage()

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        var str = "true"
        if (base.edit == false) {
            str = "false"
        }
        if (manager.edit == false) {
            initializeVC(imgP: previousPreview.image!, imgC: currentWell.image!, imgN: nextPreview.image!)
            print("(1.1 new) view did load; since manager edit is false, will initialize using initializeVC (VC)")
            print("(1.2 new) base.edit value  is " + str + " and manager.edit value is false (VC)")
            button00.title = manager.imageList[manager.pageCount]
            tabViewWelcomeLine.stringValue = manager.imageList[manager.pageCount]
        } else if (manager.edit == true) {
            print("(1.1 edit) view did load and manager edit is true (VC)")
            print("(1.2 edit) base.edit value  is " + str + " and manager.edit value is true (VC)")
            textDisplay.stringValue = manager.textList[manager.pageCount]
            nonTabViewDocumentWindow.string = manager.textList[manager.pageCount]
            tabViewWelcomeLine.stringValue = manager.textList[manager.pageCount]
            imageWindow.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
            previousPreview.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount - 1])!)
            currentWell.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
            nextPreview.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount + 1])!)
            button00.title = manager.imageList[manager.pageCount]
        }*/
        
        var str = "true"
        if (platform.edit == false) {
            str = "false"
        }
        if (manager.edit == false) {
            initializeVCFromPlatform(imgP: previousPreview.image!, imgC: currentWell.image!, imgN: nextPreview.image!)
            print("(1.1 new) view did load; since manager edit is false, will initialize using initializeVCFromPlatform (VC)")
            print("(1.2 new) platform.edit value  is " + str + " and manager.edit value is false (VC)")
        //    button00.title = manager.imageList[manager.pageCount]
        //    tabViewWelcomeLine.stringValue = manager.imageList[manager.pageCount]
            tabViewWelcomeLine.stringValue = "[ Enter text \n             click VIEW for detailed edits ]"
        } else if (manager.edit == true) {
            print("(1.1 edit) view did load and manager edit is true (VC)")
            print("(1.2 edit) platform.edit value  is " + str + " and manager.edit value is true (VC)")
            textDisplay.stringValue = manager.textList[manager.pageCount]
            nonTabViewDocumentWindow.string = manager.textList[manager.pageCount]
            tabViewWelcomeLine.stringValue = manager.textList[manager.pageCount]
            imageWindow.image = manager.imageInventory[manager.pageCount]
            previousPreview.image = manager.imageInventory[manager.pageCount - 1]
            currentWell.image = manager.imageInventory[manager.pageCount]
            nextPreview.image = manager.imageInventory[manager.pageCount + 1]
        }
        pageIndicator.stringValue = String(manager.pageCount)
    }

    // main display buttons
    
    @IBOutlet weak var button00: NSButton!
    @IBAction func button00(_ sender: Any) {
        manager.buttonStatus[0] = "A"
        let text = buttonClick(button00.title, button01.title, button02.title, button03.title, welcome: tabViewWelcomeLine.stringValue, window: nonTabViewDocumentWindow.string, bNum: 0)
        tabViewWelcomeLine.stringValue = text[0]
        nonTabViewDocumentWindow.string = text[1]
    }
    
    @IBOutlet weak var button01: NSButton!
    @IBAction func button01(_ sender: Any) {
        manager.buttonStatus[1] = "A"
        let text = buttonClick(button00.title, button01.title, button02.title, button03.title, welcome: tabViewWelcomeLine.stringValue, window: nonTabViewDocumentWindow.string, bNum: 1)
        tabViewWelcomeLine.stringValue = text[0]
        nonTabViewDocumentWindow.string = text[1]
    }
    
    @IBOutlet weak var button02: NSButton!
    @IBAction func button02(_ sender: Any) {
        manager.buttonStatus[2] = "A"
        let text = buttonClick(button00.title, button01.title, button02.title, button03.title, welcome: tabViewWelcomeLine.stringValue, window: nonTabViewDocumentWindow.string, bNum: 2)
        tabViewWelcomeLine.stringValue = text[0]
        nonTabViewDocumentWindow.string = text[1]
    }
    
    @IBOutlet weak var button03: NSButton!
    @IBAction func button03(_ sender: Any) {
        manager.buttonStatus[3] = "A"
        let text = buttonClick(button00.title, button01.title, button02.title, button03.title, welcome: tabViewWelcomeLine.stringValue, window: nonTabViewDocumentWindow.string, bNum: 3)
        tabViewWelcomeLine.stringValue = text[0]
        nonTabViewDocumentWindow.string = text[1]
    }
    
    // tab view welcome line
    
    @IBOutlet weak var tabViewWelcomeLine: NSTextField!
    @IBAction func tabViewWelcomeLine(_ sender: Any) {
        
        // update non tab view document window text
        
        if (textDisplay.stringValue == "") {
            nonTabViewDocumentWindow.string = tabViewWelcomeLine.stringValue
        } else {
            nonTabViewDocumentWindow.string = nonTabViewDocumentWindow.string + "\n\n" + tabViewWelcomeLine.stringValue
        }
        
        // update main display text
        
        if (textDisplay.stringValue == "") {
            textDisplay.stringValue = tabViewWelcomeLine.stringValue
        } else {
            textDisplay.stringValue = textDisplay.stringValue + "\n" + tabViewWelcomeLine.stringValue
        }
        
        // save
        
        savePage(nonTabViewDocumentWindow.string)
        
        // update main display buttons
        
        let b = [button00.title, button01.title, button02.title, button03.title]
        let a = updateActiveButton(b[0], b[1], b[2], b[3], welcome: tabViewWelcomeLine.stringValue)
        button00.title = a[0]
        button01.title = a[1]
        button02.title = a[2]
        button03.title = a[3]
    }
    
    // main display image window
    
    @IBOutlet weak var imageWindow: NSImageView!
    
    // main display text
    
    @IBOutlet weak var textDisplay: NSTextField!
    
    // page indicator
    
    @IBOutlet weak var pageIndicator: NSTextField!
    
    // non tab view document window
    
    @IBOutlet var nonTabViewDocumentWindow: NSTextView!
    
    // non tab view buttons
    
    @IBAction func nonTabViewForward(_ sender: Any) {
        nextPreview((Any).self)
    }
    
    @IBAction func nonTabViewBackward(_ sender: Any) {
        previousPreview((Any).self)
    }
    
    @IBAction func refresh(_ sender: Any) {
        textDisplay.stringValue = nonTabViewDocumentWindow.string
        if (manager.hide == true) {
            hideShow((Any).self)
        }
        savePage(nonTabViewDocumentWindow.string)
    }
    
    // hide/show button
    
    @IBAction func hideShow(_ sender: Any) {
        
        if (manager.hide == true) {
            manager.hide = false
        } else {
            manager.hide = true
        }
        
        if (manager.hide == true) {
            button00.isHidden = true
            button01.isHidden = true
            button02.isHidden = true
            button03.isHidden = true
            textDisplay.isHidden = true
        } else {
            button00.isHidden = false
            button01.isHidden = false
            button02.isHidden = false
            button03.isHidden = false
            textDisplay.isHidden = false
        }
    }
    
    // main make html
    
    @IBAction func htmlButton(_ sender: Any) {
        let img = previousPreview.alternateImage
        let url = makeHTML(img!)
        NSWorkspace.shared.open(url)
    }
    
    // tab view previews
    
    @IBOutlet weak var previousPreview: NSButton!
    @IBAction func previousPreview(_ sender: Any) {
        
        // save text
        
        savePage(nonTabViewDocumentWindow.string)
        
        // load text (note that goBack() decrements the page number and preps images)
        
        textDisplay.stringValue = goBack(textDisplay.stringValue)
        nonTabViewDocumentWindow.string = textDisplay.stringValue
        
        // load image
        
        // imageWindow.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
        imageWindow.image = manager.imageInventory[manager.pageCount]
        if (manager.pageCount == 0) {
            previousPreview.image = NSImage()
        } else {
        //  previousPreview.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount - 1])!)
            previousPreview.image = manager.imageInventory[manager.pageCount - 1]
        }
        // currentWell.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
        // nextPreview.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount + 1])!)
        currentWell.image = manager.imageInventory[manager.pageCount]
        nextPreview.image = manager.imageInventory[manager.pageCount + 1]
        
        // load page number
        
        pageIndicator.stringValue = String(manager.pageCount)
        
        // update welcome line
        
        tabViewWelcomeLine.stringValue = manager.textList[manager.pageCount]
        
        // refresh
        
        //refreshBase()
        refreshPlatform()
        
        // image URL to button
        
        // button00.title = manager.imageList[manager.pageCount]
    }
    
    
    @IBOutlet weak var currentWell: NSImageView!
    @IBAction func currentWell(_ sender: Any) {
        //let old = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
        let old = manager.imageInventory[manager.pageCount]
        if (currentWell.image != old) {
            do {
                try changeImage((currentWell.image ?? old)!, page: manager.pageCount)
            }
            catch {
                print(error.localizedDescription)
            }
            imageWindow.image = currentWell.image
        } else {
            nextPreview((Any).self)
        }
    }
    
    @IBOutlet weak var nextPreview: NSButton!
    @IBAction func nextPreview(_ sender: Any) {
        
        // load text (note that goForward() advances the page number and saves)
        
        textDisplay.stringValue = goForward(textDisplay.stringValue, nextPreview.alternateImage!)
        nonTabViewDocumentWindow.string = textDisplay.stringValue
        
        // load image
        
        // imageWindow.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
        // previousPreview.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount - 1])!)
        // currentWell.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount])!)
        // nextPreview.image = NSImage(contentsOf: URL(string: manager.imageList[manager.pageCount + 1])!)
        imageWindow.image = manager.imageInventory[manager.pageCount]
        previousPreview.image = manager.imageInventory[manager.pageCount - 1]
        currentWell.image = manager.imageInventory[manager.pageCount]
        nextPreview.image = manager.imageInventory[manager.pageCount + 1]
        
        // load page number
        
        pageIndicator.stringValue = String(manager.pageCount)
        
        // update welcome line
        
        tabViewWelcomeLine.stringValue = manager.textList[manager.pageCount]
        
        // refresh
        
        //refreshBase()
        refreshPlatform()
        
        // image URL to button
        
        // button00.title = manager.imageList[manager.pageCount]
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
