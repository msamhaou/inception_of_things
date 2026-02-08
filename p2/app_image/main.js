
import {createServer} from 'node:http'
import process from 'node:process';
import os from 'node:os';
const server = createServer((req,res) => {
    const appName = process.env.APP_NAME
    if (!appName){
        throw new Error("app name undfined")
    }
    const hostname = os.hostname
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end(`<h1>Hello from ${appName} <\h1>\n
    <div>pod: ${hostname}<\div>\n`)
})

const port = process.env.APP_NAME

server.listen(port, '127.0.0.1', ()=> {
    console.log(`Server started listening on port:${port}`)
})