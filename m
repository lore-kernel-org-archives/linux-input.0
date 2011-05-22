From: Stefan Kriwanek <mail@stefankriwanek.de>
Subject: [PATCH] Fix USB mouse "SpeedLink Vicious and Divine Cezanne"
Date: Sun, 22 May 2011 20:53:32 +0200
Message-ID: <4DD95BAC.5060406@stefankriwanek.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wp123.webpack.hosteurope.de ([80.237.132.130]:52085 "EHLO
	wp123.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752237Ab1EVTMm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 May 2011 15:12:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I own two of these mice which show a hardware error that makes the cursor "jump" from one place to another every now and then (while not moving the mouse). It's present in Windows as well, therefore I guess it is related to hardware. The issue is easily tracked down to relative motion events erroneously reported by the device, each having a distance value of +256. This +256 can in fact never occur due to real motion, even on the highest laser resolution setting. Therefore, it is easy to work around, which I did with the patch below.

However, I feel that I did not quite got it right, as I added an extra quirk type and an extra conditional in the hid event handler function only for this one device. Maybe, is it better to write a dedicated driver?

Could someone please give me advice on how to write a proper patch to get the fix included into the kernel?

Thanks in advance and kind regards,
Stefan

--- linux-2.6.39/drivers/hid/hid-ids.h
+++ linux-2.6.39-vadcezanne/drivers/hid/hid-ids.h
@@ -607,6 +607,9 @@
 #define USB_VENDOR_ID_WISEGROUP_LTD2	0x6677
 #define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802
 
+#define USB_VENDOR_ID_X_TENSIONS		0x1ae7
+#define USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE	0x9001
+
 #define USB_VENDOR_ID_YEALINK		0x6993
 #define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K	0xb001
 
--- linux-2.6.39/drivers/hid/hid-input.c
+++ linux-2.6.39-vadcezanne/drivers/hid/hid-input.c
@@ -774,6 +774,9 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
 
+	if ((usage->type == EV_REL) && (hid->quirks & HID_QUIRK_MOTION_OUTLIERS) && ((usage->code == 0) || (usage->code == 1)) && (value == 256))
+		return;
+
 	/* report the usage code as scancode if the key status has changed */
 	if (usage->type == EV_KEY && !!test_bit(usage->code, input->key) != value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
--- linux-2.6.39/drivers/hid/usbhid/hid-quirks.c
+++ linux-2.6.39-vadcezanne/drivers/hid/usbhid/hid-quirks.c
@@ -86,6 +86,9 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MULTI_INPUT },
+
+	{ USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE, HID_QUIRK_MOTION_OUTLIERS },
+
 	{ 0, 0 }
 };
 
--- linux-2.6.39/include/linux/hid.h
+++ linux-2.6.39-vadcezanne/include/linux/hid.h
@@ -312,6 +312,7 @@ struct hid_item {
 #define HID_QUIRK_BADPAD			0x00000020
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
+#define HID_QUIRK_MOTION_OUTLIERS		0x00000100
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000


