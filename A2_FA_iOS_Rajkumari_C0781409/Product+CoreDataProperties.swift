//
//  Product+CoreDataProperties.swift
//  A2_FA_iOS_Rajkumari_C0781409
//
//  Created by Rajkumari on 31/01/21.
//  Copyright © 2021 RajKumari. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var prodID: Int16
    @NSManaged public var prodName: String?
    @NSManaged public var prodDesc: String?
    @NSManaged public var prodPrice: Float
    @NSManaged public var prodProvider: String?

}
