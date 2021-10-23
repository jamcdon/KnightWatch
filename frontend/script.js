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
		]
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
	}
});