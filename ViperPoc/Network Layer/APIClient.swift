

import Foundation
import Alamofire


protocol APIClient {
    
    func fetch<T: Codable>(with request: JCAPIResource, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void)
}

class APIService:APIClient {
    
    typealias JSONTaskCompletionHandler = (Codable?, APIError?) -> Void
    
    private func decodingTask<T: Codable>(with requestEnvelop: JCAPIResource, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler)  {
        let method = requestEnvelop.method.rawValue
        let type = HTTPMethod(rawValue: method)
        let header = HTTPHeaders(requestEnvelop.headers!)
        AF.request(requestEnvelop.urlComponents.url!, method:type!, parameters:requestEnvelop.parameters, encoding:requestEnvelop.encoding.getEncodingType(), headers: header).response { (response) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    do {
                        let strJson = String(decoding: response.result.value!!, as: UTF8.self)
                        guard let data = strJson.data(using: .utf8, allowLossyConversion: false) else { return  }

                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        print(json)
                        let genericModel = try JSONDecoder().decode(decodingType, from:data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .CouldNotDecodeJSON)
                    }
                }
                    
                    
                else
                {
                    completion(nil, .InvalidData)
                    
                }
                break
                
            case .failure(let errorObj):
                print(errorObj.localizedDescription)
                completion(nil, .ResponseUnsuccessful)
                
                break
                
            }
        }
        

       
    
    }
    
    
    func fetch<T: Codable>(with request: JCAPIResource, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void) {
        
        
      decodingTask(with: request, decodingType: T.self) { (json , error) in
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(APIResponse.failure(error))
                    } else {
                        completion(APIResponse.failure(.InvalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(APIResponse.failure(.CouldNotDecodeJSON))
                }
            }
            
        }
    }
    
    
    
    
    
}

