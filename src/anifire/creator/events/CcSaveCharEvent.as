package anifire.creator.events
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   
   public class CcSaveCharEvent extends ExtraDataEvent
   {
      
      public static const SAVE_CHAR_COMPLETE:String = "save_char_complete";
      
      public static const SAVE_CHAR_ERROR_OCCUR:String = "save_char_error_occur";
      
      public var assetId:String;
      
      public var gaTrackModel:Object = null;
      
      public function CcSaveCharEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function clone() : Event
      {
         var _loc1_:CcSaveCharEvent = new CcSaveCharEvent(this.type,this.getEventCreater(),this.getData(),this.bubbles,this.cancelable);
         _loc1_.assetId = this.assetId;
         _loc1_.gaTrackModel = this.gaTrackModel;
         return _loc1_;
      }
   }
}
