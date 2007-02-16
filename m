From: "johann deneux" <johann.deneux@gmail.com>
Subject: [PATCH] Added devices handled by hid-lgff
Date: Fri, 16 Feb 2007 16:47:37 +0100
Message-ID: <38b3b7c0702160747x73ddc74dua38fc88f9c0b5b8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6295_11515098.1171640857056"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, dmitry <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

------=_Part_6295_11515098.1171640857056
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Device ids that were recently added to hid-ff.c must also be added to
hid-lgff.c

Signed-off-by: Johann Deneux < johann.deneux@gmail.com>

--- linux-2.6.20.orig/drivers/usb/input/hid-lgff.c    2007-02-04 19:44:
54.000000000 +0100
+++ linux-2.6.20/drivers/usb/input/hid-lgff.c    2007-02-16 16:32:
02.000000000 +0100
@@ -3,6 +3,7 @@
  * Logitech, namely:
  * - WingMan Cordless RumblePad
  * - WingMan Force 3D
+ * - A bunch of steering wheels
  *
  *  Copyright (c) 2002-2004 Johann Deneux
  *  Copyright (c) 2006 Anssi Hannula < anssi.hannula@gmail.com>
@@ -52,6 +53,8 @@ static const struct device_type devices[
     { 0x046d, 0xc211, ff_rumble },
     { 0x046d, 0xc219, ff_rumble },
     { 0x046d, 0xc283, ff_joystick },
+    { 0x046d, 0xc294, ff_joystick },
+    { 0x046d, 0xc295, ff_joystick },
     { 0x0000, 0x0000, ff_joystick }
 };

------=_Part_6295_11515098.1171640857056
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Device ids that were recently added to hid-ff.c must also be added to hid-lgff.c<br><br>Signed-off-by: Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">


johann.deneux@gmail.com</a>&gt;<br><br>--- linux-2.6.20.orig/drivers/usb/input/hid-lgff.c&nbsp;&nbsp;&nbsp; 2007-02-04 19:44:54.000000000 +0100<br>+++ linux-2.6.20/drivers/usb/input/hid-lgff.c&nbsp;&nbsp;&nbsp; 2007-02-16 16:32:02.000000000 +0100<br>
@@ -3,6 +3,7 @@
<br>&nbsp; * Logitech, namely:<br>&nbsp; * - WingMan Cordless RumblePad<br>&nbsp; * - WingMan Force 3D<br>+ * - A bunch of steering wheels<br>&nbsp; *<br>&nbsp; *&nbsp; Copyright (c) 2002-2004 Johann Deneux<br>&nbsp; *&nbsp; Copyright (c) 2006 Anssi Hannula &lt;
<a href="mailto:anssi.hannula@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">anssi.hannula@gmail.com</a>&gt;<br>@@ -52,6 +53,8 @@ static const struct device_type devices[<br>&nbsp;&nbsp;&nbsp;&nbsp; { 0x046d, 0xc211, ff_rumble },
<br>&nbsp;&nbsp;&nbsp;&nbsp; { 0x046d, 0xc219, ff_rumble },<br>&nbsp;&nbsp;&nbsp;&nbsp; { 0x046d, 0xc283, ff_joystick },
<br>+&nbsp;&nbsp;&nbsp; { 0x046d, 0xc294, ff_joystick },<br>+&nbsp;&nbsp;&nbsp; { 0x046d, 0xc295, ff_joystick },<br>&nbsp;&nbsp;&nbsp;&nbsp; { 0x0000, 0x0000, ff_joystick }<br>&nbsp;};<br>&nbsp;<br><br>

------=_Part_6295_11515098.1171640857056--
