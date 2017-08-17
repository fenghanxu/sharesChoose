//
//  SpeechSynthesizer.swift
//  Demol
//
//  Created by 冯汉栩 on 2017/6/2.
//  Copyright © 2017年 hanxuFeng. All rights reserved.
//

import UIKit
import AVFoundation//系统自带的语音提示

class SpeechSynthesizer: NSObject {

      static let sharedSpeechSynthesizer: SpeechSynthesizer = SpeechSynthesizer()

      var speechSynthesizer = AVSpeechSynthesizer()

       override init(){
          super.init()
          self.buildSpeechSynthesizer()
      }

      func buildSpeechSynthesizer(){
        if UIDevice.current.systemVersion  < 7.0.string {
          return
        }
        //简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
        let session = AVAudioSession.sharedInstance()

        do{
          try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch let error as NSError {
          // 发生错误
          print(error.localizedDescription)
        }
        speechSynthesizer.delegate = self

      }
    
      func stopSpeak() {
        speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
      }
    
      func isSpeaking() ->(Bool){
        return speechSynthesizer.isSpeaking
      }

}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    
    func speakString(string: String){
        let aUtterance = AVSpeechUtterance(string: string)
        aUtterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        let system:Double = UIDevice.current.systemVersion.double ?? 0.0
        
        if system < 8.0 {
            aUtterance.rate = 0.25;//iOS7设置为0.25
        }else if(system < 9.0) {
            aUtterance.rate = 0.15;//iOS7设置为0.25
        }
        
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.word)
        }
        speechSynthesizer.speak(aUtterance)
    }

}

/*
使用：Demol名称 3D高德(实时导航)
 在AMapNaviDriveManagerDelegate的代理里面
 
 //SDK需要实时的获取是否正在进行导航信息播报
 func driveManagerIsNaviSoundPlaying(_ driveManager: AMapNaviDriveManager) -> Bool {
 return SpeechSynthesizer.sharedSpeechSynthesizer.isSpeaking()
 }
 
//导航播报信息回调函数
 func driveManager(_ driveManager: AMapNaviDriveManager, playNaviSound soundString: String, soundStringType: AMapNaviSoundType) {
 SpeechSynthesizer.sharedSpeechSynthesizer.speakString(string: soundString)
 }
 
 //停止语音
 SpeechSynthesizer.sharedSpeechSynthesizer.stopSpeak()
 
 
*/



