//
//  ScreenViewController.swift
//  Demol
//
//  Created by 冯汉栩 on 2017/8/1.
//  Copyright © 2017年 hanxuFeng. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {
    
    fileprivate let screenBtn = UIButton()
    fileprivate let allShareBtn = UIButton()
    fileprivate let viewModel = ScreenViewModel()
    fileprivate let countLabel = UILabel()
    fileprivate let sharesMessLabel = UILabel()
    fileprivate let stopBtn = UIButton()
    fileprivate let spOfProgLabel = UILabel()
    fileprivate let tableView = UITableView()
    fileprivate let goldenCrossLabel = UILabel()
    fileprivate var model = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //解档
        solutionList()
        buildUI()
    }
    
    fileprivate func buildUI() {
        view.backgroundColor = Color.white
        view.addSubview(countLabel)
        view.addSubview(allShareBtn)
        view.addSubview(sharesMessLabel)
        view.addSubview(screenBtn)
        view.addSubview(stopBtn)
        view.addSubview(spOfProgLabel)
        view.addSubview(tableView)
        view.addSubview(goldenCrossLabel)
        buildSubView()
        buildLayout()
        buildNavigationItem()
    }
    
    fileprivate func buildSubView() {
        viewModel.delegate = self
        
        countLabel.font = Font.font20
        countLabel.textColor = Color.theme
        countLabel.text = "当前股票总数:".append(viewModel.archivingList.count.string)
        
        allShareBtn.setTitle("allShare", for: .normal)
        allShareBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        allShareBtn.setTitleColor(Color.nonActivated, for: .normal)
        allShareBtn.setBackgroundColor(color: Color.price, for: .highlighted)
        allShareBtn.layer.cornerRadius = 10
        allShareBtn.layer.masksToBounds = true
        allShareBtn.layer.borderWidth = 1
        allShareBtn.layer.borderColor = Color.nonActivated.cgColor
        allShareBtn.addTarget(self, action: #selector(allShareBtnClick), for: .touchUpInside)
        
        sharesMessLabel.font = Font.font20
        sharesMessLabel.textColor = Color.theme
        switch viewModel.sharesMessage {
        case .Success:
            sharesMessLabel.text = "所有股票是否获取成功:".append("成功")
        case .Fail:
            sharesMessLabel.text = "所有股票是否获取成功:".append("失败")
        case .Unkonw:
            sharesMessLabel.text = "所有股票是否获取成功:".append("未获取")
        }
        
        screenBtn.setTitle("screen", for: .normal)
        screenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        screenBtn.setTitleColor(Color.nonActivated, for: .normal)
        screenBtn.setBackgroundColor(color: Color.price, for: .highlighted)
        screenBtn.layer.cornerRadius = 10
        screenBtn.layer.masksToBounds = true
        screenBtn.layer.borderWidth = 1
        screenBtn.layer.borderColor = Color.nonActivated.cgColor
        screenBtn.addTarget(self, action: #selector(screenBtnClick), for: .touchUpInside)
        
        
        stopBtn.setTitle("STOP", for: .normal)
        stopBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        stopBtn.setTitleColor(Color.nonActivated, for: .normal)
        stopBtn.setBackgroundColor(color: Color.price, for: .highlighted)
        stopBtn.setBackgroundColor(color: Color.price, for: .selected)
        stopBtn.layer.cornerRadius = 10
        stopBtn.layer.masksToBounds = true
        stopBtn.layer.borderWidth = 1
        stopBtn.layer.borderColor = Color.nonActivated.cgColor
        stopBtn.addTarget(self, action: #selector(stopBtnClick), for: .touchUpInside)
        
        spOfProgLabel.text = viewModel.sharesIndex.string.append("/").append(viewModel.archivingList.count.string)
        spOfProgLabel.font = Font.font20
        spOfProgLabel.textColor = Color.theme
        
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false//横滚动条
        tableView.showsHorizontalScrollIndicator = false//竖滚动条
        tableView.backgroundColor = Color.white
//        tableView.separatorStyle = .none//隐藏分割线
//        tableView.sp.register(GoodInActiveCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.backgroundColor = Color.theme
        
        goldenCrossLabel.text = "MACD金叉股票个数: 0"
        goldenCrossLabel.font = Font.font20
        goldenCrossLabel.textColor = Color.theme
    }
    
    fileprivate func buildLayout(){
        
        countLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Space10)
            make.top.equalToSuperview().offset(SPStatusAndNavBarHeight + Space30)
        }
        
        allShareBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-Space30)
            make.centerY.equalTo(countLabel.snp.centerY)
            make.width.equalTo(Space100)
            make.height.equalTo(Space50)
        }
        
        sharesMessLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Space10)
            make.top.equalTo(countLabel.snp.bottom).offset(Space30)
        }
        
        screenBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Space10)
            make.top.equalTo(sharesMessLabel.snp.bottom).offset(Space60)
            make.width.equalTo(Space100)
            make.height.equalTo(Space50)
        }
        
        stopBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-Space30)
            make.centerY.equalTo(screenBtn.snp.centerY)
            make.width.equalTo(Space100)
            make.height.equalTo(Space50)
        }
        
        spOfProgLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(screenBtn.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(stopBtn.snp.bottom).offset(Space15)
            make.left.right.bottom.equalToSuperview()
        }
        
        goldenCrossLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Space15)
            make.top.equalTo(sharesMessLabel.snp.bottom).offset(Space15)
        }
    }
    
    fileprivate func buildNavigationItem(){
        
    }

   
}

extension ScreenViewController {
    
    func screenBtnClick() {
//        viewModel.allSharesData = viewModel.archivingList
        viewModel.allSharesData = viewModel.asd
    }
    
    func allShareBtnClick(){
        viewModel.getGrailData()    
    }
    
    func stopBtnClick(){
        stopBtn.isSelected = !stopBtn.isSelected
        viewModel.screenStop = !viewModel.screenStop
        
        if stopBtn.isSelected == true {
            tableView.isHidden = false
        }else{
            tableView.isHidden = true
        }
        
    }
    
    //解档
    func solutionList(){
        //判断路径是否为空
        if NSKeyedUnarchiver.unarchiveObject(withFile:viewModel.userAccountPath) != nil {
            //利用路径获取模型
            let  userModels = NSKeyedUnarchiver.unarchiveObject(withFile:viewModel.userAccountPath)as? ScreenViewModel
            viewModel.archivingList = userModels?.archivingList ?? [String]()
        }
    }

}

extension ScreenViewController: ScreenViewModelDelegate {
    
    //用于所有股票数据获取失败重复获取的
    func screenViewModel(base: ScreenViewModel, getAllSharesData soure: Any?) {
        viewModel.getGrailData()
    }
    
    func screenViewModel(base: ScreenViewModel, updateAllSharesData archivingList: [String], sharesIndex: Int) {
        //显示股票总数
        countLabel.text = "当前股票总数:".append(archivingList.count.string)
        spOfProgLabel.text = sharesIndex.string.append("/").append(viewModel.archivingList.count.string)
    }
    
    func screenViewModel(base: ScreenViewModel, updateScreenSpeedOfProgress sharesIndex: Int) {
        spOfProgLabel.text = sharesIndex.string.append("/").append(viewModel.archivingList.count.string)
    }
    
    func screenViewModel(base: ScreenViewModel, updateGoldenCross goldenCross: [String]) {
        if stopBtn.isSelected == true {
            model = goldenCross
            tableView.reloadData()
        }
        goldenCrossLabel.text = "MACD金叉股票个数: ".append((goldenCross.count + 1).string).append("  ").append(goldenCross.last!)
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension ScreenViewController: UITableViewDelegate,UITableViewDataSource {

    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    //行的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = model[indexPath.item]
        return cell!        
    }
    
    //点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
