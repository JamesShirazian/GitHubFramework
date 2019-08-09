//
//  GitHub.swift
//  GitHubFramework
//
//  Created by Afshin James Shirazian on 09/08/2019.
//  Copyright © 2019 Afshin James Shirazian. All rights reserved.
//

import Foundation

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
protocol GitHubFrameworkDelegate {
    func GitHubErrorOccured(error: Error)
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public class GitHubFramework: NSObject {
    
    /// GitHub username
    private var username: String!

    
    /// GitHub Delegate
    var delegate: GitHubFrameworkDelegate!

    /// <#Description#>
    /// - Parameter username: <#username description#>
    init(username: String) {
        super.init()
        self.username = username
    }
    

    /// <#Description#>
    /// - Parameter numberOfPages: <#numberOfPages description#>
    /// - Parameter completion: <#completion description#>
    func listRepository(searchTerm: String? = nil, numberOfPages: Int? = 100, completion: @escaping (_ repos: [RepoElement]) -> Void) {
        let endpoint = "https://api.github.com/users/\(username ?? "")/repos?per_page=\(String(describing: numberOfPages))"
        fetchResult(url: endpoint, method: "POST") { data, err in
            if err == nil {
                do {
                    let reuslt = try JSONDecoder().decode(Repo.self, from: data!)
                    if searchTerm != nil {
                        completion(reuslt.filter { (repo) -> Bool in
                            repo.name.contains(searchTerm!) ? true : false
                        })
                    } else {
                        completion(reuslt)
                    }

                } catch let internalError {
                    self.delegate?.GitHubErrorOccured(error: internalError)
                }
            } else {
                self.delegate?.GitHubErrorOccured(error: err!)
            }
        }
    }

    /// <#Description#>
    /// - Parameter url: <#url description#>
    /// - Parameter method: <#method description#>
    /// - Parameter completion: <#completion description#>
    private func fetchResult(url: String, method: String, completion: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        guard let url = URL(string: url) else { return }
        let cache = URLCache.shared
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let data = cache.cachedResponse(for: request)?.data {
            completion(data, nil)
        } else {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, res, err in
                if err == nil {
                    let cacheData = CachedURLResponse(response: res!, data: data!)
                    cache.storeCachedResponse(cacheData, for: request)
                    completion(data!, nil)
                } else {
                    completion(nil, err! as NSError)
                }

            })
            task.resume()
        }
    }
}
