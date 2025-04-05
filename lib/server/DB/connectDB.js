import mongoose from 'mongoose'
export const connectDb=()=>{
    try {
        const conn=mongoose.connect(process.env.MONGOOSE_URL)
        console.log("MongoDB connected")
    } catch (error) {
        console.log("Error during connection");
        process.exit(1)
    }
}