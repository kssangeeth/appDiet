import bcrypt from 'bcryptjs';
import crypto from 'crypto';
import { User } from "../model/user_models.js";

export const signup = async (req, res) => {
    try {
        const { name, mobile_number, email, password } = req.body;
        console.log('Request body:', req.body);
        if (!name || !mobile_number || !email || !password) {
            throw new Error('All fields are required');
        }
        const userExist = await User.findOne({ email });
        if (userExist) {
            return res.status(409).json({ success: false, message: "User already exists" });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const verificationToken = Math.floor(10000 + Math.random() * 90000).toString();
        const user = new User({
            name,
            mobile_number,
            email,
            password: hashedPassword,
            verificationToken,
            verificationTokenExpiresAt: Date.now() + 24 * 60 * 60 * 1000
        });

        await user.save();
        return res.status(201).json({ success: true, message: "User created" });

    } catch (error) {
        return res.status(400).json({ success: false, message: error.message });
    }
};

export const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        
        if (!email || !password) {
            return res.status(400).json({ 
                success: false, 
                message: "Email and password are required" 
            });
        }
        
        // Find the user by email
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(401).json({ 
                success: false, 
                message: "Invalid email or password" 
            });
        }
        
        // Verify password
        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            return res.status(401).json({ 
                success: false, 
                message: "Invalid email or password" 
            });
        }
        
        // If verification token is still pending, remind user to verify
        /* if (user.verificationToken && !user.isVerified) {
            return res.status(403).json({
                success: false,
                message: "Please verify your account first"
            });
        }*/
        
        // Create a session token
        const token = crypto.randomBytes(32).toString('hex');
        
        // Update user with token
        user.authToken = token;
        await user.save();
        
        return res.status(200).json({
            success: true,
            message: "Login successful",
            token: token,
            userData: {
                id: user._id,
                name: user.name,
                email: user.email,
                mobile: user.mobile_number,
                isVerified: user.isVerified
            }
        });
        
    } catch (error) {
        return res.status(500).json({ success: false, message: error.message });
    }
};

export const logout = (req, res) => {
    res.send("logout api calls");
};


