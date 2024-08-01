//
//  MovieModel.swift
//  FinalExam
//
//  Created by Mitul Patel on 01/08/24.
//

import Foundation

class MovieModel: NSObject {
    var docID: String = ""
    var id: String = ""
    var title: String = ""
    var studio: String = ""
    var genres: String = ""
    var directors: String = ""
    var writers: String = ""
    var actors: String = ""
    var year: String = ""
    var length: String = ""
    var shortDescription: String = ""
    var mpaRating: String = ""
    var criticsRating: String = ""
    var image: String = ""
    var imageData: String = ""

    // MARK: - Initialization
    override init() {
        super.init()
    }

    init(dictData: [String: Any]) {
        docID = setDataInString(dictData["docID"] as AnyObject)
        id = setDataInString(dictData["id"] as AnyObject)
        title = setDataInString(dictData["title"] as AnyObject)
        studio = setDataInString(dictData["studio"] as AnyObject)
        genres = setDataInString(dictData["genres"] as AnyObject)
        directors = setDataInString(dictData["directors"] as AnyObject)
        writers = setDataInString(dictData["writers"] as AnyObject)
        actors = setDataInString(dictData["actors"] as AnyObject)
        year = setDataInString(dictData["year"] as AnyObject)
        length = setDataInString(dictData["length"] as AnyObject)
        shortDescription = setDataInString(dictData["shortDescription"] as AnyObject)
        mpaRating = setDataInString(dictData["mpaRating"] as AnyObject)
        criticsRating = setDataInString(dictData["criticsRating"] as AnyObject)
        image = setDataInString(dictData["image"] as AnyObject)
        imageData = setDataInString(dictData["imageData"] as AnyObject)
    }

    
}
