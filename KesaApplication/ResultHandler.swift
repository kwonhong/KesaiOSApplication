import Foundation

/**
 A handler for asynchronous calls. It is used to specify onSuccess or/and
 onError callbacks for asynchronous calls.
 
 @author hongil
 */
public class ResultHandler {
    var onSuccessCallback: OnSuccessCallback?
    var onErrorCallback: OnErrorCallback?
    
    public typealias OnSuccessCallback = () -> Void
    public typealias OnErrorCallback = (NSError?) -> Void
}