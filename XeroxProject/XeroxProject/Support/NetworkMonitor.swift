//
//  NetworkMonitor.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import Foundation
import Network

class NetworkMonitor{
    
    static let sharedInstance = NetworkMonitor()
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    private init(){
        
    }
    func startMonitor(){
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                NotificationCenter.default.post(name: .networkNotReachable, object: nil, userInfo: ["status": true])
            }
        }
        networkMonitor.start(queue: queue)
    }
    
    
    func stopMonitor(){
        networkMonitor.cancel()
    }
    
}


extension Notification.Name{
    static let networkNotReachable = Notification.Name("networkNotReachable")
}
