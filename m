From: Raimund Roth <raimundmroth@googlemail.com>
Subject: Re: [PATCH] input: adding Surface Power Cover
Date: Mon, 08 Jun 2015 11:11:38 +0200
Message-ID: <1433754698.15335.51.camel@gmail.com>
References: <55737916.40206@gmail.com>
	 <alpine.LNX.2.00.1506081015000.12753@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38774 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285AbbFHJLk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 05:11:40 -0400
Received: by wibdq8 with SMTP id dq8so77452910wib.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2015 02:11:39 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1506081015000.12753@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Mon, 2015-06-08 at 10:15 +0200, Jiri Kosina wrote:
On Sun, 7 Jun 2015, Raimund Roth wrote:
> 
> > Adding support for the Microsoft Surface Pro Power Cover, Patch was
> > tested on Debian, Keyboard and Trackpad are fully working, both when
> > plugged in at boot or hotplugged.
> > 
> > Signed-off-by: Raimund Roth <raimundmroth@gmail.gom>
> 
> Your patch has been damaged by your e-mail client. Please fix your 
> workflow and resend.
> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs

Damn, missed that, sorry.

Signed-off-by Raimund Roth <raimundmroth@gmail.com>
---
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/hid-core.c linux-4.1-rc6-wip/drivers/hid/hid-core.c
--- linux-4.1-rc6-vanilla/drivers/hid/hid-core.c	2015-06-01 04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/hid-core.c	2015-06-06 23:31:58.373034000 +0200
@@ -706,7 +706,8 @@ static void hid_scan_collection(struct h
 
 	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
 	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
+	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP ||
+	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
 
@@ -1901,6 +1902,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/hid-ids.h linux-4.1-rc6-wip/drivers/hid/hid-ids.h
--- linux-4.1-rc6-vanilla/drivers/hid/hid-ids.h	2015-06-01 04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/hid-ids.h	2015-06-06 23:32:05.100989000 +0200
@@ -673,6 +673,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
 #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
+#define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/hid-microsoft.c linux-4.1-rc6-wip/drivers/hid/hid-microsoft.c
--- linux-4.1-rc6-vanilla/drivers/hid/hid-microsoft.c	2015-06-01 04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/hid-microsoft.c	2015-06-06 23:32:19.016894000 +0200
@@ -280,6 +280,8 @@ static const struct hid_device_id ms_dev
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
 		.driver_data = MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
+		.driver_data = MS_HIDINPUT },
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
diff -uprN linux-4.1-rc6-vanilla/drivers/hid/usbhid/hid-quirks.c linux-4.1-rc6-wip/drivers/hid/usbhid/hid-quirks.c
--- linux-4.1-rc6-vanilla/drivers/hid/usbhid/hid-quirks.c	2015-06-01 04:01:07.000000000 +0200
+++ linux-4.1-rc6-wip/drivers/hid/usbhid/hid-quirks.c	2015-06-06 23:32:37.876767000 +0200
@@ -89,6 +89,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },

