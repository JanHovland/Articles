//
//  CloudKitArticle.swift
//  Articles (iOS)
//
//  Created by Jan Hovland on 04/01/2021.
//

import CloudKit
import SwiftUI

struct CloudKitArticle {
    
    static var database = CKContainer(identifier: Config.containerIdentifier).publicCloudDatabase
    
    struct RecordType {
        static let Article = "Article"
    }
    
    /// MARK: - errors
    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    /// MARK: - saving to CloudKit inside CloudKitArticle
    static func saveArticle(_ article: Article, useUrl: Bool) async throws {
        let articleRecord = CKRecord(recordType: RecordType.Article)
        articleRecord["title"] = article.title
        articleRecord["introduction"] = article.introduction
        articleRecord["mainType"] = article.mainType
        articleRecord["subType"] = article.subType
        articleRecord["subType1"] = article.subType1
        if useUrl {
            articleRecord["url"] = article.url
        } else {
            articleRecord["url"] = ""
        }
        do {
            try await database.save(articleRecord)
        } catch {
            throw error
        }
    }
    
    // MARK: - check if the article record exists inside CloudKitArticle
    static func existArticle(_ article: Article) async throws -> Bool {
        var predicate: NSPredicate
        if article.subType1 == 0 {
            predicate = NSPredicate(format: "url = %@", article.url)
        } else {
            predicate = NSPredicate(format: "introduction = %@", article.introduction)
        }
        let query = CKQuery(recordType: RecordType.Article, predicate: predicate)
        do {
            let result = try await database.records(matching: query)
            for _ in result.0 {
                return true
            }
        } catch {
            throw error
        }
        return false
    }

    // MARK: - fetching from CloudKit inside CloudKitArticle
     static func getAllArticles() async throws -> [Article] {
        var articles = [Article]()
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.Article, predicate: predicate)
        do {
            ///
            /// Slik finnes alle postene
            ///
            let result = try await database.records(matching: query)
            
            for record in result .matchResults {
                var article = Article()
                ///
                /// Slik hentes de enkelte feltene ut:
                ///
                let art  = try record.1.get()
                
                let id = record.0.recordName
                let recID = CKRecord.ID(recordName: id)
                
                let title = art.value(forKey: "title") ?? ""
                let introduction = art.value(forKey: "introduction") ?? ""
                let mainType = art.value(forKey: "mainType") ?? 0
                let subType = art.value(forKey: "subType") ?? 0
                let subType1 = art.value(forKey: "subType1") ?? 0
                let url = art.value(forKey: "url") ?? ""
                
                article.recordID = recID
                article.title = title as! String
                article.introduction = introduction as! String
                article.mainType = mainType as! Int
                article.subType = subType as! Int
                article.subType1 = subType1 as! Int
                article.url = url as! String
 
                articles.append(article)
                articles.sort(by: {$0.title < $1.title})
            }
            return articles
        } catch {
            throw error
        }

    }
    
    // MARK: - delete from CloudKit inside CloudKitArticle
    static func deleteOneArticle(_ recID: CKRecord.ID) async throws {
        do {
            try await database.deleteRecord(withID: recID)
        } catch {
            throw error
        }
    }
    
    // MARK: - modify in CloudKit inside CloudKitArticle
    static func modifyArticle(_ article: Article) async throws {
        
        guard let recID = article.recordID else { return }
        
        do {
            let articleRecord = CKRecord(recordType: RecordType.Article)
            articleRecord["title"] = article.title
            articleRecord["introduction"] = article.introduction
            articleRecord["mainType"] = article.mainType
            articleRecord["subType"] = article.subType
            articleRecord["subType1"] = article.subType1
            articleRecord["url"] = article.url
            do {
                let _ = try await database.modifyRecords(saving: [articleRecord], deleting: [recID])
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func getArticleRecordID(_ predicate: NSPredicate,_ article: Article) async throws -> CKRecord.ID? {
        let query = CKQuery(recordType: RecordType.Article, predicate: predicate)
        do {
            ///
            /// Siden database.records(matching: query) er brukt tidligere må CloudKitArticle settes inn foran database
            ///
            let result = try await CloudKitArticle.database.records(matching: query)
            for res in result.0 {
                let id = res.0.recordName
                return CKRecord.ID(recordName: id)
            }
        } catch {
            throw error
        }
        return nil
    }
    
    
    func deleteAllArticles(_ predicate: NSPredicate, _ recID: CKRecord.ID) async throws {
        let query = CKQuery(recordType: RecordType.Article, predicate: predicate)
        do {
            let result = try await CloudKitArticle.database.records(matching: query)
            for res in result.0 {
                let id = res.0.recordName
                let recID = CKRecord.ID(recordName: id)
                try await CloudKitArticle.database.deleteRecord(withID: recID)
            }
        } catch {
            throw error
        }
    }


   
}



