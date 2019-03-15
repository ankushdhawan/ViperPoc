
import Foundation

struct MockService:APIClient  {
    func fetch<T>(with request: JCAPIResource, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void) where T : Decodable, T : Encodable {
        self.request(fileName: request.path) { result in
            completion(result)
        }
    }
    
    
   func request< T: Codable>(fileName : String, completion: (APIResponse<T, APIError>) -> Void) {
        print("Loading Mock CarePlan Data")
        let resource = GenericResource(path: fileName, method: .GET, headers: nil, parameters: nil)
        if let url = Bundle.main.url(forResource: resource.path, withExtension:"json")
        {
            do {

                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                 completion(.success(value))
            } catch {
               completion(APIResponse.failure(.RequestFailed))
            }
        }
    else
        {
        return  completion(APIResponse.failure(.CouldNotDecodeJSON))
    }
        
    }
    
}
