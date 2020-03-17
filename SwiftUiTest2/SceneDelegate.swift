//
//  SceneDelegate.swift
//  SwiftUiTest2
//
//  Created by Michiel Schouten on 08/03/2020.
//  Copyright © 2020 Michiel Schouten. All rights reserved.
//

import UIKit
import SwiftUI
import NotificationCenter

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //var shortcutItemToProcess: UIApplicationShortcutItem?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

//        if let shortcutItem = connectionOptions.shortcutItem {
//            shortcutItemToProcess = shortcutItem
//        }
        
//        var copy: Bool
//
//        if let shortcutItem = connectionOptions.shortcutItem {
//            if shortcutItem.type == "ChielChiel.SwiftUiTest2.copy-code" {
//                // shortcut was triggered!
//                copy = true
//            } else {
//                copy = false
//            }
//        } else {
//            copy = false
//        }
//        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "copy-code-noti"), object: nil, userInfo: ["copy": copy]))
//
//        print("kopieren? \(copy)")
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//        if let shortcutItem = shortcutItemToProcess {
//            print(shortcutItem.type)
//            
//            shortcutItemToProcess = nil
//        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        let code: String = "5xasd87b"
        let icon = UIApplicationShortcutIcon(type: .share)
        let item = UIApplicationShortcutItem(type: "ChielChiel.SwiftUiTest2.copy-code", localizedTitle: code, localizedSubtitle: "Kopieer Kleppr code", icon: icon, userInfo: nil)
        UIApplication.shared.shortcutItems = [item]
    
    
    
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

