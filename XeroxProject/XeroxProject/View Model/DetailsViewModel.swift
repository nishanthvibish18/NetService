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
    func currentIpApi(completionHandler: @escaping (Result<IpAddressResponseModel,NetowrkError>) -> ()){
        let request = APIRequestService.getIpAddress
        
        Webservice.shareInstance.webRequest(apiRequestBuilder: request) { result in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
    
    
// MARK:   Fetch Ip Details
    func getIpDetails(ipAddress: String,completionHandler: @escaping(Result<IpdetailsModel, NetowrkError>) -> ()){
                
        let request = APIRequestService.getCurrentIpInfo(ipAddress: ipAddress)
        Webservice.shareInstance.webRequest(apiRequestBuilder: request) { res in
            switch res {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
        
        
        
    }
    
}

