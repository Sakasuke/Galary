
onload=function(){
	document.onmousemove = 
		 OnTargetDivMouseMove;

	/*var bg = document.getElementById("backgroundDiv");
	fishPos.x = ToNumber(bg.style.left)  + ToNumber(bg.style.width) /2  ;
	fishPos.y = ToNumber(bg.style.top )  + ToNumber(bg.style.height) /2;*/
	

	OnFishMove();
}

function Vector2() {
	this.x = 0.0;
	this.y = 0.0;
	this.Add = function(v) {
		this.x += v.x;
		this.y += v.y;
		return this;
	};
	this.Subtract = function(v) {
		this.x -= v.x;
		this.y -= v.y;
		return this;
	};
	this.Multi = function(k) {
		this.x *= k;
		this.y *= k;
		return this;
	};
	this.ToZero=function(){
		this.x = 0;
		this.y = 0;
		return this;
	};
	this.Set=function(x,y) {
		this.x = x;
		this.y = y;
		return this;
	}
	this.Copy=function(v){
		this.x = v.x;
		this.y = v.y;
		return this;
	}
}

var K = 13.0;
var dt = 1.0 / 20.0;
var M = 3.0;
var Eta = 2*Math.sqrt(M*K);
var fishAcceleration = new Vector2();
var fishVerosity = new Vector2();
var fishPos = new Vector2();
var mousePos = new Vector2();

function OnTargetDivMouseMove(e) {
	if(!e) return;

	mousePos.x = e.clientX;
	mousePos.y = e.clientY;
}

function ToNumber(stylePxStr) {
	return Math.floor(stylePxStr.substr( 0 , stylePxStr.length - 2 ) );
}

function OnFishMove() {
	fishAcceleration.ToZero();
	fishAcceleration.Add(
		new Vector2()
		.Copy(mousePos)
		.Subtract(fishPos)
		.Multi(K)
		.Subtract( 
			new Vector2()
			.Copy(fishVerosity)
			.Multi(Eta)
		)
		.Multi(M)
	);
	fishVerosity.Add(
		new Vector2()
		.Copy(fishAcceleration)
		.Multi(dt)
	);
	
	//var bg = document.getElementById("backgroundDiv");
	var fishDiv = document.getElementById("targetDiv");

	fishPos.Add(
		new Vector2()
		.Copy(fishVerosity)
		.Multi(dt)
	);
	

	fishDiv.style.left = Math.floor(fishPos.x) + "px";		
	fishDiv.style.top = Math.floor(fishPos.y) + "px";

	
	
	setTimeout("OnFishMove()",dt * 1000.0 );
}