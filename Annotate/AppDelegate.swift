//
//  AppDelegate.swift
//  Annotate
//
//  Created by Quaternion Works on 2021-08-27.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print("(1.5) applicationDidFinishLaunching (AppDelegate)")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("(4) applicationWillTerminate (AppDelegate)")
    }
}
