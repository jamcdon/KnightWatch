var app = new Vue({
	el:"#app",
	data:{
		count:0,
		currentSort: "",
		sort:[
			"Number",
			"Name",
			"Base",
			"Score",
			"Game Average"
		],
		players:[
			/*{
				id:0,
				name:"Levar Burton",
				number:08,
				score:58,
				baseline:40,
				aggregate:67,
				class:""
			}*/
		],
		playersTemp:[]
	},
	watch:{
		count: function(){
			function setColor(id, baseline, score){
			let colorDict = {
				0:"",
				1:"table-warning",
				2:"table-danger"
			};
			let color = app._data.players[id].class;
			let colorNum = null;
			let diff = app._data.players[id].score - app._data.players[id].baseline;
			if(diff < 10){
				colorNum = 0;
			}
			else if(diff < 20 && diff >= 10){
				colorNum = 1;
			}
			else{
				colorNum = 2;
			}
			
			if(colorDict[colorNum] != color){
				app._data.players[id].class = colorDict[colorNum]
			};
		}
		for(let i = 0; i < app._data.players.length; i++){
		setColor(i, app._data.players[i].baseline, app._data.players[i].score)
	}
		}
	},
	
});

var xhr = new XMLHttpRequest();
		xhr.open('GET','45.33.12.201/get');
		xhr.onload = function(){
			if (xhr.status === 200){
				imported = JSON.parse(xhr.responseText);
				for(i = 0; i < imported.length; i++){
					app._data.playersTemp.push(imported[i]);
				}
				app._data.players = app.data.playersTemp;
			}
			else{
				console.log(xhr.status)
			}
		}