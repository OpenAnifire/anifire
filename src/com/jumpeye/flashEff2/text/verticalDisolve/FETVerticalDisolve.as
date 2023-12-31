package com.jumpeye.flashEff2.text.verticalDisolve
{
   import com.jumpeye.Events.FLASHEFFEvents;
   import com.jumpeye.core.JUIComponent;
   import com.jumpeye.flashEff2.core.interfaces.IFlashEffText;
   import com.jumpeye.flashEff2.text.patternsPresets.JFERandomPreset;
   import com.jumpeye.transitions.TweenLite;
   import com.jumpeye.utils.JTimer;
   import fl.transitions.*;
   import fl.transitions.easing.*;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   
   public class FETVerticalDisolve extends IFlashEffText
   {
       
      
      private var isFin:Boolean;
      
      private var _preset:Number;
      
      private var _maxVerticalSpace:Number = 50;
      
      private var presetObject:Object;
      
      private var lin:uint;
      
      private var objMatrix:Array;
      
      private var _groupSize:Number = 7;
      
      private var finalDuration:Number;
      
      private var _maxBlurY:Number = 20;
      
      protected var owner:Object;
      
      private var _groupDuration:Number = 1;
      
      private var bol:Boolean;
      
      private var newDelay:Number;
      
      private var _translateDurationPercent:Number = 70;
      
      private var percLet = 0.5;
      
      private var _glowColor:Number = 16777215;
      
      private var _blurQuality:Number = 2;
      
      private var chars;
      
      private var _alphaPercentage:Number = 100;
      
      private var prop:Number = 0;
      
      private var _glowAmount:Number = 5;
      
      private var i;
      
      private var j:uint;
      
      private var timeMatrix:Array;
      
      private var lettersChanges = 20;
      
      private var tweensFinished:Number = 0;
      
      public function FETVerticalDisolve(param1:JUIComponent = null)
      {
         chars = ["A","a","B","b","C","c","D","d","E","e","F","f","G","g","H","h","I","i","J","j","K","k","L","l","M","m","N","n","O","o","P","p","Q","q","R","r","S","s","T","t","U","u","V","v","W","w","X","x","Y","y","Z","z"];
         super();
         this.component = param1;
         this.init();
      }
      
      protected function setPositionTween(param1:*, param2:*) : *
      {
         var _loc3_:* = bol == true ? 0 : 1;
         var _loc4_:* = bol == true ? 1 : 0;
         var _loc5_:* = bol == true ? param1.clip.trueY : param1.clip.y - randRange(-maxVerticalSpace,maxVerticalSpace);
         param1.clip.alpha = _loc3_;
         var _loc6_:* = param1.clip.y;
         TweenLite.to(param1.clip,owner.duration * translateDurationPercent / 100,{
            "alpha":_loc4_,
            "y":_loc5_,
            "delay":param2,
            "ease":this.easeFunc,
            "onUpdate":hdlYChange,
            "onUpdateParams":[param1,param1.clip,_loc5_,_loc6_]
         });
      }
      
      protected function hdlYChange(param1:*, param2:*, param3:*, param4:*) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc5_:* = param1.clip;
         var _loc6_:*;
         if(_loc6_ = bol == true ? param1.clip.y < param3 * percLet : param1.clip.y > Math.abs(param3 - param4) * (1 - percLet))
         {
            _loc7_ = Math.round(Math.random() * (chars.length - 1));
            _loc8_ = chars[_loc7_];
            _loc5_.textField.text = _loc8_;
            _loc5_.textField.setTextFormat(_loc5_.txtForm);
         }
         else if(_loc5_.isSetNormal == undefined)
         {
            stopChangingLetters(_loc5_);
         }
      }
      
      public function set glowAmount(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 5;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 100)
         {
            param1 = 100;
         }
         this._glowAmount = Number(param1) || 5;
      }
      
      protected function hdlChangeGlow(param1:*) : *
      {
         var _loc2_:* = param1.prop;
         var _loc3_:* = param1;
         var _loc4_:*;
         var _loc5_:* = (_loc4_ = param1.clip).filters;
         var _loc6_:* = getGlow(_loc2_);
         _loc4_.filters = isFin ? [] : [_loc6_];
      }
      
      protected function init() : void
      {
         this.scaleX = 0;
         this.scaleY = 0;
         this.visible = false;
         this.owner = {};
      }
      
      protected function setGlowTweenOut(param1:*, param2:*) : *
      {
         var _loc3_:* = {};
         _loc3_.clip = param1.clip;
         var _loc4_:* = bol == true ? glowAmount : 0;
         var _loc5_:* = bol == true ? 0 : glowAmount;
         var _loc6_:Number = owner.duration * (1 - translateDurationPercent / 100);
         _loc3_.prop = _loc4_;
         if(bol == true)
         {
            TweenLite.to(_loc3_,owner.duration * (1 - translateDurationPercent / 100),{
               "prop":_loc5_,
               "delay":param2,
               "overwrite":false,
               "onComplete":hdlFinishGlow,
               "onUpdate":hdlChangeGlow,
               "onUpdateParams":[_loc3_],
               "onCompleteParams":[_loc3_]
            });
         }
         else
         {
            TweenLite.to(_loc3_,owner.duration * (1 - translateDurationPercent / 100),{
               "prop":_loc5_,
               "delay":param2,
               "overwrite":false,
               "onUpdate":hdlChangeGlow,
               "onUpdateParams":[_loc3_]
            });
         }
      }
      
      override public function remove() : void
      {
         this.clearProperties();
      }
      
      protected function stTween(param1:TimerEvent) : *
      {
         param1.target.stop();
         var _loc2_:* = param1.target.data;
         _loc2_.clip.finText = _loc2_.clip.textField.text;
         _loc2_.clip.txtForm = _loc2_.clip.textField.getTextFormat();
         var _loc3_:* = bol == true ? 0 : owner.duration * (1 - translateDurationPercent / 100) * 1000;
         var _loc4_:* = bol == true ? owner.duration * translateDurationPercent / 100 * 1000 : 0;
         setGlowTweenIn(_loc2_,_loc3_ / 1000);
         setPositionTween(_loc2_,_loc3_ / 1000);
         setGlowTweenOut(_loc2_,_loc4_ / 1000);
      }
      
      protected function getGlow(param1:*) : BitmapFilter
      {
         var _loc2_:Number = this.glowColor;
         var _loc3_:Number = 1;
         var _loc4_:Number = param1;
         var _loc5_:Number = param1;
         var _loc6_:Number = param1 / 2;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Number = BitmapFilterQuality.HIGH;
         return new GlowFilter(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc9_,_loc7_,_loc8_);
      }
      
      public function get alphaPercentage() : Number
      {
         return this._alphaPercentage;
      }
      
      public function get groupSize() : Number
      {
         return this._groupSize;
      }
      
      protected function randRange(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      protected function stopChangingLetters(param1:*) : *
      {
         param1.textField.text = param1.finText;
         param1.textField.setTextFormat(param1.txtForm);
         param1.isSetNormal = true;
      }
      
      public function get maxVerticalSpace() : Number
      {
         return this._maxVerticalSpace;
      }
      
      protected function setText(param1:*) : *
      {
         var _loc2_:* = Math.round(Math.random() * (chars.length - 1));
         var _loc3_:* = chars[_loc2_];
         param1.textField.text = _loc3_;
         param1.textField.setTextFormat(param1.txtForm);
         ++param1.noChanges;
         if(param1.noChanges >= lettersChanges / 2)
         {
            stopChangingLetters(param1);
         }
      }
      
      protected function countTransitions(param1:*) : *
      {
         param1.clip.filters = [];
         if(tweensFinished == owner.tweensNumber - 1)
         {
            isFin = true;
            clearProperties();
            this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_END));
         }
         ++tweensFinished;
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
      
      public function set glowColor(param1:Number) : void
      {
         this._glowColor = Number(param1);
      }
      
      public function set preset(param1:Number) : void
      {
         this._preset = param1;
      }
      
      public function set groupSize(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 7;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 100)
         {
            param1 = 100;
         }
         this._groupSize = Number(param1) || 5;
      }
      
      public function get glowAmount() : Number
      {
         return this._glowAmount;
      }
      
      public function get groupDuration() : Number
      {
         return this._groupDuration;
      }
      
      public function set translateDurationPercent(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 70;
         }
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 > 99)
         {
            param1 = 99;
         }
         this._translateDurationPercent = Number(param1) || 70;
      }
      
      protected function hdlFinishGlow(param1:*) : *
      {
         countTransitions(param1);
      }
      
      override public function hide() : void
      {
         if(this.component != null)
         {
            this.startTransition(false);
         }
      }
      
      public function get glowColor() : Number
      {
         return this._glowColor;
      }
      
      public function set maxVerticalSpace(param1:Number) : void
      {
         if(isNaN(Number(param1)))
         {
            param1 = 100;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 500)
         {
            param1 = 500;
         }
         this._maxVerticalSpace = Number(param1) || 100;
      }
      
      protected function startTransition(param1:Boolean = true) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         this.clearProperties();
         isFin = false;
         bol = param1;
         tweensFinished = 0;
         this.component.drawTextTable("chars",this.partialGroup,this.partialPercent,this.selectedStrings,this.partialStart,this.partialBlurAmount);
         objMatrix = this.component.absMatrix;
         presetObject = JFERandomPreset.getPresetsArray(1,objMatrix,groupSize);
         timeMatrix = presetObject.timeMatrix;
         lin = objMatrix.length;
         owner.elements = [];
         owner.maxItems = presetObject.maxItems;
         owner.tweensNumber = owner.maxItems > 1 ? objMatrix[0][0].parent.childs.length : 0;
         owner.delay = (tweenDuration - groupDuration) / (owner.maxItems / groupSize - 1);
         owner.delay = owner.delay < 0 ? 0 : owner.delay;
         owner.duration = groupDuration;
         var _loc2_:* = this.component.targetOwner.getBounds(this.component.targetOwner);
         owner.initX = _loc2_.y + _loc2_.width / 2;
         owner.elements = [];
         i = 0;
         while(i < lin)
         {
            _loc3_ = uint(objMatrix[i].length);
            owner.elements[i] = [];
            j = 0;
            while(j < _loc3_)
            {
               (_loc4_ = owner.elements[i][j] = {}).clip = objMatrix[i][j];
               _loc4_.clip.alpha = bol == true ? 0 : 1;
               _loc4_.tex = _loc4_.clip.textField.text;
               _loc4_.clip.trueY = _loc4_.clip.y;
               _loc5_ = bol == true ? _loc4_.clip.y - randRange(-maxVerticalSpace,maxVerticalSpace) : _loc4_.clip.y;
               _loc4_.clip.y = _loc5_;
               _loc6_ = timeMatrix[i][j] * owner.delay * 1000;
               _loc6_ = isNaN(_loc6_) ? 0 : _loc6_;
               owner["myTimer" + i + "_" + j] = new JTimer(_loc6_);
               owner["myTimer" + i + "_" + j].data = _loc4_;
               owner["myTimer" + i + "_" + j].addEventListener("timer",stTween);
               owner["myTimer" + i + "_" + j].start();
               ++j;
            }
            ++i;
         }
         this.target.visible = false;
         this.component.dispatchEvent(new FLASHEFFEvents(FLASHEFFEvents.TRANSITION_START));
      }
      
      public function get preset() : Number
      {
         return this._preset;
      }
      
      protected function setGlowTweenIn(param1:*, param2:*) : *
      {
         var _loc3_:* = {};
         _loc3_.clip = param1.clip;
         var _loc4_:* = bol == true ? 0 : glowAmount;
         var _loc5_:* = bol == true ? glowAmount : 0;
         _loc3_.prop = _loc4_;
         if(bol == false)
         {
            TweenLite.to(_loc3_,owner.duration * translateDurationPercent / 100,{
               "prop":_loc5_,
               "delay":param2,
               "onComplete":hdlFinishGlow,
               "onUpdate":hdlChangeGlow,
               "onUpdateParams":[_loc3_],
               "onCompleteParams":[_loc3_]
            });
         }
         else
         {
            TweenLite.to(_loc3_,owner.duration * translateDurationPercent / 100,{
               "prop":_loc5_,
               "delay":param2,
               "onUpdate":hdlChangeGlow,
               "onUpdateParams":[_loc3_]
            });
         }
      }
      
      private function clearProperties() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc7_:* = undefined;
         if(owner.elements)
         {
            _loc1_ = this.component.absMatrix;
            _loc2_ = uint(owner.elements.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = uint(owner.elements[_loc3_].length);
               _loc4_ = 0;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = owner.elements[_loc3_][_loc4_];
                  owner["myTimer" + _loc3_ + "_" + _loc4_].stop();
                  if(_loc6_.clip)
                  {
                     TweenLite.killTweensOf(_loc6_.clip,false);
                     _loc6_.clip.filters = [];
                     (_loc7_ = {}).clip = _loc6_.clip;
                     TweenLite.killTweensOf(_loc7_,false);
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
      }
      
      public function set groupDuration(param1:Number) : void
      {
         if(param1 < 0.001)
         {
            param1 = 0.001;
         }
         this._groupDuration = Number(param1) || 1;
      }
      
      public function get translateDurationPercent() : Number
      {
         return this._translateDurationPercent;
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
