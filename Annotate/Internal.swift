//
//  Internal.swift
//  Annotate
//
//  Created by Quaternion Works on 2021-08-27.
//

import Foundation
import Cocoa

// tracker array

struct TrackerArray: Codable {
    var t: [String] = []
}

var track = TrackerArray()

// internal administrative functions (in alphabetical order)

func acceptImage(_ img: NSImage, page: Int) throws {
    /*
    // construct a name for the image (for base data structure)
    
    var name = "NSImage"
    
    if (manager.documentNumber < 10) {
        name = fill00(manager.documentNumber) + name
    } else if (manager.documentNumber < 100) {
        name = fill0(manager.documentNumber) + name
    } else {
        name = String(manager.documentNumber) + name
    }
    
    if (page < 10) {
        name = name + fill00(page)
    } else if (page < 100) {
        name = name + fill0(page)
    } else {
        name = name + String(page)
    }
    
    // save the image to the URL (for base data structure)
    
    var destination = URL(string: manager.directoryPath)?.appendingPathComponent("internals", isDirectory: true)
    destination!.appendPathComponent(name)
    try img.tiffRepresentation?.write(to: destination!)
    
    // update image list (for base data structure)
    
    manager.imageList.append(destination!.absoluteString)
    */
    // update the image inventory (for platform data structure)
    
    if (page == manager.imageInventory.count) {
        manager.imageInventory.append(img)
    } else {
        print("The image inventory count in manager is " + String(manager.imageInventory.count) + " but acceptImage() was given page parameter value of " + String(page))
    }
}

func changeImage(_ img: NSImage, page: Int) throws {
    /*
    // construct a name for the image (for base data structure)
    
    var name = "NSImage"
    
    if (manager.documentNumber < 10) {
        name = fill00(manager.documentNumber) + name
    } else if (manager.documentNumber < 100) {
        name = fill0(manager.documentNumber) + name
    } else {
        name = String(manager.documentNumber) + name
    }
    
    if (page < 10) {
        name = name + fill00(page)
    } else if (page < 100) {
        name = name + fill0(manager.documentNumber)
    } else {
        name = name + String(page)
    }
    
    // save the image to the URL (for base data structure)
    
    var destination = URL(string: manager.directoryPath)?.appendingPathComponent("internals", isDirectory: true)
    destination!.appendPathComponent(name)
    try img.tiffRepresentation?.write(to: destination!)
    
    // update image list (for base data structure
    
    manager.imageList[page] = destination!.absoluteString
    */
    // update the image inventory (for platform data structure)
    
    if (manager.imageInventory.count > page) {
        manager.imageInventory[page] = img
    } else {
        print("The image inventory count in manager is " + String(manager.imageInventory.count) + " but changeImage() was given page parameter value of " + String(page))
    }
}

func fill00(_ num: Int) -> String {
    let output = "00" + String(num)
    return output
}

func fill0(_ num: Int) -> String {
    let output = "0" + String(num)
    return output
}

func goForward(_ text: String, _ img: NSImage) -> String {
    savePage(text)
    
    manager.pageCount += 1
    // let output = loadForward()
    let output = loadForwardPlatform(img)
    return output
}

func goBack(_ text: String) -> String {
    savePage(text)
    
    if (manager.pageCount > 1) {
        manager.pageCount -= 1
    }
    // let output = loadBack()
    let output = loadBackPlatform()
    return output
}

func getDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getDocNum() throws -> String {
    return String(manager.documentNumber)
}
/*
func initialize_000NSImage(_ img: NSImage) throws {                     // for base data structure
    
    // construct a name for the image
    
    var name = "NSImage000"
    if (Int(try getDocNum())! < 10) {
        name = fill00(Int(try getDocNum())!) + name
    } else if (Int(try getDocNum())! < 100) {
        name = fill0(Int(try getDocNum())!) + name
    } else {
        name = try getDocNum() + name
    }
    
    // save the image to the URL
    
    var destination = URL(string: manager.directoryPath)?.appendingPathComponent("internals", isDirectory: true)
    destination!.appendPathComponent(name)
    try img.tiffRepresentation?.write(to: destination!)
    print("(1.0 new) initialize_000NSImage() has run")
    
    // update image list
    
    manager.imageList.append(destination!.absoluteString)
}

func initializeVC(imgP: NSImage, imgC: NSImage, imgN: NSImage) {        // for base data structure
    
    // store the user's documents directory path to manager
    
    setDirectoryPath()
    
    // prep display buttons
    
    initializeButtonStatus()
    
    // set document number
    
    setDocNum()
    
    // save the first image to the internals subdirectory in the user's documents directory
    
    do {
        try initialize_000NSImage(imgP)
    }
    catch {
        print(error.localizedDescription)
    }
    
    // save the second and third images too
    
    do {
        try acceptImage(imgC, page: 1)
        try acceptImage(imgN, page: 2)
    }
    catch {
        print(error.localizedDescription)
    }
    
    // initialize the text list if necessary
    
    if (manager.textList.count < 3) {
        setTextList()
    }
    
    // load the saveable contents of the manager struct to a codable struct for JSON encoding later
    
    refreshBase()
}

func loadBack() -> String {
    var output = ""
    initializeButtonStatus()
    if (manager.textList[manager.pageCount] != output) {
        output = manager.textList[manager.pageCount]
    }
    return output
}

func loadForward() -> String {
    var output = ""
    initializeButtonStatus()
    let img = NSImage(contentsOf: URL(string: manager.imageList[0])!)!
    let target = manager.pageCount + 1
    if (target >= manager.imageList.count) {
        do {
            try acceptImage(img, page: target)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    if (target >= manager.textList.count) {
        manager.textList.append(output)
    }
    if (manager.textList[manager.pageCount] != output) {
        output = manager.textList[manager.pageCount]
    }
    return output
}

func refreshBase() {
    setSiblings()
    base.directoryPath = manager.directoryPath
    base.documentNumber = manager.documentNumber
    base.imageList = manager.imageList
    base.textList = manager.textList
    refreshSiblings()
}

func refreshSiblings() {
    siblingsFile.siblings = base.siblings
}
*/
func setDirectoryPath() {
    manager.directoryPath = String(getDirectory().absoluteString)
}

func savePage(_ text: String) {
    manager.textList[manager.pageCount] = text
    //refreshBase()
    refreshPlatform()
}

// set manager document number

func setDocNum() {
    
    setSiblings()
    manager.documentNumber = base.siblings.count
}

// update siblings in base and tracker

func setSiblings() {
    
    // initialize tracker
    /*
    track.t = [""]
    var destination = URL(string: manager.directoryPath)?.appendingPathComponent("internals", isDirectory: true)
    destination!.appendPathComponent("tracker")
    let data = try! JSONEncoder().encode(track)
    do {
        try data.write(to: destination!)
    }
    catch {
        print(error.localizedDescription)
    }*/
    
    // load tracker
    
    var destination = URL(string: manager.directoryPath)?.appendingPathComponent("internals", isDirectory: true)
    destination!.appendPathComponent("tracker")
    let decoder = JSONDecoder()
    if let data = try? decoder.decode(TrackerArray.self, from: Data(contentsOf: destination!)) {
        track.t = data.t
    }
    
    // check if current URL is already in tracker
    
    var sentry = false
    var output: [String] = []
    for item in track.t {
        if (item == manager.currentURL) {
            sentry = true
        }
    }
    
    // update siblings with current URL if appropriate
    
    if sentry == true {
        output = track.t
    } else {
        track.t.append(manager.currentURL)
        output = track.t
    }
    
    base.siblings = output
    
    // update tracker
    
    let data = try! JSONEncoder().encode(track)
    do {
        try data.write(to: destination!)
    }
    catch {
        print(error.localizedDescription)
    }
}

func setTextList() {
    manager.textList = ["", "", ""]
}

// JSON operations

struct Siblings: Codable {
    var siblings: [String] = []
}

var siblingsFile = Siblings()

struct Base: Codable {
    var directoryPath: String = ""
    var documentNumber: Int = 0
    var edit: Bool = true
    var imageList: [String] = []
    var siblings: [String] = []
    var textList: [String] = []
}

var base = Base()
/*
func saveJSON() -> Data {
    manager.edit = true
    refreshBase()
    let data = try! JSONEncoder().encode(base)
    return data
}

func loadJSON(_ data: Data) {
    print("(3) loading using loadJSON (Internal)")
    
    // decode
    
    let decoder = JSONDecoder()
    if let json = try? decoder.decode(Base.self, from: data) {
        base.directoryPath = json.directoryPath
        print("(3.01) loaded base.directoryPath: " + base.directoryPath + " (Internal)")
        base.documentNumber = json.documentNumber
        print("(3.02) loaded base.documentNumber: " + String(base.documentNumber) + " (Internal)")
        base.imageList = json.imageList
        var str = ""
        if (base.imageList.count != 0) {
            for item in base.imageList {
                str += item + " "
            }
        } else {
            str = "nil"
        }
        print("(3.03) loaded base.imageList: " + str + " (Internal)")
        base.textList = json.textList
        str = ""
        if (base.textList.count != 0) {
            for item in base.textList {
                str += item + " "
            }
        } else {
            str = "nil"
        }
        print("(3.04) loaded base.textList: " + str + " (Internal)")
        base.edit = json.edit
        if (base.edit == true) {
            print("(3.05) loaded base.edit: true" + " (Internal)")
        } else {
            print("(3.05) loaded base.edit: false" + " (Internal)")
        }
        base.siblings = json.siblings
        str = ""
        if (base.siblings.count != 0) {
            for item in base.siblings {
                str += item + " "
            }
        } else {
            str = "nil"
        }
        print("(3.06) loaded base.siblings: " + str + " (Internal)")
    }
    
    // refresh manager
    
    manager.directoryPath = base.directoryPath
    manager.documentNumber = base.documentNumber
    manager.edit = base.edit
    manager.imageList = base.imageList
    manager.textList = base.textList
    manager.pageCount = 1
    
    // buttons
    
    initializeButtonStatus()
    
    // siblings
    
    setSiblings()
    
    // document number
    
    setDocNum()
}
*/
// button operations

func initializeButtonStatus() {
    
    manager.buttonStatus = ["a", "a", "a", "a"]
    
}

func updateActiveButton(_ b0: String, _ b1: String, _ b2: String, _ b3: String, welcome: String) -> [String] {
    var output = [b0, b1, b2, b3]
    if (manager.buttonStatus[0] == "a") {
        output[0] = welcome
        manager.buttonStatus[0] = ""
    } else if (manager.buttonStatus[1] == "a") {
        output[1] = welcome
        manager.buttonStatus[1] = ""
    } else if (manager.buttonStatus[2] == "a") {
        output[2] = welcome
        manager.buttonStatus[2] = ""
    } else if (manager.buttonStatus[3] == "a") {
        output[3] = welcome
        manager.buttonStatus[3] = ""
    } else if (manager.buttonStatus == ["", "", "", ""]) {
        output[0] = welcome
        manager.buttonStatus = ["", "a", "a", "a"]
    } else if (manager.buttonStatus[0] == "A") {
        output[1] = welcome
        manager.buttonStatus = ["", "", "a", "a"]
    } else if (manager.buttonStatus[1] == "A") {
        output[2] = welcome
        manager.buttonStatus = ["a", "", "", "a"]
    } else if (manager.buttonStatus[2] == "A") {
        output[3] = welcome
        manager.buttonStatus = ["a", "a", "", ""]
    } else if (manager.buttonStatus[3] == "A") {
        output[0] = welcome
        manager.buttonStatus = ["", "a", "a", ""]
    } else if (manager.buttonStatus == ["A", "A", "A", "A"]) {
        output[0] = welcome
        manager.buttonStatus = ["", "a", "a", "a"]
    }
    return output
}

func buttonClick(_ b0: String, _ b1: String, _ b2: String, _ b3: String, welcome: String, window: String, bNum: Int) -> [String] {
    var output = [welcome, window]
    if (welcome != b0 && bNum == 0) {
        output[0] = output[0] + b0
        output[1] = output[1] + b0
    } else if (welcome != b1 && bNum == 1) {
        output[0] = output[0] + b1
        output[1] = output[1] + b1
    } else if (welcome != b2 && bNum == 2) {
        output[0] = output[0] + b2
        output[1] = output[1] + b2
    } else if (welcome != b3 && bNum == 3) {
        output[0] = output[0] + b3
        output[1] = output[1] + b3
    }
    return output
}

// html operations

func makeHTML(_ img: NSImage) -> URL {
    
    var output = URL(string: manager.directoryPath)
    
    do {
        let file = makeHTMLCode(img)
        let url = URL(string: file[1])!
        try file[0].write(to: url, atomically: true, encoding: .utf8)
        output = url
    }
    
    catch {
        print(error.localizedDescription)
    }
    
    return output!
}

func makeHTMLCode(_ img: NSImage) -> [String] {
    
    var str = ""
    var output = ""
    
    var body1 = ""
    for item in makeHTMLBody1() {
        body1 += item
    }
    
    var body2 = ""
    for item in makeHTMLBody2() {
        body2 += item
    }
    
    var body3 = ""
    for item in makeHTMLBody3() {
        body3 += item
    }
    
    print("(4) make HTML code (manager page count is " + String(manager.textList.count) + " (Internal)")
    
    for count in 1..<(manager.textList.count - 1) {
        str += body1
        str += "<iframe src=" + getImageForHTMLFromPlatform(count) + " width=\"100%\" height=\"350\" style=\"border:none;\">\n"
        str += "</iframe>\n"
        str += body2
        str += manager.textList[count]
        str += body3
        str += "<h4>" + String(count) + "</h4>\n"
    }
    
    for item in makeHTMLHeader() {
        output += item
    }
    
    output += str
    
    for item in makeHTMLFooter(img) {
        output += item
    }
    
    let url = URL(string: manager.directoryPath)?.appendingPathComponent("externals", isDirectory: true)            // sandboxing prevents saving to Desktop
    let imageName = URL(string: manager.currentURL)?.deletingPathExtension().lastPathComponent ?? "NSImage"
    let path = url?.appendingPathComponent(imageName).appendingPathExtension("html").absoluteString ?? ""
    
    return [output, path]
}

func getTitleforHTML() -> String {
    let output = URL(string: manager.currentURL)?.lastPathComponent
    return output ?? ""
}

func getImageforHTML(_ count: Int) -> String {              // for base data structure
    
    // make a path to destination of png file
    
    let imageURL = URL(string: manager.imageList[count])
    let imageName = imageURL?.lastPathComponent ?? "nil"
    var path = URL(string: manager.directoryPath)?.appendingPathComponent("externals", isDirectory: true).appendingPathComponent(imageName)
    path?.appendPathExtension("png")
    
    // make png file and write the file to destination
    
    do {
        let nsimg = NSImage(contentsOf: URL(string: manager.imageList[count])!)
        let file = NSBitmapImageRep(data: (nsimg?.tiffRepresentation!)!)?.representation(using: .png, properties: [:])
        try file?.write(to: path!)
    }
    
    catch {
        print(error.localizedDescription)
    }
    
    // return path
    
    return path?.absoluteString ?? ""
}

func makeHTMLHeader() -> [String] {
    
    let title = getTitleforHTML()
    
    var output: [String] = []
    output.append("<!DOCTYPE html>\n")
    output.append("<html>\n")
    output.append("<head>\n")
    output.append("<style>\n")
    output.append("table {\n")
    output.append("\tborder: 1px solid black;\n")
    output.append("\tborder-collapse: collapse;\n")
    output.append("\tpage-break-inside: avoid;\n")
    output.append("\twidth: 900px;\n")
    output.append("}\n")
//    output.append("h1 {\n")
//    output.append("\twidth: 600px;\n")
//    output.append("}\n")
    output.append("h2, h4, p {;\n")
    output.append("\tfont-family: \"Palatino\";\n")
    output.append("}\n")
    output.append("footer {\n")
    output.append("\tmargin-left: 600px;\n")
    output.append("\t}\n")
    output.append("</style>\n")
    output.append("<title>" + title + "</title>\n")
    output.append("</head>\n")
    output.append("<body>\n")
    output.append("<h1>" + title + "</h1>\n")
        
    return output
}

func makeHTMLBody1() -> [String] {
    
    var output: [String] = []
    output.append("<table width = \"100%\">\n")
    output.append("\t<col style=\"width:40%\">\n")
    output.append("\t<col style=\"width:60%\">\n")
    output.append("<tr>\n")
    output.append("<th>Image</th>\n")
    output.append("<th>Text</th>\n")
    output.append("</tr>\n")
    output.append("<tr>\n")
    output.append("<td>\n")
    
    return output
}

func makeHTMLBody2() -> [String] {
    
    var output: [String] = []
    output.append("</td>\n")
    output.append("<td>\n")
    output.append("<p>")
        
    return output
}

func makeHTMLBody3() -> [String] {
    
    var output: [String] = []
    output.append("</p>\n")
    output.append("</td>\n")
    output.append("</tr>\n")
    output.append("</table>\n")
    
    return output
}

func makeHTMLFooter(_ img: NSImage) -> [String] {
    
    let path = getLogoForHTMLFromPlatform(img)
    var output:[String] = []
    output.append("<footer>\n")
    output.append("<iframe src=" + path + " width=\"100%\" height=\"70\" style=\"border:none;\">\n")
    output.append("</iframe>\n")
    output.append("</footer>\n")
    output.append("</body>\n")
    output.append("</html>")
    
    return output
}

// platform data structure

struct Platform: Codable {
    var directoryPath: String = ""
    var documentNumber: Int = 0
    var edit: Bool = true
    var imageStrList: [String] = []
    var siblings: [String] = []
    var textList: [String] = []
}

var platform = Platform()

func refreshPlatform() {                                // platform counterpart to refreshBase()
    
    // prepare base64 strings
    
    var listData: [Data] = []
    for itemNS in manager.imageInventory {
        listData.append(itemNS.tiffRepresentation!)
    }
    
    var listStr: [String] = []
    for itemData in listData {
        listStr.append(itemData.base64EncodedString())
    }
    
    // refresh base64 strings in manager
    
    manager.imageStrList = listStr
    
    // refresh platform
    
    setPlatformSiblings()
    platform.directoryPath = manager.directoryPath
    platform.documentNumber = manager.documentNumber
    platform.imageStrList = manager.imageStrList
    platform.textList = manager.textList
    refreshSiblingsFile()
}

func refreshSiblingsFile() {
    siblingsFile.siblings = platform.siblings           // platform counterpart to refreshSiblings
}

func setDocNumFromPlatform() {
    setPlatformSiblings()                               // platform counterpart to setDocNum
    manager.documentNumber = platform.siblings.count
}

func setPlatformSiblings() {                            // platform counterpart to setSiblings
    
    // load tracker
    
    var destination = URL(string: manager.directoryPath)?.appendingPathComponent("internals", isDirectory: true)
    destination!.appendPathComponent("tracker")
    let decoder = JSONDecoder()
    if let data = try? decoder.decode(TrackerArray.self, from: Data(contentsOf: destination!)) {
        track.t = data.t
    }
    
    // check if current URL is already in tracker
    
    var sentry = false
    var output: [String] = []
    for item in track.t {
        if (item == manager.currentURL) {
            sentry = true
        }
    }
    
    // update siblings with current URL if appropriate
    
    if sentry == true {
        output = track.t
    } else {
        track.t.append(manager.currentURL)
        output = track.t
    }
    
    platform.siblings = output
    
    // update tracker
    
    let data = try! JSONEncoder().encode(track)
    do {
        try data.write(to: destination!)
    }
    catch {
        print(error.localizedDescription)
    }

}

func savePlatform() -> Data {
    manager.edit = true
    refreshPlatform()
    let data = try! JSONEncoder().encode(platform)
    return data
}

func loadPlatform(_ data: Data) {
    print("(3) loading using loadPlatform (Internal)")
    
    // decode
    
    let decoder = JSONDecoder()
    if let json = try? decoder.decode(Platform.self, from: data) {
        platform.directoryPath = json.directoryPath
        print("(3.01) loaded platform.directoryPath: " + platform.directoryPath + " (Internal)")
        platform.documentNumber = json.documentNumber
        print("(3.02) loaded platform.documentNumber: " + String(platform.documentNumber) + " (Internal)")
        platform.imageStrList = json.imageStrList
        print("(3.03) loaded platform.imageStrList: " + String(platform.imageStrList.count) + " images (Internal)")
        platform.textList = json.textList
        var str = ""
        if (platform.textList.count != 0) {
            for item in platform.textList {
                str += item + " "
            }
        } else {
            str = "nil"
        }
        print("(3.04) loaded platform.textList: " + str + " (Internal)")
        platform.edit = json.edit
        if (platform.edit == true) {
            print("(3.05) loaded platform.edit: true" + " (Internal)")
        } else {
            print("(3.05) loaded platform.edit: false" + " (Internal)")
        }
        platform.siblings = json.siblings
        str = ""
        if (platform.siblings.count != 0) {
            for item in platform.siblings {
                str += item + " "
            }
        } else {
            str = "nil"
        }
        print("(3.06) loaded platform.siblings: " + str + " (Internal)")
    }
    
    // prepare image inventory
    
    var inventoryData: [Data] = []
    for itemStr in platform.imageStrList {
        inventoryData.append(Data(base64Encoded: itemStr)!)
    }
    
    var inventoryNS: [NSImage] = []
    for itemData in inventoryData {
        inventoryNS.append(NSImage(data: itemData)!)
    }
    
    // refresh manager
    
    manager.directoryPath = platform.directoryPath
    manager.documentNumber = platform.documentNumber
    manager.edit = platform.edit
    manager.imageInventory = inventoryNS
    manager.textList = platform.textList
    manager.pageCount = 1
    
    // buttons
    
    initializeButtonStatus()
    
    // siblings
    
    setPlatformSiblings()
    
    // document number
    
    setDocNumFromPlatform()

}

func initializeVCFromPlatform(imgP: NSImage, imgC: NSImage, imgN: NSImage) {  // platform counterpart to initializeVC()
    
    // store the user's documents directory path to manager
    
    setDirectoryPath()
    
    // prep display buttons
    
    initializeButtonStatus()
    
    // set document number
    
    setDocNumFromPlatform()
    
    // save the first three images to image inventory
    
    manager.imageInventory = [imgP, imgC, imgN]
    
    // initialize the text list if necessary
    
    if (manager.textList.count < 3) {
        setTextList()
    }
    
    // load the saveable contents of the manager struct to a codable struct for JSON encoding later
    
    refreshPlatform()
}

func loadBackPlatform() -> String {                                           // platform counterpart to loadBack()
    var output = ""
    initializeButtonStatus()
    if (manager.textList[manager.pageCount] != output) {
        output = manager.textList[manager.pageCount]
    }
    return output
}

func loadForwardPlatform(_ img: NSImage) -> String {                                        // platform counterpart to loadForward()
    var output = ""
    initializeButtonStatus()
    let target = manager.pageCount + 1
    if (target >= manager.imageInventory.count) {
        do {
            try acceptImage(img, page: target)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    if (target >= manager.textList.count) {
        manager.textList.append(output)
    }
    if (manager.textList[manager.pageCount] != output) {
        output = manager.textList[manager.pageCount]
    }
    return output
}

func getImageForHTMLFromPlatform(_ count: Int) -> String {                    // platform counterpart to getImageforHTML()
    
    // construct a name for the image png
    
    var name = "NSImage"
    
    if (manager.documentNumber < 10) {
        name = fill00(manager.documentNumber) + name
    } else if (manager.documentNumber < 100) {
        name = fill0(manager.documentNumber) + name
    } else {
        name = String(manager.documentNumber) + name
    }
    
    if (count < 10) {
        name = name + fill00(count)
    } else if (count < 100) {
        name = name + fill0(count)
    } else {
        name = name + String(count)
    }
    
    // make a path to destination of png file
    
    var path = URL(string: manager.directoryPath)?.appendingPathComponent("externals", isDirectory: true).appendingPathComponent(name)
    path?.appendPathExtension("png")
    
    // make png file and write the file to destination
    
    do {
        let nsimg = manager.imageInventory[count]
        let file = NSBitmapImageRep(data: (nsimg.tiffRepresentation!))?.representation(using: .png, properties: [:])
        try file?.write(to: path!)
    }
    
    catch {
        print(error.localizedDescription)
    }
    
    // return path
    
    return path?.absoluteString ?? ""
}

func getLogoForHTMLFromPlatform(_ img: NSImage) -> String {

    // construct a name for the image png
    
    let name = "AnnotateLogo"
    
    // make a path to destination of png file
    
    var path = URL(string: manager.directoryPath)?.appendingPathComponent("externals", isDirectory: true).appendingPathComponent(name)
    path?.appendPathExtension("png")
    
    // make png file and write the file to destination
    
    do {
        let file = NSBitmapImageRep(data: (img.tiffRepresentation!))?.representation(using: .png, properties: [:])
        try file?.write(to: path!)
    }
    
    catch {
        print(error.localizedDescription)
    }
    
    // return path
    
    return path?.absoluteString ?? ""
}

