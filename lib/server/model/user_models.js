import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    mobile_number: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    isVerified: {
        type: Boolean,
        default: false
    },
    verificationToken: String,
    verificationTokenExpiresAt: Date,
    authToken: String,  // Added this field for authentication
    resetPasswordToken: String,
    resetPasswordExpires: Date,
}, { timestamps: true });

export const User = mongoose.model("User", userSchema);