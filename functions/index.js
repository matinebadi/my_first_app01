const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

// ⚡️ تنظیمات Gmail SMTP
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "your_email@gmail.com",
    pass: "your_gmail_app_password"
  }
  
});

// ✅ تابع ارسال OTP مناسب Flutter
exports.sendOtpEmail = functions.https.onCall(async (data, context) => {
  const { email, otp } = data;

  if (!email || !otp) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "ایمیل یا OTP دریافت نشد"
    );
  }

  const mailOptions = {
    from: "matinebadi27@gmail.com",
    to: email,
    subject: "کد تأیید ثبت‌نام شما ✅",
    text: `سلام 👋\n\nکد تأیید شما: ${otp}\n\nاین کد تا ۵ دقیقه معتبر است.`,
  };

  try {
    await transporter.sendMail(mailOptions);
    return { success: true, message: "ایمیل OTP ارسال شد 📩" };
  } catch (error) {
    console.error("خطا در ارسال ایمیل:", error);
    throw new functions.https.HttpsError(
      "internal",
      "خطا در ارسال ایمیل: " + error.message
    );
  }
});
