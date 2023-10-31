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
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
                     completionHandler(.cancelAuthenticationChallenge, nil);
                     return
                 }

                 let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)

                 // SSL Policies for domain name check
                 let policy = NSMutableArray()
                 policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))

                 //evaluate server certifiacte
                 let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)

                 //Local and Remote certificate Data
                 let remoteCertificateData:NSData =  SecCertificateCopyData(certificate!)

                 let pathToCertificate = Bundle.main.path(forResource: "analytics.fruityvice.com", ofType: "cer")
                 let localCertificateData:NSData = NSData(contentsOfFile: pathToCertificate!)!
                 //Compare certificates
                 if(isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data)){
                     let _:URLCredential =  URLCredential(trust:serverTrust)
                     print("Certificate pinning is successfully completed")
                     completionHandler(.useCredential,nil)
                 }
        else {
            DispatchQueue.main.async {
                //self.showAlert(text: "SSL Pinning", message: "Pinning failed")
            }
            print("Certificate pinning is failed")
            completionHandler(.cancelAuthenticationChallenge,nil)
        }
        
    }
}
