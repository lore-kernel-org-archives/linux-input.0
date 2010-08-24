From: simon@mungewell.org
Subject: [PATCH RESEND] HID USB: Add  IDs for Logitech Wii Speed Force
 Wireless Wheel
Date: Tue, 24 Aug 2010 14:05:38 -0400
Message-ID: <f7e4c6b27dc1ebe3a674e14661bb6ddc.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100824140538_82503"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:40376 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0HXSFn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Aug 2010 14:05:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

------=_20100824140538_82503
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

[Resent as no response/acknowledgement; CC'ed Jiri as you seem to involved
with USB ID's - apologies if you are not]

Attached patch adds support for Logitech Wii Speed Force Wireless Wheel
USB IDs and fixes the HID report so that the buttons/axis are correctly
recognised.

At present I am using the userland app to trigger the bonding of dongle to
wheel, as this does not happen automatically.

If there is something different or further testing required (other than
playing Torcs) please advise.

Simon
(aka. Mungewell)


---------------------------- Original Message ----------------------------
Subject: [PATCH] Logitech Wii Speed Force Wireless Wheel
From:    simon@mungewell.org
Date:    Thu, August 19, 2010 11:27 pm
To:      "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
--------------------------------------------------------------------------

Attached is a preliminary patch to enable support for the Logitech Wii
Speed Force Wireless Wheel, currently being sold on 'clearance' for around
$10.

The dongle/wheel do not automatically register with each other, a small
libhid app can be used to make a connection as follows:
--
$ sudo echo -n "3-2:1.0" > /sys/bus/usb/drivers/usbhid/unbind
$ sudo python wii_wheel_bond.py
$ sudo echo -n "3-2:1.0" > /sys/bus/usb/drivers/usbhid/bind
--

Basic functions work, but I believe that there if further work needed to
fully understand the configuration process of the dongle. Once understood
this function should be performed by the kernel driver.

I've also attached some notes on the configuration of the dongle. Since
the dongle is based around the nRF24L01 this might be similar to the other
Logitech 2.4GHz devices.

Cheers,
Simon
(aka. Mungewell)

------=_20100824140538_82503
Content-Type: text/x-patch; name="wii_wheel_20100819.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="wii_wheel_20100819.patch"

diff -ur linux-source-2.6.32/drivers/hid/hid-core.c linux-2.6.32-sdw/drivers/hid/hid-core.c
--- linux-source-2.6.32/drivers/hid/hid-core.c	2010-07-28 00:06:55.000000000 -0600
+++ linux-2.6.32-sdw/drivers/hid/hid-core.c	2010-07-06 18:56:15.000000000 -0600
@@ -1329,6 +1329,7 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K) },
diff -ur linux-source-2.6.32/drivers/hid/hid-ids.h linux-2.6.32-sdw/drivers/hid/hid-ids.h
--- linux-source-2.6.32/drivers/hid/hid-ids.h	2010-07-28 00:06:55.000000000 -0600
+++ linux-2.6.32-sdw/drivers/hid/hid-ids.h	2010-07-06 18:55:19.000000000 -0600
@@ -308,6 +308,7 @@
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_FFG	0xc293
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
+#define USB_DEVICE_ID_LOGITECH_WII_WHEEL	0xc29c
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
 #define USB_DEVICE_ID_S510_RECEIVER	0xc50c
 #define USB_DEVICE_ID_S510_RECEIVER_2	0xc517
diff -ur linux-source-2.6.32/drivers/hid/hid-lg.c linux-2.6.32-sdw/drivers/hid/hid-lg.c
--- linux-source-2.6.32/drivers/hid/hid-lg.c	2009-12-02 20:51:21.000000000 -0700
+++ linux-2.6.32-sdw/drivers/hid/hid-lg.c	2010-07-12 21:18:31.222442036 -0600
@@ -33,6 +33,7 @@
 #define LG_NOGET		0x100
 #define LG_FF			0x200
 #define LG_FF2			0x400
+#define LG_WIIWHEEL		0x2000
 
 /*
  * Certain Logitech keyboards send in report #3 keys which are far
@@ -51,6 +52,18 @@
 		rdesc[84] = rdesc[89] = 0x4d;
 		rdesc[85] = rdesc[90] = 0x10;
 	}
+
+        if ((quirks & LG_WIIWHEEL) && rsize >= 101 && 
+                        rdesc[41] == 0x95 && rdesc[42] == 0x0B &&
+                        rdesc[47] == 0x05 && rdesc[48] == 0x09) {
+                dev_info(&hdev->dev, "fixing up Logitech WiiWheel button "
+                                "descriptor\n");
+                rdesc[41] = 0x05;
+                rdesc[42] = 0x09;
+                rdesc[47] = 0x95;
+                rdesc[48] = 0x0B;
+        }
+
 }
 
 #define lg_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
@@ -299,6 +312,8 @@
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL),
 		.driver_data = LG_FF },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL),
+		.driver_data = LG_FF | LG_WIIWHEEL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ),
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
diff -ur linux-source-2.6.32/drivers/hid/hid-lgff.c linux-2.6.32-sdw/drivers/hid/hid-lgff.c
--- linux-source-2.6.32/drivers/hid/hid-lgff.c	2009-12-02 20:51:21.000000000 -0700
+++ linux-2.6.32-sdw/drivers/hid/hid-lgff.c	2010-07-12 21:16:40.890453659 -0600
@@ -70,6 +70,7 @@
 	{ 0x046d, 0xc293, ff_joystick },
 	{ 0x046d, 0xc294, ff_wheel },
 	{ 0x046d, 0xc295, ff_joystick },
+	{ 0x046d, 0xc29c, ff_wheel },
 	{ 0x046d, 0xca03, ff_wheel },
 };
 
------=_20100824140538_82503--


