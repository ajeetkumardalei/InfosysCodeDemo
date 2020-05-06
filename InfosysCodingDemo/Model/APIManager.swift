

import Foundation
import SystemConfiguration
import Alamofire



class APIManager: NSObject {
    static let shared = APIManager()
    

    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { SCNetworkReachabilityCreateWithAddress(nil, $0) } })
            else { return false }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    private func operation(with urlStr:String, completionSuccess: @escaping(_ dataToSend: Data) -> Void ) {
        
        guard let url = URL(string: urlStr) else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            if let err = error {
                debugPrint("\(err.localizedDescription)")
                return
            }
            
            guard let dataResponse = data, let httpResponse = urlResponse as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return }
            completionSuccess(dataResponse)
        }
        
        dataTask.resume()
        
    }
    
    func getCanadaInfo(with CompletionSuccess:@escaping(_ response: CanadaInfo) -> Void) {
        let fullURL = Constant.SERVER.baseURL
        
        operation(with: fullURL) { (dataToSend) in
            
            guard let mydata = String(decoding: dataToSend, as: UTF8.self).data(using: .utf8) else {return}
            do {
                let model = try JSONDecoder().decode(CanadaInfo.self, from: mydata)
                CompletionSuccess(model)
            } catch {
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
}




