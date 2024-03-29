//
//  CloudKitArticleHelper.swift
//  Articles
//
//  Created by Jan Hovland on 08/12/2021.
//

import SwiftUI
import CloudKit

func saveArticle(_ article: Article, useUrl: Bool) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitArticle.saveArticle(article, useUrl: useUrl)
        message = LocalizedStringKey(NSLocalizedString("The article has been saved in CloudKit", comment: ""))
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}

func modifyArticle(_ article: Article) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitArticle.modifyArticle(article)
        message = LocalizedStringKey(NSLocalizedString("The article has been modified in CloudKit", comment: ""))
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}

func articleExist(_ article: Article) async -> (err: LocalizedStringKey, exist: Bool) {
    var err : LocalizedStringKey = ""
    var exist : Bool = false
    do {
        exist = try await CloudKitArticle.existArticle(article)
        err = ""
    } catch {
        print(error.localizedDescription)
        err  = LocalizedStringKey(error.localizedDescription)
        exist = false
    }
    return (err, exist)
}

func findArticles() async -> (err: LocalizedStringKey, articles: [Article]) {
    var err : LocalizedStringKey = ""
    var articles = [Article]()
    do {
        err = ""
        articles = try await CloudKitArticle.getAllArticles()
    } catch {
        err  = LocalizedStringKey(error.localizedDescription)
        articles = [Article]()
    }
    
    return (err , articles)
}

func deleteArticle(_ recID: CKRecord.ID) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitArticle.deleteOneArticle(recID)
        message = LocalizedStringKey(NSLocalizedString("The article has been deleted", comment: ""))
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}

func articleRecordID(_ predicate: NSPredicate, _ article: Article) async -> (err: LocalizedStringKey, id: CKRecord.ID?) {
    var err : LocalizedStringKey = ""
    var id: CKRecord.ID?
    do {
        id = try await CloudKitArticle().getArticleRecordID(predicate, article)
        err = ""
    } catch {
        print(error.localizedDescription)
        err = LocalizedStringKey(error.localizedDescription)
        id = nil
    }
    return (err, id)
}

func deleteAllArticles(_ predicate: NSPredicate,_ recID: CKRecord.ID) async -> LocalizedStringKey {
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitArticle().deleteAllArticles(predicate, recID)
        message = LocalizedStringKey(NSLocalizedString("All articles have been deleted", comment: ""))
        return message
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        return message
    }
}
