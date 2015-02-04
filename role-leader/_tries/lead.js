var http = require('http');
http.createServer(function(req, res)
{
    if (req.method == 'POST') {
        var body = '';
        req.on('data', function (data) {
            body += data;
        });
        req.on('end', function () {
            //ironium.queueJob("to-build", {"test":"this"});
        });
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end('{"success"}'+"\n");
    }
    else
    {
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Nothing to see here, move along.');
    }

}).listen(80, '0.0.0.0');