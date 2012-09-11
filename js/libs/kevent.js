// KEvent - A little librairy to handle multi-keyboard events
var MODIFIERS=["shift","ctrl","alt","altgr"];var ALIAS={left:[37,81,65],up:[38,90,87],right:[39,68],down:[40,83],space:[32],pageup:[33],pagedown:[34],tab:[9],escape:[27]};var KEvent=function(){var a=this;this.keyCodes=new Array(256);this.modifiers=new Array(4);this._onKeyDown=function(b){a._onKey(b,true)};this._onKeyUp=function(b){a._onKey(b,false)};document.addEventListener("keydown",this._onKeyDown,false);document.addEventListener("keyup",this._onKeyUp,false)};KEvent.prototype.destroy=function(){document.removeEventListener("keydown",this._onKeyDown,false);document.removeEventListener("keyup",this._onKeyUp,false)};KEvent.prototype._onKey=function(a,b){this.isPressed=b;this.keyCodes[a.keyCode]=b;switch(a.keyIdentifier){case"U+0000":this.modifiers["altgr"]=b;break;case"Alt":this.modifiers["alt"]=b;break;case"Control":this.modifiers["ctrl"]=b;break;case"Shift":this.modifiers["shift"]=b;break}};KEvent.prototype.pressed=function(a){var b,c,d,e;switch(typeof a){case"undefined":return this.isPressed;case"number":return this.byCode(a);case"string":b=a.split("+");break;default:throw Error("The key `"+a+"` have to be undefined, a number or a string.")}d=b.length==1?b[0]:b[1];e=b.length==1?null:b[0];if(Object.keys(ALIAS).indexOf(d)!==-1)for(i in ALIAS[d]){i=ALIAS[d][i];c=this.keyCodes[i];if(c==true)break}else c=this.keyCodes[d.toUpperCase().charCodeAt(0)];if(c==true&&e!==null&&MODIFIERS.indexOf(b[0])!==-1){c=this.modifiers[e]}return c};KEvent.prototype.byCode=function(a){return this.keyCodes[a]};KEvent.prototype.setAlias=function(a){if(arguments.length<2)return console.error("setAlias need a key and some keyCode values.");ALIAS[a]=[];for(var b=1;b<arguments.length;++b)ALIAS[a].push(arguments[b]);console.log(ALIAS[a])};KEvent.prototype.getAlias=function(a){return ALIAS[a]};KEvent.prototype.showAlias=function(){console.log(JSON.stringify(ALIAS))};if(typeof define!=="undefined"){define(function(){return KEvent})}