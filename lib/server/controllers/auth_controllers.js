import bcrypt from 'bcryptjs'
import crypto from 'crypto'
import { User } from "../model/user_models.js";

export const signup= async (req,res)=>{
    try {
        const {name,mobile_number,email,password}=req.body;
        console.log('Request body:', req.body);
        if(!name || !mobile_number || !email || !password)
        {
            throw new Error('All fields are required')
        }
        const userExist=await User.findOne({email});
        if (userExist)
        {
            return res.status(409).json({success:false,message:"User already exist"})
        }

        const hashedPassword= await bcrypt.hash(password,10);
        const verificationToken=Math.floor(10000+Math.random()*90000).toString();
        const user=new User({
            name,
            mobile_number,
            email,
            password:hashedPassword,
            verificationToken,
            verificationTokenExpiresAt:Date.now()+24*60*60*1000
        })

        await user.save();
        return res.status(201).json({success:true,message:"User created"})

    } catch (error) {
        return res.status(400).json({success:false,message:error.message})
    }
}
export const login=(req,res)=>{
    res.send("login api calls")
}
export const logout=(req,res)=>{
    res.send("logout api calls")
}