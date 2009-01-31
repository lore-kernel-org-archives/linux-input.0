From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] blacklist Powercom USB UPS in hid
Date: Sat, 31 Jan 2009 13:37:19 +0300
Message-ID: <1233398239.117942.6436.nullmailer@msgid.corpit.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.33.150]:24523 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbZAaKhW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2009 05:37:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux INPUT list <linux-input@vger.kernel.org>

This is my second attempt to fix the thing.
Now completely tested and appears to work as
expected, finally (I hope anyway).

For quite some time users with various UPSes from
Powercom were forced to play magic with bind/unbind
in /sys in order to be able to see the UPSes.  The
beasts does not work as HID devices, even if claims
to do so.  cypress_m8 driver works with the devices
instead, creating a normal serial port with which
normal UPS controlling software works.

The manufacturer confirmed the upcoming models with
proper HID support will have different device IDs.
In any way, it's wrong to have two completely different
modules for one device in kernel.

Blacklist the device in HID (add it to hid_ignore_list)
to stop this mess, finally.

Signed-off-By: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index acc1abc..8beb9bd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -348,6 +348,10 @@
 #define USB_VENDOR_ID_PLAYDOTCOM	0x0b43
 #define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII	0x0003
 
+/* Powercom UPS which is not HID but Serial<=>USB converter (cypress_m8 module) */
+#define USB_VENDOR_ID_POWERCOM		0x0d9f
+#define USB_DEVICE_ID_POWERCOM_UPS	0x0002
+
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5d7640e..db03ca5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1605,2 +1605,3 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0004) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD) },
