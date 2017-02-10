
import UIKit
import MediaPlayer
import MobileCoreServices

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stationName: UILabel!
    let radioPlayer = MPMoviePlayerController()
    
    var currentStation: StationData!
    
    var playing: Bool = false
    
    override func viewDidLoad() {
        setupPlayer()
    }
    
    func setupPlayer() {
        radioPlayer.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        radioPlayer.view.sizeToFit()
        radioPlayer.movieSourceType = MPMovieSourceType.streaming
        radioPlayer.isFullscreen = false
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.none
        
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
        radioPlayer.play()
        playing = true;
        
    }
    
    @IBAction func clickPause(){
        if playing {
            radioPlayer.pause()
            playing = false
        }
    }
    
    @IBAction func clickPlay(){
        if !playing{
            radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
            radioPlayer.prepareToPlay()
            radioPlayer.play()
            playing = true
        }
        
    }
    
    //TODO: 꺼져도 계속 인풋을 받음 - 해결해야함
    override func viewWillDisappear(_ animated: Bool) {
        if playing{
            radioPlayer.stop()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if playing{
            radioPlayer.stop()
        }
    }
    
    
}
