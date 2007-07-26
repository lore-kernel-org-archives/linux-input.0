From: Christian Lamparter <chunkeey@web.de>
Subject: Re: [PATCH] usbhid: add ASUS LCM to the blacklist
Date: Fri, 27 Jul 2007 01:10:00 +0200
Message-ID: <200707270110.01135.chunkeey@web.de>
References: <200707240228.39421.chunkeey@web.de> <20070726152709.6daa1c96.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JnSqGVka9ftijN4"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070726152709.6daa1c96.akpm@linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

--Boundary-00=_JnSqGVka9ftijN4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some of ASUS' notebooks (e.g G Series) include a tiny oled display, which is 
attached to an internal USB bus. Unfortunatly the device reports a wrong
DeviceDescriptor and is therefore identified as a HID device...

Signed-off-by: Christian Lamparter <chunkeey@web.de>
CC: linux-input@atrey.karlin.mff.cuni.cz
CC: linux-usb-devel@lists.sourceforge.net

---
Right! the last _two_ patches/resends were made from 2.6.22-*,
this time however, it's diffed from 2.6.23-rc1-git3... 
(I hope it get's merged before someone else has already changed
the line numbers again. ;) )


--Boundary-00=_JnSqGVka9ftijN4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="asus-lcm-hid-quirk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asus-lcm-hid-quirk.diff"

diff -up drivers/hid/usbhid/hid-quirks.c.orig drivers/hid/usbhid/hid-quirks.c
--- a/drivers/hid/usbhid/hid-quirks.c.orig	2007-07-27 00:23:36.000000000 +0200
+++ b/drivers/hid/usbhid/hid-quirks.c	2007-07-27 00:25:26.000000000 +0200
@@ -63,6 +63,9 @@
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 #define USB_DEVICE_ID_APPLE_IR		0x8240
 
+#define USB_VENDOR_ID_ASUS		0x0b05
+#define USB_DEVICE_ID_ASUS_LCM		0x1726
+
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
 #define USB_DEVICE_ID_ATEN_CS124U	0x2202
@@ -464,6 +467,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_W7658, HID_QUIRK_RESET_LEDS },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KBD, HID_QUIRK_RESET_LEDS },
 
+	{ USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM, HID_QUIRK_IGNORE},
+
 	{ 0, 0 }
 };
 

--Boundary-00=_JnSqGVka9ftijN4--
