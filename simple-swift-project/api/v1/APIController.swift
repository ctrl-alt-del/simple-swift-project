//
//  APIController.swift
//  simple-swift-project
//
//  Created by Jiyang Liu on 6/12/14.
//  Copyright (c) 2014 ctrl-alt-del. All rights reserved.
//

import Foundation


class APIController: NSObject {
    
    
    var data: NSMutableData = NSMutableData()
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Get the response of a request, setup a mutable data object to ready for receiving data
        self.data = NSMutableData()
        println("--> Received Response, data package initialized")
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append recieved data
        self.data.appendData(data)
        println("--> Appending data...")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        var err: NSError

        // Deserialization JSON into HashMap assuming the data received is a serialized JSON
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        println("--> Data package completed!")
    }
    
    func iTuneAPISearchRequest(givenTerms: String) {
        
        // Replace spaces with + signs
        var terms = givenTerms.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Escape
        var escapedTerm = terms.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        // Compose url string
        var urlPath = "https://itunes.apple.com/search?term=\(escapedTerm)&media=software"
        
        // Make an NSURL object based on the urlPath
        var url: NSURL = NSURL(string: urlPath)
        
        // Establish an NSURLRequest object
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        // Make an NSURLConnection object based on the NSURLRequest created
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Search iTunes API at URL \(url)")
        
        // Conneceting to the internet
        connection.start()
    }

}
