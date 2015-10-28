var express = require('express');
var router = express.Router();
var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();
var fs = require('fs');
var path = require('path');
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/example/1', function(req, res, next) {
    res.json(getPack([{ method: 'GET1' }, {method: 'GET2'},  {method: 'GET3'},  {method: 'GET4'}]))
});

router.get('/example/2', function(req, res, next) {
	res.json(postPack({method :'GET'}))
});

router.post('/example/1', function(req, res, next) {
    console.log(req.body);
    res.json(postPack({method: 'POST'}));
});

router.post('/example/2', function (req, res, next) {
	console.log(req.body);
	res.json(getPack([{method : 'POST'}]));
})

router.post('/upload', multipartMiddleware, function(req, res) {
    console.log(req.body, req.files);
    for(var key in req.files) {
        var file = req.files[key];
        var newPath = "./" + Math.round(new Date().getTime()) + file.originalFilename;
        console.log(newPath);
        fs.rename(file.path, newPath);
    }
    res.json(postPack({method: 'multipart'}));
    // don't forget to delete all req.files when done
});

router.put('/example', function(req, res, next) {
    console.log(req.body);
    res.json(postPack({method: 'PUT'}));
})

router.delete('/example', function(req, res, next){
    res.json(getPack([{method: 'DELETE'}]));
})

function getPack(data) {
	var a = new Array();
	for (var index in data) {
		a[index] = {
			id : "/example/" + index,
			model:data[index]
		}
	}
    return {
        version:"1.0",
        encoding:"UTF-8",
        errorCode:"200",
        errorMsg: "100000",
		feed: {
			id: "/example",
            entities: a
        }
    }
}

function postPack(data) {
    return {
        version:"1.0",
        encoding:"UTF-8",
        errorCode:"200",
        errorMsg: "OK",
		entity: {
			id:"/example",
			model:data
		}
    }
}

module.exports = router;
