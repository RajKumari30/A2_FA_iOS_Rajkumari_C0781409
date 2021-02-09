//
//  AppDelegate.swift
//  A2_FA_iOS_Rajkumari_C0781409
//
//  Created by Rajkumari on 31/01/21.
//  Copyright © 2021 RajKumari. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        print("\(path)")

        
        preloadScq()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func preloadScq() {
       let backgroundContext = persistentContainer.newBackgroundContext()
           persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
          _ = NSEntityDescription.entity(forEntityName: "Product", in: backgroundContext)!
        
        let preloadedDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
//         == false
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            guard let plistUrl = Bundle.main.url(forResource: "Products", withExtension:"plist") else {
                return
            }
            do {
                let plistData = try Data(contentsOf: plistUrl)
                
                
                
                let scqList = try PropertyListDecoder().decode([ProductCodable].self, from: plistData)
                print(scqList)
               for items in scqList {
                   print("These are the \(items)")
                   
                let entity = NSEntityDescription.entity(forEntityName: "Product", in: backgroundContext)!
                
                   let newEntity = Product(entity: entity, insertInto: backgroundContext)
                newEntity.prodID = items.prodID!
                newEntity.prodName = items.prodName!
                newEntity.prodDesc = items.prodDesc!
                newEntity.prodPrice = items.prodPrice!
                newEntity.prodProvider = items.prodProvider!
            
//                   newEntity.setValue(items.l, forKeyPath: ("answer" as? String)!)//This line did the trick
//                   print ("This is the new entity \(items.answer)")
                   try backgroundContext.save()
                       print("SAVED")
                UserDefaults.standard.set(true, forKey: preloadedDataKey)
                 }
            } catch {
                print(error)
            }
    
          
        }
    }
        
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "A2_FA_iOS_Rajkumari_C0781409")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//struct ProductCodable: Codable {
//
//    var prodID: Int16
//    var prodName: String
//    var prodDesc: String
//    var prodPrice: Float
//    var prodProvider: String
//
//}

struct ProductCodable : Codable {
    let prodID : Int16?
    let prodName : String?
    let prodDesc : String?
    let prodPrice : Float?
    let prodProvider : String?

    enum CodingKeys: String, CodingKey {

        case prodID = "prodID"
        case prodName = "prodName"
        case prodDesc = "prodDesc"
        case prodPrice = "prodPrice"
        case prodProvider = "prodProvider"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        prodID = try values.decodeIfPresent(Int16.self, forKey: .prodID)
        prodName = try values.decodeIfPresent(String.self, forKey: .prodName)
        prodDesc = try values.decodeIfPresent(String.self, forKey: .prodDesc)
        prodPrice = try values.decodeIfPresent(Float.self, forKey: .prodPrice)
        prodProvider = try values.decodeIfPresent(String.self, forKey: .prodProvider)
    }

}
