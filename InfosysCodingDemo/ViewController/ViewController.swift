

import UIKit
import ImageViewer_swift


class ViewController: UIViewController {
    var dashbdViewmodel = DashboardViewModel.init()

    var model = CanadaInfo()
    var arrInfo = [Row]()
    
    //MARK: - Refreshcontrol configuration with lazy property
    private lazy var refreshCtrl: UIRefreshControl = {
        let refreshContol = UIRefreshControl()
        refreshContol.tintColor = .red
        refreshContol.attributedTitle = NSAttributedString(string: PulltoRefresh.title)
        return refreshContol
    }()

    //MARK: - Tableview configuration with lazy property
    private lazy var tblvw: UITableView = {
        let table = UITableView()
        table.separatorColor = .lightGray
        table.dataSource = self
        table.register(DashboardCell.self, forCellReuseIdentifier: CellManager.cellIdentifier)
        return table
    }()

    //MARK: - View life cycle - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableview()
        refreshCtrl.addTarget(self, action: #selector(doRefresh(_ :)), for: .valueChanged)
        dashbdViewmodel.delegate = self as? DashboardDelegate
        getAboutCanada()
    }
    
    //MARK: - View life cycle - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: - Topbar title and configuration
    func setUpNavigation(with title:String?) {
        navigationItem.title = title
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 22)!]
    }
    
    //MARK: - Tableview initial setup
    func setupTableview() {
        self.view.addSubview(tblvw)

        tblvw.translatesAutoresizingMaskIntoConstraints = false
        tblvw.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tblvw.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tblvw.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tblvw.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tblvw.tableFooterView = UIView()
        tblvw.estimatedRowHeight = UITableView.automaticDimension
        tblvw.rowHeight = 120

        if #available(iOS 10.0, *) {
            tblvw.refreshControl = refreshCtrl
        } else {
            tblvw.addSubview(refreshCtrl)
        }
    }
    
    //MARK: - Refreshcontrol method
    @objc func doRefresh(_ sender:UIRefreshControl) {
        sender.endRefreshing()
        getAboutCanada()
    }
    
}

//MARK: - API Configuration call back
private typealias APIConfiguration = ViewController
extension APIConfiguration {
    @objc func getAboutCanada() {
        DispatchQueue.main.async {
            Helper.sharedInstance.showLoader()
        }

        if APIManager.shared.connectedToNetwork() {
            dashbdViewmodel.apiCallForDashboard(true) { (isSuccess) in
                if isSuccess {
                    let fullmodel = self.dashbdViewmodel.canadaInfoModel
                    
                    DispatchQueue.main.async {[weak self] in
                        guard let selfS = self else {return}
                        
                        selfS.setUpNavigation(with: fullmodel.title)
                        if var temparr = fullmodel.rows, temparr.count > 0 {
                            //remove empty element from array
                            temparr = temparr.filter{($0.imageHref != nil) && ($0.title != nil) && ($0.description != nil) }
                            selfS.arrInfo = temparr
                            
                            selfS.tblvw.reloadData()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                Helper.sharedInstance.hideLoader()
                            })

                        }
                    }
                }
            }
        } else {
            debugPrint(NetWorkManager.nonetworkMessage)
            self.showAlertSimple(title: NetWorkManager.nonetworkTitle, msg: NetWorkManager.nonetworkMessage, isAutoDismiss: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {[weak self] in
                guard let selfS = self else {return}
                Helper.sharedInstance.hideLoader()
                selfS.refreshCtrl.beginRefreshing()
                selfS.refreshCtrl.endRefreshing()
            })
        }
    }
    
}

//MARK: - Tableview delegate methods
private typealias TableviewConfiguration = ViewController
extension TableviewConfiguration: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellManager.cellIdentifier) as? DashboardCell else {return UITableViewCell()}
        if arrInfo.count > 0 {
            let item = arrInfo[indexPath.row]
            cell.configureCell(with: item)
            return cell
        }
        
        return UITableViewCell()
    }

}




