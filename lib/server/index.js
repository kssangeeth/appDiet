//const express=require('express') ///commonjs
import express from 'express' ///for type:module
import dotenv from 'dotenv'
import { connectDb } from "./DB/connectDB.js"
import authRoutes from './routes/auth_routes.js'

dotenv.config()
const app=express()

app.use(express.json())

app.use('/api/auth',authRoutes)



app.listen(3000,()=>{
    connectDb()
    console.log("App is running")
})


//sangeeth7109
//Ntl6FXsoQXYYoZqK
