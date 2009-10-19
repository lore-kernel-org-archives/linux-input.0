From: Keith Rutkowski <rutkowski@signatureresearchinc.com>
Subject: Patch adding NOGET quirk for CH Products industrial joystick
Date: Mon, 19 Oct 2009 16:55:55 -0400
Message-ID: <4ADCD25B.4060508@signatureresearchinc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070000060302070602010004"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta31.charter.net ([216.33.127.82]:37483 "EHLO
	mta31.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553AbZJSUzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 16:55:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz

This is a multi-part message in MIME format.
--------------070000060302070602010004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch was applied to Fedora 11's 2.6.30.8-64 kernel and adds the 
NOGET quirk for CH Products industrial class joystick(s).  It is like 
the previous CH Products NOGET quirk patch for their consumer class 
joysticks.  Without the quirk, the joystick would only be detected and 
would not function at all in kernels >= 2.6.29.  It was tested with a CH 
Products 3-axis 5-button industrial joystick, product #HG-434IS000-U-217.

Signed-off-by: Keith Rutkowski <rutkowski@signatureresearchinc.com>

-- 

Keith Rutkowski
Software Engineer

Signature Research, Inc
www.signatureresearchinc.com

Email: rutkowski@signatureresearchinc.com
Phone: (906) 337-3360
Fax:   (906) 337-0023


--------------070000060302070602010004
Content-Type: text/x-patch;
 name="linux-2.6-blacklist-ch-products-joystick.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-2.6-blacklist-ch-products-joystick.patch"

diff -uNrp kernel-2.6.30.orig/drivers/hid/hid-ids.h kernel-2.6.30.new/drivers/hid/hid-ids.h
--- kernel-2.6.30.orig/drivers/hid/hid-ids.h	2009-10-19 11:39:11.506562098 -0400
+++ kernel-2.6.30.new/drivers/hid/hid-ids.h	2009-10-19 11:30:56.272437148 -0400
@@ -117,6 +117,7 @@
 #define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
 #define USB_DEVICE_ID_CH_COMBATSTICK	0x00f4
 #define USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE	0x00ff
+#define USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK	0x00d3
 
 #define USB_VENDOR_ID_CHERRY		0x046a
 #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
diff -uNrp kernel-2.6.30.orig/drivers/hid/usbhid/hid-quirks.c kernel-2.6.30.new/drivers/hid/usbhid/hid-quirks.c
--- kernel-2.6.30.orig/drivers/hid/usbhid/hid-quirks.c	2009-10-19 11:39:28.337562028 -0400
+++ kernel-2.6.30.new/drivers/hid/usbhid/hid-quirks.c	2009-10-19 11:30:40.810436422 -0400
@@ -53,6 +53,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },

--------------070000060302070602010004--
