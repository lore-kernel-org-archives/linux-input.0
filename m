From: "johann deneux" <johann.deneux@gmail.com>
Subject: [PATCH] Added device to hid-ff
Date: Thu, 15 Feb 2007 19:56:18 +0100
Message-ID: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_93149_17867281.1171565778708"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, dmitry <dmitry.torokhov@gmail.com>
Cc: Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

------=_Part_93149_17867281.1171565778708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch (initially submitted by Valentin Zagura) adds the Logitech
Formula Force EX to the list of devices handled by hid-lgff.
Also updated the text of the Kconfig entry.

Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

--- linux-2.6.20.orig/drivers/usb/input/Kconfig    2007-02-04 19:44:
54.000000000 +0100
+++ linux-2.6.20/drivers/usb/input/Kconfig    2007-02-15 12:27:42.000000000+0100
@@ -56,17 +56,21 @@ config HID_PID
       Say Y here if you have a PID-compliant device and wish to enable
force
       feedback for it. Microsoft Sidewinder Force Feedback 2 is one of such
       devices.

 config LOGITECH_FF
-    bool "Logitech WingMan *3D support"
+    bool "Logitech devices support"
     depends on HID_FF
     select INPUT_FF_MEMLESS if USB_HID
     help
       Say Y here if you have one of these devices:
       - Logitech WingMan Cordless RumblePad
+      - Logitech WingMan Cordless RumblePad 2
       - Logitech WingMan Force 3D
+      - Logitech Formula Force EX
+      - Logitech MOMO Force wheel
+
       and if you want to enable force feedback for them.
       Note: if you say N here, this device will still be supported, but
without
       force feedback.

 config THRUSTMASTER_FF
--- linux-2.6.20.orig/drivers/usb/input/hid-ff.c    2007-02-04 19:44:
54.000000000 +0100
+++ linux-2.6.20/drivers/usb/input/hid-ff.c    2007-02-15
12:16:53.000000000+0100
@@ -53,10 +53,11 @@ struct hid_ff_initializer {
  */
 static struct hid_ff_initializer inits[] = {
 #ifdef CONFIG_LOGITECH_FF
     { 0x46d, 0xc211, hid_lgff_init }, /* Logitech Cordless rumble pad */
     { 0x46d, 0xc283, hid_lgff_init }, /* Logitech Wingman Force 3d */
+    { 0x46d, 0xc294, hid_lgff_init }, /* Logitech Formula Force EX */
     { 0x46d, 0xc295, hid_lgff_init }, /* Logitech MOMO force wheel */
     { 0x46d, 0xc219, hid_lgff_init }, /* Logitech Cordless rumble pad 2 */
 #endif
 #ifdef CONFIG_THRUSTMASTER_FF
     { 0x44f, 0xb304, hid_tmff_init },

------=_Part_93149_17867281.1171565778708
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch (initially submitted by Valentin Zagura) adds the Logitech
Formula Force EX to the list of devices handled by hid-lgff.<br>Also updated the text of the Kconfig entry.<br><br>Signed-off-by: Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
johann.deneux@gmail.com</a>&gt;<br><br>--- linux-2.6.20.orig/drivers/usb/input/Kconfig&nbsp;&nbsp; &nbsp;2007-02-04 19:44:54.000000000 +0100<br>+++ linux-2.6.20/drivers/usb/input/Kconfig&nbsp;&nbsp; &nbsp;2007-02-15 12:27:42.000000000 +0100<br>@@ -56,17 +56,21 @@ config HID_PID
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Say Y here if you have a PID-compliant device and wish to enable force
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; feedback for it. Microsoft Sidewinder Force Feedback 2 is one of such<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; devices.<br>&nbsp;<br>&nbsp;config LOGITECH_FF<br>-&nbsp;&nbsp; &nbsp;bool &quot;Logitech WingMan *3D support&quot;<br>+&nbsp;&nbsp; &nbsp;bool &quot;Logitech devices support&quot;
<br>&nbsp;&nbsp;&nbsp; &nbsp;depends on HID_FF<br>&nbsp;&nbsp;&nbsp; &nbsp;select INPUT_FF_MEMLESS if USB_HID<br>&nbsp;&nbsp;&nbsp; &nbsp;help<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Say Y here if you have one of these devices:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; - Logitech WingMan Cordless RumblePad<br>+&nbsp;&nbsp; &nbsp;&nbsp; - Logitech WingMan Cordless RumblePad 2
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; - Logitech WingMan Force 3D<br>+&nbsp;&nbsp; &nbsp;&nbsp; - Logitech Formula Force EX<br>+&nbsp;&nbsp; &nbsp;&nbsp; - Logitech MOMO Force wheel<br>+<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; and if you want to enable force feedback for them.<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Note: if you say N here, this device will still be supported, but without
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; force feedback.<br>&nbsp;<br>&nbsp;config THRUSTMASTER_FF<br>--- linux-2.6.20.orig/drivers/usb/input/hid-ff.c&nbsp;&nbsp; &nbsp;2007-02-04 19:44:54.000000000 +0100<br>+++ linux-2.6.20/drivers/usb/input/hid-ff.c&nbsp;&nbsp; &nbsp;2007-02-15 12:16:53.000000000

 +0100<br>@@ -53,10 +53,11 @@ struct hid_ff_initializer {<br>&nbsp; */<br>&nbsp;static struct hid_ff_initializer inits[] = {<br>&nbsp;#ifdef CONFIG_LOGITECH_FF<br>&nbsp;&nbsp;&nbsp; &nbsp;{ 0x46d, 0xc211, hid_lgff_init }, /* Logitech Cordless rumble pad */
<br>&nbsp;&nbsp;&nbsp; &nbsp;{ 0x46d, 0xc283, hid_lgff_init }, /* Logitech Wingman Force 3d */<br>+&nbsp;&nbsp; &nbsp;{ 0x46d, 0xc294, hid_lgff_init }, /* Logitech Formula Force EX */<br>&nbsp;&nbsp;&nbsp; &nbsp;{ 0x46d, 0xc295, hid_lgff_init }, /* Logitech MOMO force wheel */
<br>&nbsp;&nbsp;&nbsp; &nbsp;{ 0x46d, 0xc219, hid_lgff_init }, /* Logitech Cordless rumble pad 2 */<br>&nbsp;#endif<br>&nbsp;#ifdef CONFIG_THRUSTMASTER_FF<br>&nbsp;&nbsp;&nbsp; &nbsp;{ 0x44f, 0xb304, hid_tmff_init },<br><br>

------=_Part_93149_17867281.1171565778708--
