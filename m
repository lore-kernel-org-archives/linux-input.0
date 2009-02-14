From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch] hid: move tmff and zpff devices from ignore_list to blacklist
Date: Sat, 14 Feb 2009 11:45:05 +0200
Message-ID: <499692A1.6030303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:41370 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbZBNJpK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2009 04:45:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

The devices handled by hid-tmff and hid-zpff were added in the
hid_ignore_list[] instead of hid_blacklist[] in hid-core.c, thus
disabling them completely.

hid_ignore_list[] causes hid layer to skip the device, while
hid_blacklist[] indicates there is a specific driver in hid bus.

Re-enable the devices by moving them to the correct list.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

--- linux-2629-pidff/drivers/hid/hid-core.c	2009-02-13 22:12:21.000000000 +0200
+++ linux-2629-pidff/drivers/hid/hid-core.c.new	2009-02-14 11:27:52.000000000 +0200
@@ -1306,7 +1306,13 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
@@ -1618,10 +1624,6 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP) },
@@ -1632,8 +1634,6 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 	{ }
 };
 


-- 
Anssi Hannula

