//
//  URLSessionTest.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//
// Adapted from Ray Wenderlich's Unit Testing Mocking Objects
// https://www.raywenderlich.com/101306/unit-testing-tutorial-mocking-objects

import Foundation

//this protocol returns a data task object and takes either a url or url session as well as a completion handler
public protocol MockableURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

//This extension is to make the default URL session conform to the Mockable protocol
extension URLSession: MockableURLSession {}

//this class is a sublass of URLSessionDataTask, all it does is resume using its completionHandler
final private class URLSessionDataTaskMock  : URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
        }
    }
}


//Class below is to implement mock url session. It conforms to the MockableURLSession above and implements dataTask func with its properties
public final class URLSessionMock : MockableURLSession {
    var url: URL?
    var request: URLRequest?
    private let dataTaskMock: URLSessionDataTaskMock
    
    //When URLSessionMock is initialized, all the values are nil
    public init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        dataTaskMock = URLSessionDataTaskMock()
        dataTaskMock.taskResponse = (data, response, error)
    }
    
    
    //These functions below initializes the url and completionHandler and returns the DataTaskMock
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
    
    
}
