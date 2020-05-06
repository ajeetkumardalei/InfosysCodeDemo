



import Foundation
import UIKit



struct Constant {
    struct SERVER {
        static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    
}

struct NetWorkManager {
    static let nonetworkTitle = "No Network!"
    static let nonetworkMessage = "Offline! Please check your internet connection"
}

struct CellManager {
    static let cellIdentifier = "DashboardCell"
}

struct Placeholder {
    static let imgName = "noimage"
    static let noImage = UIImage(named: imgName)
}

struct PulltoRefresh {
    static let title = "Pull To Refresh..."
}

struct DownloadManager {
    static let succss = "Image downloaded Successfully!"
}
