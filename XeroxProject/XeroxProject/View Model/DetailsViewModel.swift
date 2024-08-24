//
//  DetailsViewModel.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import Foundation

class DetailsViewModel: NSObject{
    
    override init() {
        super.init()
        
    }
    
//    MARK: Fetch current IP Address
    func currentIpAPI() async throws -> IpAddressResponseModel?{
        do{
            let request = APIRequestService.getIpAddress
            let result = try await Webservice.shareInstance.webRequest(apiRequestBuilder: request)
            return result
        }
        catch (let error){
            throw error as! LocalizedError
        }
    }
    
// MARK:   Fetch Ip Details
    func getIpDetails(ipAddress: String) async throws -> IpdetailsModel?{
        do{
            let request = APIRequestService.getCurrentIpInfo(ipAddress: ipAddress)
            let result = try await Webservice.shareInstance.webRequest(apiRequestBuilder: request)
            return result
        }
        catch (let error){
            throw error as! LocalizedError
        }
    }
    
}

