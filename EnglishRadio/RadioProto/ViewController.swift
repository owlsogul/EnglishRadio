//
//  ViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 1. 9..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import RealmSwift
import AVFoundation

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    static var sdManager = StationDataManager()
    static var favManager = FavoriteManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var stationTitleLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var stationImage: UIImageView!
  
    /**MPVolumeView : 슬라이더로 시스템볼륨 조절하기*/
    @IBOutlet weak var volumeView: MPVolumeView!
    func adjustVolumeView() {
        self.volumeView.showsRouteButton = false
        self.volumeView.showsVolumeSlider = true
        self.volumeView.backgroundColor = UIColor.clear
    }
   
    
    let radioPlayer = AVPlayer()
    var isPlay: Bool = false
    var currentStation: StationData!
    var firstPlay: Bool = true
    
    
    
    
    //###################################################
    // MARK: - 뷰 로딩 설정
    //###################################################
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        ViewController.sdManager.loadStationsFromJSON()
        print("sdManager Load Test : \(ViewController.sdManager.getNumberOfStation())")
        ViewController.favManager.register(sdManager: ViewController.sdManager)
        print("favManger Load Test : \(ViewController.favManager.sdManager.getNumberOfStation())")
        
        setupPlayer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("나는 사라졌다!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("나는 나타났다!")
        if currentStation != nil {
            changeFavorite()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //TODO: 꺼져도 계속 인풋을 받음 - 해결해야함
        if isPlay{
            radioPlayer.play()
        }
    }
    
    
    //###################################################
    // MARK: - play 초기화
    //###################################################

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if isPlay{
            radioPlayer.play()
        }
    }
    
    /** 오디오 플레이어를 초기화하는 함수 */
    func setupPlayer(){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        adjustVolumeView()
    }
    
    //###################################################
    // 초기화 끝
    //###################################################
    
    
    
    
    //###################################################
    // MARK: - 잠금화면 파트
    //###################################################
    
    /** 잠금화면 스크린을 업데이트 하는 함수 */
    func updateLockScreen() {
        
        // Update notification/lock screen
        let albumArtwork = MPMediaItemArtwork(image: #imageLiteral(resourceName: "albumArt"))
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyArtist: "",
            MPMediaItemPropertyTitle: currentStation.getStationName(),
            MPMediaItemPropertyArtwork: albumArtwork
        ]
    }
    
    /** 잠금화면으로부터 버튼 클릭 이벤트를 받아오는 함수 */
    override func remoteControlReceived(with receivedEvent: UIEvent?) {
        super.remoteControlReceived(with: receivedEvent)
        
        if receivedEvent!.type == UIEventType.remoteControl {
            print("이벤트의 서브 타입 : \(receivedEvent!.subtype)")
            switch receivedEvent!.subtype {
            case .remoteControlPlay:
                play()
                print("잠금화면에서 플레이 버튼이 눌렸다.")
                break;
            case .remoteControlPause:
                pause()
                print("잠금화면에서 멈춤 버튼이 눌렸다.")
                break;
            case .remoteControlNextTrack:
                clickNextButton()
                print("잠금화면에서 다음 버튼이 눌렸다.")
                break;
            case .remoteControlPreviousTrack:
                clickPrevButton()
                print("잠금화면에서 이전 버튼이 눌렸다.")
                break;
            default:
                break
            }
        }
    }
    
    //###################################################
    // 잠금화면 파트 끝
    //###################################################
    
    
    //###################################################
    // MARK: - 라디오 컨트롤 함수 파트
    //###################################################
    
    func play(){
        

        //만약 처음으로 실행한 것이 아니면
        if firstPlay {
            if chooseRandomStation() {
                print("스테이션이 없습니다")
            }
            firstPlay = false
        }
        
        radioSetting()
        radioPlay()
        
        refreshMainInfo()
               updateLockScreen()
        isPlay = true
        
    }
    
    func pause(){
        playButton.setImage(#imageLiteral(resourceName: "newPlay"), for: .normal)
        radioPlayer.replaceCurrentItem(with: nil)
        radioPlayer.pause()
        isPlay = false
        firstPlay = false
        //bottomStationLabel.text = "Radio paused..."
    }
    
    /** 랜덤으로 스테이션을 고르는 함수 */
    func chooseRandomStation() -> Bool{
        let rand:UInt32 = arc4random_uniform(38) + 1
        var token: Int = 0
        
        currentStation = ViewController.sdManager.stationMap[Int(rand)]
        
        // TODO: 나라가 없을때랑 기타 등등의 상황등을 고려해봐야할듯
        //for 문을 통해 현재 스테이션과 CountryViewController 에 있는 아이템을 비교 후 같으면 토큰 1 증가
        for item in CountryViewController.selectedCountry{
            
            if item == currentStation.getStationCountry(){
                token += 1
            }
            
        }
        //따라서 토큰이 0 이면 같은 채널이 없음
        if token == 0 {
            return true
        }else {
            return false
        }
        
    }
    
    
    //###################################################
    // MARK: - 라디오 Station 설정 함수
    //###################################################
    
    /** 기존의 라디오가 틀어져있다면 멈추고(다른 스트리밍을 위해), 스트리밍 주소를 바꾸는 함수 */
    func radioSetting(){
        if isPlay {
            radioPlayer.pause()
        }
        print(CountryViewController.selectedCountry)
        let playerItem = AVPlayerItem(url:NSURL(string: currentStation.getStreamingURL()) as! URL)
        radioPlayer.replaceCurrentItem(with: playerItem)
    }
    
    /** 현재의 방송국을 스트리밍하는 함수 */
    func radioPlay(){
        print("Now Playing is : \(currentStation.getStationName())")
        radioPlayer.play()
    }
    
   
    
    
    //###################################################
    // MARK: - 라디오 Station history
    //###################################################
    
    
    /** 재생된 목록을 ID값으로 저장하는 배열
     다음 버튼(>>)을 눌러야 값이 저장된다. */
    var history: [Int] = []
    /** 히스토리를 추가하는 함수 */
    func addHistory(){
        history.append(currentStation.getStationId())
    }
    /** 히스토리에서 마지막 스테이션의 아이디값을 가져온다 */
    func getLastStationId() -> Int? {
        if (history.count > 0){
            print(history.endIndex)
            let ret: Int = history[history.endIndex-1]
            history.remove(at: history.endIndex-1)
            return ret
        }
        else {
            return nil
        }
    }
    
    
    
    
    //###################################################
    // MARK: - Favorite 관련 설정
    //###################################################
    
    /** 메인의 정보를 바꿔주는 함수 */
    func refreshMainInfo(){
        tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        stationTitleLabel.text = "\(currentStation.getStationName())"
        detailTitleLabel.text = "\(currentStation.getStationCountry())"
        changeFavorite()
    }
    
    /** 알림창을 위한 타이머 */
    var alertTimer: Timer?
    
    /** 페이버릿에 추가됬음을 알리는 함수 */
    func alertAddingFavorite(station: StationData){
        self.alertLabel.text = "Added favorite"
        self.alertLabel.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        UIView.transition(with: alertView, duration: 0.5, options: .transitionCrossDissolve, animations: {() -> Void in
            self.alertView.isHidden = false;
        }, completion: { _ in })
        
        // 이전 타이머를 초기화합니다
        self.alertTimer?.invalidate()
        self.alertTimer = nil
        
        alertTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(alertEnd(timer:)), userInfo: nil, repeats: false)
        
    }
    
    /** 페이버릿에 추가됬음을 알리는 함수 */
    func alertDeletingFavorite(station: StationData){
        self.alertLabel.text = "Deleted favorite"
        self.alertLabel.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        UIView.transition(with: alertView, duration: 0.5, options: .transitionCrossDissolve, animations: {() -> Void in
            self.alertView.isHidden = false;
        }, completion: { _ in })
        
        // 이전 타이머를 초기화합니다
        self.alertTimer?.invalidate()
        self.alertTimer = nil
        
        alertTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(alertEnd(timer:)), userInfo: nil, repeats: false)
        
    }
    
    /** 애니매이션을 위한 함수 */
    func alertEnd(timer: Timer){
        UIView.transition(with: alertView, duration: 0.5, options: .transitionCrossDissolve, animations: {() -> Void in
            self.alertView.isHidden = true;
        }, completion: { _ in })
        self.alertTimer?.invalidate()
        self.alertTimer = nil
    }


    /** Favorite 버튼 갱신 할 때 쓰임!  */
    func changeFavorite(){
        if ViewController.favManager.isFavorite(id: currentStation.getStationId()) {
            favoriteButton.setImage(#imageLiteral(resourceName: "newFavoriteFilled"), for: .normal)
        }
        else {
            favoriteButton.setImage(#imageLiteral(resourceName: "newFavorite"), for: .normal)
        }
    }
    
    
    
    //###################################################
    // 라디오 컨트롤 함수 파트 끝
    //###################################################
    
    
    //###################################################
    // MARK: - 라디오 액션 연결 - Play, Next, Prev
    //###################################################
    
    @IBAction func clickPlayButton(){
        if !isPlay{
            playButton.setImage(#imageLiteral(resourceName: "newPause"), for: .normal)
            
            play()
            //만약 플레이 버튼이 눌리면 1번째 줄 셀 리로드
            tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
            
        }else {
            
            pause()
            tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .bottom)
            
        }
        
    }
    
    @IBAction func clickNextButton() {
        
        if isPlay{
            
            // 히스토리 저장
            addHistory()
            
            // 랜덤 스테이션 가져오기
            while chooseRandomStation(){
                if CountryViewController.selectedCountry.count == 0{
                    break
                }
                
            }
            
            // 스트리밍 시작
            radioSetting()
            radioPlay()
            
            isPlay = true
            firstPlay = false
            
            // 정보 갱신
            refreshMainInfo()
            
        }
    }
    
    // 이전 버튼을 눌렀을 때 호출되는 함수
    @IBAction func clickPrevButton(){
        
        // 만약 최근 재생한 스테이션이 있다면
        if let lastStationId = getLastStationId() {
            
            // 현재 스테이션 바꿔줌
            currentStation = ViewController.sdManager.stationMap[lastStationId]
            radioSetting()
            // 스트리밍 시작
            print("Now Playing is : \(currentStation.getStationName())")
            radioPlay()
            isPlay = true
            firstPlay = false
            
            // 정보 갱신
            tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
            stationTitleLabel.text = "\(currentStation.getStationName())"
            detailTitleLabel.text = "\(currentStation.getStationCountry())"
            changeFavorite()
            
            
            
        }
            // 없다면
        else{
            print("최근 재생한 스테이션이 없습니다.")
        }
        
    }

    // favourite button을 할수있게 버튼을 생성
    @IBAction func clickFavButton(_ sender: UIButton) {
        
        let stationInfo: StationInfo = StationInfo()
        
        if isPlay {
            if (ViewController.favManager.isFavorite(id: currentStation.getStationId())){
                ViewController.favManager.delFavorite(id: currentStation.getStationId())
                ViewController.favManager.load()
                print("del Favorite : \(ViewController.favManager.favStationArr?.count)")
                // 알림창을 띄우기 위해 추가된 코드
                alertDeletingFavorite(station: currentStation)
            }
            else {
                stationInfo.stationData = self.currentStation.getStationName()
                stationInfo.favoriteID = self.currentStation.getStationId()
                stationInfo.stationCountry = self.currentStation.getStationCountry()
                if ViewController.favManager.addFavorite(id: currentStation.getStationId()){
                    ViewController.favManager.load()
                    print("Add Sucess : \(ViewController.favManager.favStationArr?.count)")
                    // 알림창을 띄우기 위해 추가된 코드
                    alertAddingFavorite(station: currentStation)
                }
                else {
                    print("Fail Add")
                }
            }
            changeFavorite()
        }
        
    }
    
    
    
    
    //###################################################
    // 라디오 컨트롤 연결 끝
    //###################################################
    
    
    
    
    //###################################################
    // MARK: - 하단 플레이 테이블 뷰 세팅
    //###################################################
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BottomPlayViewCell = tableView.dequeueReusableCell(withIdentifier: "bottomPlayCell", for: indexPath) as! BottomPlayViewCell
        
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        //만약 현재 플레이 중이라면
        if isPlay{
            
            //Bottom 셀의 hidden 을 해제하고 현재 재생중인 스테이션 제목을 보여준다.
            cell.bottomStationLabel.text = currentStation.getStationName()
            cell.bottomPlayButton.setImage(#imageLiteral(resourceName: "newPauseSmall"), for: .normal)
            cell.isHidden = false
            
            return cell
        }else {
            
            // 아니라면 그냥 놔두고 아이콘만 변경
            cell.isHidden = true
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "ShowBottomPlayerViewController", sender: self)
        }
        
    }
    

    
    //###################################################
    // 하단 라디오 박스 파트 끝
    //###################################################
    
    
}

