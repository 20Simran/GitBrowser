//
//  CDGitHubUser+CoreDataProperties.swift
//  GitBrowser
//
//  Created by Simran Semwal on 18/07/25.
//
//

import Foundation
import CoreData


extension CDGitHubUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGitHubUser> {
        return NSFetchRequest<CDGitHubUser>(entityName: "CDGitHubUser")
    }

    @NSManaged public var avatar_url: String?
    @NSManaged public var bio: String?
    @NSManaged public var created_at: String?
    @NSManaged public var followers: Int64
    @NSManaged public var following: Int64
    @NSManaged public var login: String?
    @NSManaged public var public_repos: Int64

}

extension CDGitHubUser : Identifiable {

}
