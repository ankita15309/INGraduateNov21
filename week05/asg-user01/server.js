const express= require('express');
const server=express();
const port=3000;
const cors = require('cors');
const cors_option={origin:"https://localhost:4200",optionSucessStatus:200};
server.use(express.json());
server.use(express.urlencoded({extended:true}));
server.use(cors(cors_option));
const USER=[{ 
    id:1,userName:"ankia"},
    {
        id:2, userName:"abc"}
    ]
    server.get('/',(req,resp)=>{
     resp.send("express is work");
    })
    server.get('/user',(req,resp)=>{
         resp.setHeader("contain-type","application/json");
         resp.send(USER);
        })
    server.listen(port,()=>{
     console.log("http://localhost:3000");
        })

