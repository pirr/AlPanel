import Cocoa
import AppKit
import SwiftUI
import Foundation
import ServiceManagement
import Security

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var statusBarMenu: NSMenu!
    var statusBarMenuItem: NSMenuItem!
    let timeInterval: TimeInterval = 10.0
    var xpcService: XPCServiceProtocol?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let auth = Util.askAuthorization() else {
            fatalError("Authorization not acquired.")
        }
        Util.blessHelper(label: "XPCService", authorization: auth)
        let connection = NSXPCConnection(serviceName: "XPCService")
        connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        connection.resume()
        self.xpcService = connection.remoteObjectProxyWithErrorHandler { error in
            print("Received error:", error)
        } as? XPCServiceProtocol
        
        let statusBar = NSStatusBar.system
        
        self.statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        self.statusBarItem.button?.image = nil
        
        
        self.statusBarMenu = NSMenu()
//        self.statusBarMenu.addItem(self.statusBarMenuItem)
        self.statusBarItem.menu = self.statusBarMenu
        
        self.xpcCallCalcTempPeriodically()
        self.testPeriodicallyTask()
        self.xpcService!.purgeCacheMemory()
    }
    
    @objc func xpcCallCalcTempPeriodically() {
        self.xpcCallCalcTempAsync()
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.xpcCallCalcTempAsync()
        }
    }
    
    @objc func xpcCallCalcTempAsync() {
        let temp = 0.0
        self.xpcService!.calculateTemp(temp) { temp in
            DispatchQueue.main.async {
                let value = String(format: "%.1f", temp)
                self.statusBarItem.button?.title = value
            }
        }
    }
    
    func testPeriodicallyTask() {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            print("Periodically task")
        }
    }
}
