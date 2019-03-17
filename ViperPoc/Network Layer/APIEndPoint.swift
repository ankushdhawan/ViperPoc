
import Foundation
struct JCNetworkEndPoints {
    
    static func getDevBaseURL()->String {
        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl"
    }
   
    static func getProductionBaseURL()->String {
        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl"
    }
}



/*
 This structure has member function to set the current build scheme. Current build scheme selected in XCode will be set into project info.plist key named as APP_ENV. This key is also mentioned under Build Setting
 where each schemes names are mentioned. All these name must be equal to the names as mentioned under the Enum of AppEnvMode.
 
 */
struct JCConfigEndPoints {
    
    internal enum AppEnvMode:String {
        
        case Undefined = "Undefined"
        case Debug = "Debug"
        case Release = "Release"
        
        /*
         Set your project scheme base urls
         */
        func baseEndPoint()->String? {
            
            switch self {
            case .Debug:
                return JCNetworkEndPoints.getDevBaseURL()
            case .Release:
                return JCNetworkEndPoints.getProductionBaseURL()
            default:
                return JCNetworkEndPoints.getDevBaseURL()
            }
        }
    }
    
    private var mode: AppEnvMode = .Debug
    static var shared = JCConfigEndPoints()
    
    var appMode:AppEnvMode {
        get {
            return mode
        }
    }
    
    /* This method need to be called when app launches. Ideal place to call this method at the very beginining of AppDelegate delegate method didFinishLaunching */
    mutating func initialize() {
        
        self.mode = .Undefined
        
        /* Value is captured from info.plist. Value in info.plist will come from User-Defined Variables APP_ENV */
        if let modeString = Bundle.main.infoDictionary?["APP_ENV"] as? String,
            let modeType = AppEnvMode(rawValue: modeString) {
            self.mode = modeType
        }
    }
}
