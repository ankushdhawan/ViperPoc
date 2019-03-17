
import Foundation
import Alamofire
public enum ServiceType: String {
    case Mock = "Mock"
    case RealServer = "RealServer"
    //Others
    public static let allCases = [ Mock, RealServer]
}

//http method type
enum RESTMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

//Defines the encoding of data is from url or from existing json
enum ParameterEncodingType {

    case URL
    case JSON
    
   func getEncodingType()->ParameterEncoding
    {
        switch self {
        case .JSON:
            return  JSONEncoding.default
        case .URL:
            return  URLEncoding.default
            
        }
    }
}

//defines the service request configuration

protocol JCAPIResource {
    
    init(path:String, method:RESTMethod, headers:[String:String]?, parameters:[String:Any]?,encoding:ParameterEncodingType)
    
    var serviceType : ServiceType { get }
    
    var basePath: String { get }
    
    var path: String { get }
    
    var method: RESTMethod { get }
    /**
     Authorization is usually set in the headers. You can set this to `[:]` if you don't have any
     headers to set. You can also create an extention on Endpoint to also have
     this default to a value.
     */
    var headers: [String:String]? { get }
    /**
     By default this will be set to empty - body()
     */
    var parameters: [String:Any]? { get }
    
    //By default, encoding will be set to URLEncoding for GET requests
    //and JSONEncoding for everything else.
    var encoding : ParameterEncodingType { get }
    
}

extension JCAPIResource {
    
    var serviceType:ServiceType {
        
        return .RealServer
    }
    
    var basePath:String {
        
        return JCConfigEndPoints.shared.appMode.baseEndPoint()!
    }
    
    var encoding: ParameterEncodingType {
        
        return method == .GET ? .URL : .JSON
    }
    
    var urlComponents: URLComponents {
        let finalPath = basePath + path
        let components = URLComponents(string: finalPath)!
        //components.path = finalPath
        return components
    }
    
    func body() -> Data? {
        guard parameters != nil else { return nil }
        switch (encoding) {
        case .JSON:
            return try? JSONSerialization.data(withJSONObject: parameters!)
        default:
            return nil
        }
    }
    
   
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = self.body()
        //request.allHTTPHeaderFields = self.headers
        return request
    }
}

struct GenericResource : JCAPIResource {
  
let path: String
    let method: RESTMethod
    let headers: [String : String]?
    let parameters: [String : Any]?
    let encoding: ParameterEncodingType
    
    init(path: String,
         method: RESTMethod = .POST,
         headers: [String: String]? = ["content-type": "text/plain"],
         parameters: [String: Any]? = nil, encoding :ParameterEncodingType = .JSON) {
        
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}

// MARK: - Equatable
extension GenericResource: Equatable {}

func ==(lhs: GenericResource, rhs: GenericResource) -> Bool {
    return lhs.path == rhs.path &&
        lhs.method == rhs.method &&
        lhs.headers! == rhs.headers! &&
        lhs.encoding == rhs.encoding
}


