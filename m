From: =?KOI8-R?B?88XSx8XKIOjP0s/bwdfJzg==?= <skhoroshavin@gmail.com>
Subject: [PATCH] usbhid: GeneralTouch DTL153 touchscreen fix
Date: Mon, 26 Nov 2012 22:49:25 +0400
Message-ID: <CAAjB_gwc3rFNY-z3ZTF0xrgHfX-KRT1Oq1dXJjt2PyS=sA8NYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:37835 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab2KZSt0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 13:49:26 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so4526238eaa.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 10:49:25 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Sergey Khoroshavin <skhoroshavin@gmail.com>

Fix usbhid sending motion events for Z/RX instead of X/Y axes when
used with GeneralTouch DTL153 touchscreen (vendor id 1DDB, product id
0001).

BUG 51001: https://bugzilla.kernel.org/show_bug.cgi?id=51001

Signed-off-by: Sergey Khoroshavin <skhoroshavin@gmail.com>

---

diff -uprN linux-3.6/drivers/hid/hid-ids.h
linux-3.6-patched/drivers/hid/hid-ids.h
--- linux-3.6/drivers/hid/hid-ids.h	2012-10-01 03:47:46.000000000 +0400
+++ linux-3.6-patched/drivers/hid/hid-ids.h	2012-11-24 14:39:04.775148213 +0400
@@ -306,6 +306,9 @@
 #define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003

+#define USB_VENDOR_ID_GENERAL_TOUCH_RESISTIVE	0x1ddb
+#define USB_DEVICE_ID_GENERAL_TOUCH_DTL153	0x0001
+
 #define USB_VENDOR_ID_GLAB		0x06c2
 #define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
 #define USB_DEVICE_ID_1_PHIDGETSERVO_30	0x0039
diff -uprN linux-3.6/drivers/hid/usbhid/hid-quirks.c
linux-3.6-patched/drivers/hid/usbhid/hid-quirks.c
--- linux-3.6/drivers/hid/usbhid/hid-quirks.c	2012-10-01
03:47:46.000000000 +0400
+++ linux-3.6-patched/drivers/hid/usbhid/hid-quirks.c	2012-11-24
14:44:51.468546301 +0400
@@ -36,6 +36,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER,
HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_GENERAL_TOUCH_RESISTIVE,
USB_DEVICE_ID_GENERAL_TOUCH_DTL153, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD |
HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD |
HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD
| HID_QUIRK_MULTI_INPUT },
