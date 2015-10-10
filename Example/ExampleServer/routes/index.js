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

router.get('/example', function(req, res, next) {
    res.json(getPack([{ method: 'GET' }]))
});

router.post('/example', function(req, res, next) {
    console.log(req.body);
    res.json(postPack({method: 'POST'}));
});

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
    return {
        version:"1.0",
        encoding:"UTF-8",
        errorCode:"200",
        errorMsg: "OK",
        feed: {
            entities: data
        }
    }
}

function postPack(data) {
    return {
        version:"1.0",
        encoding:"UTF-8",
        errorCode:"200",
        errorMsg: "OK",
        entity: data
    }
}

module.exports = router;
