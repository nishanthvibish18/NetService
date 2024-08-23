//
//  Webservice.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import Foundation

enum customurl: String {
    case getCurrentIP = "https://api.ipify.org/?format=json"
    case getipInfo = "https://ipinfo.io/{ipAddress}/geo"
}

enum NetowrkError: Error, LocalizedError{
    case invalidURL
    case serverNotReachable
    case decodingError
    case noDataFound
    
    var localizationError: String{
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverNotReachable:
            return "Server is Not Reachable"
        case .decodingError:
            return "Decoding Error from Model"
        case .noDataFound:
            return "No Data Found"
        }
    }
}

enum HttpMethod: String{
    case get = "GET"
}

class APIBuilderMethod<T: Codable>{
    var baseUrl: String
    var method: HttpMethod = .get
    var body: Data? = nil
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}


final class Webservice{
    
    static let shareInstance = Webservice()
    private init(){
        
    }
    func webRequest<T>(apiRequestBuilder: APIBuilderMethod<T>, completionHandler: @escaping (Result<T, NetowrkError>) -> ()){
        
        guard let urlString = URL(string: apiRequestBuilder.baseUrl) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var urlrequest: URLRequest = URLRequest(url: urlString)
        urlrequest.httpMethod = apiRequestBuilder.method.rawValue
        if(apiRequestBuilder.body != nil){
            urlrequest.httpBody = apiRequestBuilder.body
        }
        
        URLSession.shared.dataTask(with: urlrequest) { data, response, error in
            
            guard let result = response as? HTTPURLResponse, result.statusCode == 200 else{
                completionHandler(.failure(.serverNotReachable))
                return
            }
            
            guard let resultData = data else {
                completionHandler(.failure(.noDataFound))
                return
            }
            
            do{
                let decodeData = try JSONDecoder().decode(T.self, from: resultData)
                completionHandler(.success(decodeData))
            }
            catch {
                completionHandler(.failure(.decodingError))
            }
        }
        .resume()
    }
    
}
