From: Tim Schumacher <timschumi@gmx.de>
Subject: [PATCH] Input: iforce - Add the Saitek R440 Force Wheel
Date: Wed, 14 Nov 2018 10:52:40 +0100
Message-ID: <20181114095240.25967-1-timschumi@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, dmitry.torokhov@gmail.com, timschumi@gmx.de
List-Id: linux-input@vger.kernel.org

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---
Please note that I do NOT own this device.

I'm adding this based on the fact that this is an iforce-based
device and that the Windows driver for the R440 works for the
Logitech WingMan Formula Force after replacing the device/vendor
IDs (I got the vendor/device IDs from there as well).

Please don't add this patch if adding devices based on that is
not ok.

Also (not related to this patch specifically), does anyone know
what the question marks at the end of some device definitions
are supposed to mean?
---
 drivers/input/joystick/iforce/iforce-main.c | 1 +
 drivers/input/joystick/iforce/iforce-usb.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 58d5cfe46526..432deecaeff9 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -67,6 +67,7 @@ static struct iforce_device iforce_device[] = {
 	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
+	{ 0x06a3, 0xff04, "Saitek R440 Force Wheel",			btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0001, "Guillemot Jet Leader Force Feedback",	btn_joystick, abs_joystick_rudder, ff_iforce },
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 78073259c9a1..cdea61ae838d 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -214,6 +214,7 @@ static const struct usb_device_id iforce_usb_ids[] = {
 	{ USB_DEVICE(0x05ef, 0x8888) },		/* AVB Top Shot FFB Racing Wheel */
 	{ USB_DEVICE(0x061c, 0xc0a4) },         /* ACT LABS Force RS */
 	{ USB_DEVICE(0x061c, 0xc084) },         /* ACT LABS Force RS */
+	{ USB_DEVICE(0x06a3, 0xff04) },		/* Saitek R440 Force Wheel */
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0003) },		/* Guillemot Jet Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
-- 
2.19.1.450.ga4b8ab536
