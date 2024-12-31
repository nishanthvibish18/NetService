//
//  DashboardViewModel.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import Foundation
import CoreData
import UIKit


protocol DiscoverNetworkStauts{
    func updateStatusView()
}

class DashboardViewModel: NSObject {
    var services = [NetService]()
    var netServiceBrowser: NetServiceBrowser
    var discoveredDevices = [Devices]()
    var delegate: DiscoverNetworkStauts?
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        self.netServiceBrowser = NetServiceBrowser()
        super.init()
        self.netServiceBrowser.delegate = self
    }
    
    func startMonitor() {
        self.netServiceBrowser.searchForServices(ofType: "_airplay._tcp.", inDomain: "")
    }
    
    
    func fetchData(){
        do{
            self.discoveredDevices = try appDelegate.fetch(Devices.fetchRequest())
            self.delegate?.updateStatusView()
        }
        catch{
            print("error")
        }
    }
    
    func saveData(devices: Devices){
        do{
            try appDelegate.save()
            
            self.fetchData()
        }
        catch{
            print("error")
        }
        
    }
    
    
}




extension DashboardViewModel:  NetServiceBrowserDelegate, NetServiceDelegate{
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        services.append(service)
        service.delegate = self
        service.resolve(withTimeout: 10.0)
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        let ipAddress = getIpAddress(sender)
        let deviceName = sender.name
        if ipAddress != ""{
            let deviceDetails = Devices(context: appDelegate)
            deviceDetails.deviceName = "Device name: \(deviceName)"
            deviceDetails.ipAddress = "iP Address : \(ipAddress ?? "")"
            deviceDetails.status = "Rechable"
            self.saveData(devices: deviceDetails)
        }
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        let fetchRequest: NSFetchRequest<Devices> = Devices.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "deviceName == %@", service.name)
        
        do {
            let fetchedDevices = try appDelegate.fetch(fetchRequest)
            if let device = fetchedDevices.first {
                device.status = "UnRechable"
                saveData(devices: device)
            }
        } catch {
            print("Failed to save device: \(error)")
        }
        
        
    }
    
    
    func getIpAddress(_ service: NetService) -> String?{
        if let addresses = service.addresses, !addresses.isEmpty {
            let data = addresses[0]
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            data.withUnsafeBytes { ptr in
                guard let addr = ptr.baseAddress?.assumingMemoryBound(to: sockaddr.self) else { return }
                getnameinfo(addr, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST)
            }
            let ipAddress = String(cString: hostname)
            return ipAddress
        }
        
        return ""
    }
}
