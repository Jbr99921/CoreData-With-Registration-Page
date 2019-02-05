//
//  RegistrationDetails+CoreDataProperties.swift
//  RegistrationPageCoreData
//
//  Created by MacMiniOld on 19/11/18.
//  Copyright © 2018 Xongolab. All rights reserved.
//
//

import Foundation
import CoreData


extension RegistrationDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegistrationDetails> {
        return NSFetchRequest<RegistrationDetails>(entityName: "RegistrationDetails")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var imgUser: NSData?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var uniqueId: String?
    @NSManaged public var user: String?

}
