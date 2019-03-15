

import Foundation
protocol ParameterBodyMaker {
    
    var parameters: [String:Any]? {get}
    var path: ServerPaths {get}
}

/*
 ALL services post dictionary is mentioned under enum switch statement.
 These cases get their values in ViewController (or respective controller or other class).
 This enum also wrap a method which provides dictionary for post body.
 */

internal enum JCPostServicePath : ParameterBodyMaker  {
    
    case countryDetail()
   // MARK: - Path
    internal var path: ServerPaths {
        switch self {
        case .countryDetail:
            return .countryDetail
       
      
        }
    }
    // MARK: - Parameters
    internal var parameters: [String:Any]?  {
        _ = [String:Any]()
        switch self {
        case .countryDetail():
        return nil
    }
}
}
enum ServerPaths: String {
    
    case countryDetail = "/facts"
    
}
