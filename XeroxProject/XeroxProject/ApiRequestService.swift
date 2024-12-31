//
//  ApiRequestService.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import Foundation

struct APIRequestService{
    
    static func getCurrentIpInfo(ipAddress: String) -> APIBuilderMethod<IpdetailsModel>{
        var urlString = customurl.getipInfo.rawValue
        
        urlString = urlString.replacingOccurrences(of: "{ipAddress}", with: ipAddress)
               return APIBuilderMethod(baseUrl:urlString)
    }
    
    static var getIpAddress:APIBuilderMethod<IpAddressResponseModel>{
        
        return APIBuilderMethod(baseUrl: customurl.getCurrentIP.rawValue)
    }
    
    
   
    
}
