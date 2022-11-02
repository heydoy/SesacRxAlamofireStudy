//
//  NetworkManagaer.swift
//  Week18Assignments
//
//  Created by Doy Kim on 2022/11/03.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability: Reachability!
    
    static let shared = NetworkManager()
    
    
    override init() {
        super.init()
        // Initialise reachability
        do {
            reachability = try Reachability()
        } catch {
           
           print(error)
        }
        
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.shared.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }

    // Network is reachable
    func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection != .unavailable {
            completed(NetworkManager.shared)
        }
    }
    // Network is unreachable
    func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .unavailable {
            completed(NetworkManager.shared)
        }
    }
    // Network is reachable via WWAN/Cellular
    func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .cellular {
            completed(NetworkManager.shared)
        }
    }
    // Network is reachable via WiFi
    func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.shared.reachability).connection == .wifi {
            completed(NetworkManager.shared)
        }
    }
}
