

import Foundation

internal enum APIResponse<T, U> where U: Error {
    
    case success(T?)
    case failure(U)
    case uninitialize
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        case .uninitialize:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: T? {
        switch self {
        case .success(let T):
            return T
        case .failure:
            return nil
        case .uninitialize:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: U? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        case .uninitialize:
            return nil
        }
    }
}


enum APIError: Error  {
    
    case CouldNotDecodeJSON
    case BadStatus(status: Int)
    case Other(Error)
    case CustomMessageError(message:String)
    case RequestFailed
    case InvalidData
    case ResponseUnsuccessful
}

extension APIError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .CouldNotDecodeJSON:
            return "Could not decode JSON"
        case let .BadStatus(status):
            return "Bad status \(status)"
        case .RequestFailed :
            return "Request Failed"
        case .InvalidData :
            return "Invalid Data"
        case .ResponseUnsuccessful :
            return "Response Unsuccessful"
        case let .Other(error):
            return "\(error)"
        case let .CustomMessageError(messgae):
            return "\(messgae)"
        }
    }
}

protocol ResponseData {
    
    var error:Int? {get set}
    var message:String {get set}
    var successful:Int? {get set}
}


