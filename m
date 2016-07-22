From: Michel Hermier <michel.hermier@gmail.com>
Subject: Re: Welcome to linux-input
Date: Fri, 22 Jul 2016 12:01:05 +0200
Message-ID: <4a1deacf-8de4-4a52-5538-fc6b8cb86baa@gmail.com>
References: <S1753190AbcGVJwR/20160722095217Z+48@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9D445AB3498F1ADC85B7FF7A"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34999 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbcGVKBI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2016 06:01:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so5491956wmg.2
        for <linux-input@vger.kernel.org>; Fri, 22 Jul 2016 03:01:08 -0700 (PDT)
Received: from zeus.mount-olympus.ath.cx (ANice-653-1-601-61.w86-205.abo.wanadoo.fr. [86.205.73.61])
        by smtp.gmail.com with ESMTPSA id x6sm117675wjk.26.2016.07.22.03.01.06
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2016 03:01:06 -0700 (PDT)
In-Reply-To: <S1753190AbcGVJwR/20160722095217Z+48@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D445AB3498F1ADC85B7FF7A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I made a patch to resolve my old issue 
https://bugzilla.kernel.org/show_bug.cgi?id=37982
It fixes and tries to uniformize a a bunch of fixes common to Microsoft 
keyboards also reported as joysticks.

Please review, cheers
    Michel

--------------9D445AB3498F1ADC85B7FF7A
Content-Type: text/x-patch;
 name="0001-hid-Attempt-to-uniformise-a-common-quirk-fix-in-Micr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-hid-Attempt-to-uniformise-a-common-quirk-fix-in-Micr.pa";
 filename*1="tch"

>From 4afcd01190dbaab01f7ca34f1455eed779c262a6 Mon Sep 17 00:00:00 2001
From: Michel Hermier <michel.hermier@gmail.com>
Date: Sun, 3 Jul 2016 08:30:44 +0200
Subject: [PATCH] hid: Attempt to uniformise a common quirk fix in Microsoft
 keyboards report descriptors.

It seems microsoft used the more or less the same report descriptor, with
the same issue for us, over generations of hardware. This patch tries to
uniformise it. Adding Microsoft digital media 600 and 7k while at it.
---
 drivers/hid/hid-microsoft.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index e924d55..7174352 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -25,32 +25,32 @@
 #define MS_HIDINPUT		0x01
 #define MS_ERGONOMY		0x02
 #define MS_PRESENTER		0x04
-#define MS_RDESC		0x08
+#define _MS_RDESC		0x08
+#define _MS_RDESC_OFFSET_MASK	0x000fff00
+#define _MS_RDESC_OFFSET_SHIFT	8
+#define _MS_RDESC_SIZE_MASK	0xfff00000
+#define _MS_RDESC_SIZE_SHIFT	20
+#define MS_RDESC(size, offset)	(_MS_RDESC | ((offset) << _MS_RDESC_OFFSET_SHIFT) | ((size) << _MS_RDESC_SIZE_SHIFT))
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
-#define MS_RDESC_3K		0x40
 
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	unsigned long offset = (quirks & _MS_RDESC_OFFSET_MASK) >> _MS_RDESC_OFFSET_SHIFT;
+	unsigned long size   = (quirks & _MS_RDESC_SIZE_MASK) >> _MS_RDESC_SIZE_SHIFT;
 
 	/*
-	 * Microsoft Wireless Desktop Receiver (Model 1028) has
-	 * 'Usage Min/Max' where it ought to have 'Physical Min/Max'
+	 * A bunch of Microsoft devices has 'Usage Min/Max' where it ought to have
+	 * 'Physical Min/Max'
 	 */
-	if ((quirks & MS_RDESC) && *rsize == 571 && rdesc[557] == 0x19 &&
-			rdesc[559] == 0x29) {
-		hid_info(hdev, "fixing up Microsoft Wireless Receiver Model 1028 report descriptor\n");
-		rdesc[557] = 0x35;
-		rdesc[559] = 0x45;
-	}
-	/* the same as above (s/usage/physical/) */
-	if ((quirks & MS_RDESC_3K) && *rsize == 106 && rdesc[94] == 0x19 &&
-			rdesc[95] == 0x00 && rdesc[96] == 0x29 &&
-			rdesc[97] == 0xff) {
-		rdesc[94] = 0x35;
-		rdesc[96] = 0x45;
+	if ((quirks & _MS_RDESC) && *rsize == size &&
+		rdesc[offset + 0] == 0x19 && rdesc[offset + 1] == 0x00 &&
+		rdesc[offset + 2] == 0x29 && rdesc[offset + 3] == 0xff) {
+		hid_info(hdev, "fixing up %s report descriptor\n", hdev->name);
+		rdesc[offset + 0] = 0x35;
+		rdesc[offset + 2] = 0x45;
 	}
 	return rdesc;
 }
@@ -267,17 +267,17 @@ static const struct hid_device_id ms_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE7K),
 		.driver_data = MS_ERGONOMY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K),
-		.driver_data = MS_ERGONOMY | MS_RDESC },
+		.driver_data = MS_ERGONOMY | MS_RDESC(571, 557) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_USB),
 		.driver_data = MS_PRESENTER },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K),
-		.driver_data = MS_ERGONOMY | MS_RDESC_3K },
+		.driver_data = MS_ERGONOMY | MS_RDESC(106, 94) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K),
-		.driver_data = MS_ERGONOMY },
+		.driver_data = MS_ERGONOMY | MS_RDESC(106, 94) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600),
-		.driver_data = MS_ERGONOMY },
+		.driver_data = MS_ERGONOMY | MS_RDESC(106, 94) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1),
-		.driver_data = MS_ERGONOMY },
+		.driver_data = MS_ERGONOMY | MS_RDESC(106, 94) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0),
 		.driver_data = MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
-- 
2.9.0


--------------9D445AB3498F1ADC85B7FF7A--
