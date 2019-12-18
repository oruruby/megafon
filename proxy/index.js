const callbackUrl = 'http://localhost:3000/megafone'
const express = require('express');
const bodyParser = require('body-parser')
const app = express();
const WebSocketClient = require('websocket').client;
const client = new WebSocketClient();
const fetch = require("node-fetch");
app.use(bodyParser.json())
client.on('connectFailed', function(error) {
  console.log('Connect Error: ' + error.toString());
});
const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6InNjMiIsImFwcGxpY2F0aW9uIjoiQSJ9.0OpoFlfcbLSb7muYmDf2HKm0BBxPTQ5lLml4KWnLM1Q'
let connection = null
client.on('connect', function(_connection) {
  connection = _connection
  console.log('Websocket Client connected')
  connection.on('error', function(error) {
    console.log("Connection Error: " + error.toString());
  })
  connection.on('close', function() {
    connection = null
    console.log('echo-protocol Connection Closed');
  });
  connection.on('message', function(message) {
  if (message.type === 'utf8') {
    console.log("Received: '" + message.utf8Data + "'");
    fetch(callbackUrl, {
      method: 'POST',
      body: JSON.stringify(message.utf8Data),
      headers: {
        'Content-Type' : 'application/json'
      }
    })
      }
  });
})
app.post('/', function (req, res) {
  res.send('Ok')
  console.log('Request params: ' + JSON.stringify(req.body))
  const request = { id: req.body.id, jsonrpc: '2.0', method: req.body.method, params: req.body.params };
  if(connection){
    console.log('Sending to megafone: ' + JSON.stringify(request))
    connection.sendUTF(JSON.stringify(request))
  }
})
app.post('/connect', function(req, res){
  res.send('Ok')
})
app.listen(5000, function () {
  console.log('Started')
});
client.connect("wss://testapi.megafon.ru/v1/api", null, null, {
  'Authorization' : 'JWT ' + token
}); 
