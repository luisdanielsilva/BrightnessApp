import Foundation
import CoreGraphics

public struct BrightnessManager {
    static func setBrightness(level: Float) {
        // Nos chips Apple Silicon mais recentes, o motor que controla o brilho é outro,
        // o DisplayServices. A função DisplayServicesSetBrightness é a que gere tudo isto!
        
        let path = "/System/Library/PrivateFrameworks/DisplayServices.framework/DisplayServices"
        guard let handle = dlopen(path, RTLD_NOW) else { return }
        
        guard let pointer = dlsym(handle, "DisplayServicesSetBrightness") else { return }
        
        typealias SetBrightnessFunc = @convention(c) (CGDirectDisplayID, Float) -> Int32
        let setBrightness = unsafeBitCast(pointer, to: SetBrightnessFunc.self)
        
        let displayID = CGMainDisplayID()
        _ = setBrightness(displayID, level)
    }
}
