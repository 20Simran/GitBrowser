//
//  CoreDataViewModel.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import Foundation
import CoreData

class CoreDataViewModel {
    static let shared = CoreDataViewModel()
    private let context = PersistenceController.shared.container.viewContext

    func saveUserToCoreData(_ user: GitHubUser) {
          let fetch: NSFetchRequest<CDGitHubUser> = CDGitHubUser.fetchRequest()
          fetch.predicate = NSPredicate(format: "login == %@", user.login)
          
          if let existing = try? context.fetch(fetch).first {
              context.delete(existing)
          }

          let cdUser = CDGitHubUser(context: context)
          cdUser.login = user.login
          cdUser.avatar_url = user.avatar_url
          cdUser.bio = user.bio
          cdUser.followers = Int64(user.followers)
          cdUser.public_repos = Int64(user.public_repos)
          cdUser.following = Int64(user.following)
          cdUser.created_at = user.created_at

          try? context.save()
      }

    func loadUserFromCoreData(username: String) -> GitHubUser? {
          let fetchRequest: NSFetchRequest<CDGitHubUser> = CDGitHubUser.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "login == %@", username)

          if let cdUser = try? context.fetch(fetchRequest).first {
              return GitHubUser(
                  login: cdUser.login ?? "",
                  avatar_url: cdUser.avatar_url ?? "",
                  bio: cdUser.bio,
                  followers: Int(cdUser.followers),
                  following: Int(cdUser.following),
                  created_at: cdUser.created_at ?? "",
                  public_repos: Int(cdUser.public_repos)
              )
          }

          return nil
      }
}

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GitHubDataModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Core Data load failed: \(error), \(error.userInfo)")
            }
        }
    }
}

