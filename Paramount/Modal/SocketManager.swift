//
//  SocketManager.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 03/06/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import Foundation

class SocketManager
{
    
}
/*
{
    let socket : TCPClient
    
    class var sharedInstance: SocketManager {
        struct Singleton {
            static let instance = SocketManager()
        }
        return Singleton.instance
    }
    
    init() {
        // Create the socket
        self.socket = TCPClient(address: "www.apple.com", port: 9000)
        // Connect the socket
        let (success, msg )=self.socket.connect(timeout: 1)
       
        
        print("\(msg) : \(success)")
        
    }
    
    internal func sendMessage(data: String){
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(Int(qualityOfServiceClass.rawValue), 0)
        
    
        dispatch_async(backgroundQueue, {
            let request = self.sendRequest(data: data, client: self.socket)
            print("received message: \(request)")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("This is run on the main queue, after the previous code in outer block")
            })
            
        })
    }
    
    private func sendRequest(data: String, client: TCPClient?) -> (String?) {
        // It use ufter connection
        if client != nil {
            // Send data  (WE MUST ADD SENDING MESSAGE '\n' )
            let (isSuccess, errorMessage) = client!.send(str: "\(data)\n")
            if isSuccess {
                // Read response data
                let data = client!.read(1024*10)
                if let d = data {
                    // Create String from response data
                    if let str = NSString(bytes: d, length: d.count, encoding: NSUTF8StringEncoding) as? String {
                        return (data: str)
                    } else {
                        return (data: nil)
                    }
                } else {
                    return (data: nil)
                }
            } else {
                print(errorMessage)
                return (data: nil)
            }
        } else {
            return (data: nil)
        }
    }

}
*/
