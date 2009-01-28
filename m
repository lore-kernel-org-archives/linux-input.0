From: Michael Tokarev <mjt@tls.msk.ru>
Subject: blacklist Powercom UPSes which are not HIDs but Serial<=>USB things
Date: Wed, 28 Jan 2009 23:19:32 +0300
Message-ID: <1233173972.288064.6256.nullmailer@msgid.corpit.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.33.150]:23013 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbZA1UTm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 15:19:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux INPUT list <linux-input@vger.kernel.org>

For quite some time users with various UPSes from Powercom
were forced to play magic with bind/unbind in /sys in order
to be able to see the UPSes.  The beasts does not work as
HID devices, even if claims to do so.  cypress_m8 driver
works with the devices instead, creating a normal serial
port with which normal UPS controlling software works.
Blacklist the device in HID to stop this all.

Signed-off-By: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index acc1abc..8beb9bd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -348,6 +348,10 @@
 #define USB_VENDOR_ID_PLAYDOTCOM	0x0b43
 #define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII	0x0003
 
+/* Powercom UPS which is not HID but Serial<=>USB converter (cypress_m8 drv) */
+#define USB_VENDOR_ID_POWERCOM		0x0d9f
+#define USB_DEVICE_ID_POWERCOM_UPS	0x0002
+
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5d7640e..dcd4add 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1295,6 +1295,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
