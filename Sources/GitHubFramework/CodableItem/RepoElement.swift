//
//  Repo.swift
//  GitHubFramework
//
//  Created by Afshin James Shirazian on 09/08/2019.
//  Copyright © 2019 Afshin James Shirazian. All rights reserved.
//

import Foundation

// MARK: - RepoElement

public struct RepoElement: Codable {
    public let id: Int
    public let nodeID, name, fullName: String
    public let repoPrivate: Bool
    public let owner: Owner
    public let htmlURL: String
    public let repoDescription: String?
    public let fork: Bool
    public let url, forksURL: String
    public let keysURL, collaboratorsURL: String
    public let teamsURL, hooksURL: String
    public let issueEventsURL: String
    public let eventsURL: String
    public let assigneesURL, branchesURL: String
    public let tagsURL: String
    public let blobsURL, gitTagsURL, gitRefsURL, treesURL: String
    public let statusesURL: String
    public let languagesURL, stargazersURL, contributorsURL, subscribersURL: String
    public let subscriptionURL: String
    public let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String
    public let contentsURL, compareURL: String
    public let mergesURL: String
    public let archiveURL: String
    public let downloadsURL: String
    public let issuesURL, pullsURL, milestonesURL, notificationsURL: String
    public let labelsURL, releasesURL: String
    public let deploymentsURL: String
    public let gitURL, sshURL: String
    public let cloneURL: String
    public let svnURL: String
    public let homepage: JSONNull?
    public let size, stargazersCount, watchersCount: Int
    public let language: String
    public let hasIssues, hasProjects, hasDownloads, hasWiki: Bool
    public let hasPages: Bool
    public let forksCount: Int
    public let mirrorURL: JSONNull?
    public let archived, disabled: Bool
    public let openIssuesCount: Int
    public let license: JSONNull?
    public let forks, openIssues, watchers: Int
    public let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case repoPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case repoDescription = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
    }
}

// MARK: - Owner

public struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

public typealias Repo = [RepoElement]

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {
    public static func == (_: JSONNull, _: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
