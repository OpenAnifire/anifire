package com.jumpeye.flashEff2.text.slowSlide
{
   import com.jumpeye.Events.FLASHEFFEvents;
   import com.jumpeye.core.JUIComponent;
   import com.jumpeye.flashEff2.core.interfaces.IFlashEffText;
   import com.jumpeye.flashEff2.text.patternsPresets.JFETPreset;
   import com.jumpeye.transitions.TweenLite;
   
   public class FETSlowSlide extends IFlashEffText
   {
       
      
      private var newDelay:Number;
      
      private var _alphaPercentage:Number = 100;
      
      private var _blurQuality:Number = 2;
      
      private var prop:Number = 0;
      
      private var _offsetX:Number = 70;
      
      private var _offsetY:Number = 30;
      
      private var finalxposition;
      
      private var finalyposition:Number;
      
      protected var owner:Object;
      
      private var _groupDuration:Number = 1;
      
      private var _preset:Number = 2;
      
      public function FETSlowSlide(param1:JUIComponent = null)
      {
         super();
         this.component = param1;
         this.init();
      }
      
      public function get groupDuration() : Number
      {
         return this._groupDuration;
      }
      
      override public function remove() : void
      {
         this.clearProperties();
      }
      
      public function set preset(param1:Number) : void
      {
         this._preset = param1;
      }
      
      public function set groupDuration(param1:Number) : void
      {
         if(param1 < 0.001)
         {
            param1 = 0.001;
         }
         this._groupDuration = Number(param1) || 1;
      }
      
      override public function hide() : void
      {
         if(this.component != null)
         {
            this.startTransition(false);
         }
      }
      
      public function set offsetX(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 50;
         }
         this._offsetX = param1;
      }
      
      protected function motionFinished(param1:*, param2:*) : void
      {
         param1.clip.filters = [];
         if(owner.show == false)
         {
            param1.clip.visible = false;
         }
         ++owner.tweensFinished;
         if(owner.tweensNumber == owner.tweensFinished)
         {
            this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_END));
         }
      }
      
      protected function init() : void
      {
         _tweenDuration = 1.3;
         _tweenType = "Strong";
         _easeType = "easeOut";
         this.owner = {};
      }
      
      public function set offsetY(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 50;
         }
         this._offsetY = param1;
      }
      
      protected function startTransition(param1:Boolean = true) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:* = undefined;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Object = null;
         var _loc8_:Object = JFETPreset.getAliasPreset(this.preset);
         this.component.drawTextTable(_loc8_.splitter,this.partialGroup,this.partialPercent,this.selectedStrings,this.partialStart,this.partialBlurAmount);
         _loc2_ = this.component.absMatrix;
         _loc4_ = (_loc5_ = JFETPreset.getPresetsArray(_loc8_.preset,_loc2_)).timeMatrix;
         owner.maxItems = _loc5_.maxItems;
         owner.tweensFinished = 0;
         _loc3_ = _loc2_.length;
         var _loc9_:uint = 0;
         var _loc10_:uint = 1;
         owner.timeDirection = 0;
         owner.show = param1;
         if(param1 == true)
         {
            _loc9_ = 1;
            _loc10_ = 0;
            owner.timeDirection = 1;
         }
         owner.tweensNumber = this.component.textTable.childs.length;
         if(owner.maxItems <= 1)
         {
            owner.delay = 0;
         }
         else
         {
            owner.delay = Math.max((this.tweenDuration - this.groupDuration) / (owner.maxItems - 1),0);
         }
         owner.elements = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc11_ = uint(_loc2_[_loc6_].length);
            owner.elements[_loc6_] = [];
            _loc7_ = 0;
            while(_loc7_ < _loc11_)
            {
               (_loc12_ = owner.elements[_loc6_][_loc7_] = {}).clip = _loc2_[_loc6_][_loc7_];
               _loc12_.clip.alpha = Math.abs(1 - _loc9_);
               _loc12_.startx = _loc12_.clip.x;
               _loc12_.starty = _loc12_.clip.y;
               _loc12_.finalx = _loc12_.clip.x + _offsetX;
               _loc12_.finaly = _loc12_.clip.y + _offsetY;
               checkTransitionType(param1,_loc12_);
               TweenLite.to(_loc12_.clip,this._groupDuration,{
                  "x":Number(finalxposition),
                  "y":finalyposition,
                  "delay":_loc4_[_loc6_][_loc7_] * owner.delay,
                  "ease":this.easeFunc
               });
               TweenLite.to(_loc12_.clip,_alphaPercentage * this._groupDuration / 100,{
                  "alpha":Number(param1),
                  "delay":_loc4_[_loc6_][_loc7_] * owner.delay + newDelay,
                  "overwrite":false,
                  "onComplete":motionFinished,
                  "onCompleteParams":[_loc12_,_loc12_.clip]
               });
               _loc7_++;
            }
            _loc6_++;
         }
         this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_START));
      }
      
      public function get alphaPercentage() : Number
      {
         return this._alphaPercentage;
      }
      
      private function checkTransitionType(param1:Boolean, param2:Object) : *
      {
         prop = Number(param1);
         if(param1 == false)
         {
            param2.pos = 1;
            finalxposition = param2.finalx;
            finalyposition = param2.finaly;
            newDelay = this._groupDuration - _alphaPercentage * this._groupDuration / 100;
         }
         else
         {
            param2.pos = 0;
            finalxposition = param2.startx;
            finalyposition = param2.starty;
            newDelay = 0;
            param2.clip.x = param2.finalx;
            param2.clip.y = param2.finaly;
         }
      }
      
      public function get offsetX() : Number
      {
         return this._offsetX;
      }
      
      public function get preset() : Number
      {
         return this._preset;
      }
      
      protected function clearProperties() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         if(owner is Object)
         {
            if(owner.elements is Array)
            {
               _loc1_ = owner.absMatrix;
               _loc2_ = uint(owner.elements.length);
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc5_ = uint(owner.elements[_loc3_].length);
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_)
                  {
                     (_loc6_ = owner.elements[_loc3_][_loc4_]).clip.filter = [];
                     TweenLite.killTweensOf(_loc6_,false);
                     TweenLite.killTweensOf(_loc6_.clip,false);
                     _loc4_++;
                  }
                  _loc3_++;
               }
            }
         }
         delete owner.elements;
      }
      
      public function set alphaPercentage(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 100;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 100)
         {
            param1 = 100;
         }
         this._alphaPercentage = param1;
      }
      
      public function get offsetY() : Number
      {
         return this._offsetY;
      }
      
      public function set blurQuality(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._blurQuality = Number(param1) || 1;
      }
      
      public function get blurQuality() : Number
      {
         return this._blurQuality;
      }
      
      override public function show() : void
      {
         if(this.component != null)
         {
            this.startTransition(true);
         }
      }
   }
}
