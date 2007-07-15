From: Chr <chunkeey@web.de>
Subject: [PATCH] usbhid: add ASUS' OLED display to HID's
	blacklist.
Date: Sun, 15 Jul 2007 13:16:42 +0200
Message-ID: <200707151316.42147.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aIgmGAq5kgXPFV7"
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

--Boundary-00=_aIgmGAq5kgXPFV7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some ASUS' notebooks (e.g G Series) include a tiny oled display, which is 
attached to an internal USB bus. Unfortunatly the device reports a wrong
DeviceDescriptor and is therefore identified as a HID device...

Signed-off-by: Christian Lamparter <chunkeey@web.de>
-

P.S: for those who are interested in a display driver:
http://rapidshare.com/files/42847259/asusoled.tar.bz2.html
(needs SDL (+ SDL_image), cmake & libusb)

--Boundary-00=_aIgmGAq5kgXPFV7
Content-Type: text/x-diff; charset="utf-8"; name="asus-lcm-hid-quirk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asus-lcm-hid-quirk.diff"

--- a/drivers/hid/usbhid/hid-quirks.c.orig	2007-06-02 21:49:26.000000000 +0200
+++ b/drivers/hid/usbhid/hid-quirks.c	2007-07-14 20:40:03.000000000 +0200
@@ -63,6 +63,9 @@
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 #define USB_DEVICE_ID_APPLE_IR		0x8240
 
+#define USB_VENDOR_ID_ASUS		0x0b05
+#define USB_DEVICE_ID_ASUS_LCM		0x1726
+
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
 #define USB_DEVICE_ID_ATEN_CS124U	0x2202
@@ -452,6 +455,8 @@
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1, HID_QUIRK_SWAPPED_MIN_MAX },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_2, HID_QUIRK_SWAPPED_MIN_MAX },
 
+	{ USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM, HID_QUIRK_IGNORE}, 
+
 	{ 0, 0 }
 };
 

--Boundary-00=_aIgmGAq5kgXPFV7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_aIgmGAq5kgXPFV7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--Boundary-00=_aIgmGAq5kgXPFV7--
