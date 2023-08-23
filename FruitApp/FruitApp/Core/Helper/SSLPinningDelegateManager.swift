//
//  SSLPinningDelegateManager.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//
import Foundation

final class SSLPinningDelegateManager: NSObject, URLSessionDelegate {
    
    var isSSLPinningEnabled = false
    
    init(isSSLPinningEnabled: Bool = false){
        self.isSSLPinningEnabled = isSSLPinningEnabled
    }
    //MARK :- UrlSession Delegate.
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.serverTrust == nil {
            completionHandler(.useCredential, nil)
        } else {
            let trust: SecTrust = challenge.protectionSpace.serverTrust!
            let credential = URLCredential(trust: trust)
            completionHandler(.useCredential, credential)
        }
        
    }
}
