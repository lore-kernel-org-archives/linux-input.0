From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH] Support for the 11.6" Cando panel, found on the Acer
 1825PTZ
Date: Thu, 22 Apr 2010 23:24:36 +0200
Message-ID: <20100422212436.91C58951F6@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:51947 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130Ab0DVVYj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 17:24:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz
Cc: dmitry.torokhov@gmail.com, johannesklug@room2web.de, apw@canonical.com, chatty@enac.fr

Added support for the 11.6" Cando panel found on the Acer Timeline 1825PTZ.

Signed-off-by: Stephane Chatty <chatty@enac.fr>
Tested-by: Johannes Klug <johannesklug@room2web.de>

diff -rupN a/drivers/hid/hid-cando.c b/drivers/hid/hid-cando.c
--- a/drivers/hid/hid-cando.c	2010-04-23 00:12:41.000000000 +0200
+++ b/drivers/hid/hid-cando.c	2010-04-23 00:07:37.000000000 +0200
@@ -235,6 +235,8 @@ static void cando_remove(struct hid_devi
 static const struct hid_device_id cando_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, cando_devices);
diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2010-04-23 00:12:47.000000000 +0200
+++ b/drivers/hid/hid-core.c	2010-04-23 00:10:19.000000000 +0200
@@ -1274,6 +1274,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff -rupN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2010-04-23 00:12:51.000000000 +0200
+++ b/drivers/hid/hid-ids.h	2010-04-23 00:10:40.000000000 +0200
@@ -118,6 +118,7 @@
 
 #define USB_VENDOR_ID_CANDO		0x2087
 #define USB_DEVICE_ID_CANDO_MULTI_TOUCH 0x0a01
+#define USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6 0x0b03
 
 #define USB_VENDOR_ID_CH		0x068e
 #define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
