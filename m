From: Huei-Horng Yo <hiroshi@ghostsinthelab.org>
Subject: [PATCH] Add Apple wireless keyboard 2011 JIS model support
Date: Mon, 03 Feb 2014 13:19:51 +0800
Message-ID: <52EF26F7.7030500@ghostsinthelab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50354 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaBCFT5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 00:19:57 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so6619597pbc.16
        for <linux-input@vger.kernel.org>; Sun, 02 Feb 2014 21:19:57 -0800 (PST)
Received: from [192.168.1.101] ([49.159.89.73])
        by mx.google.com with ESMTPSA id nv7sm51805664pbc.31.2014.02.02.21.19.55
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 21:19:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I bought a Apple wireless keyboard 2011 JIS model,
the fn key isn't work as expected in Linux 3.12.9 (current version I am 
using),
I then read the kernel source code, found that it was not listed in HID 
IDs list,
so that I made a patch as below to add the model support.

P.S: Also reported in Bugzilla: 
https://bugzilla.kernel.org/show_bug.cgi?id=69681


Thanks,
Huei-Horng Yo



apple-alu-wireless-kbd-jis.patch

Signed-off-by: Huei-Horng Yo <hiroshi@ghostsinthelab.org>
diff -uprN linux-3.12.vanilla/drivers/hid/hid-apple.c 
linux-3.12/drivers/hid/hid-apple.c
--- linux-3.12.vanilla/drivers/hid/hid-apple.c  2013-11-04 
07:41:51.000000000 +0800
+++ linux-3.12/drivers/hid/hid-apple.c  2014-02-01 01:15:37.532768035 +0800
@@ -447,6 +447,9 @@ static const struct hid_device_id apple_
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
                 .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+ USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS),
+               .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS),
                 .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
diff -uprN linux-3.12.vanilla/drivers/hid/hid-core.c 
linux-3.12/drivers/hid/hid-core.c
--- linux-3.12.vanilla/drivers/hid/hid-core.c   2013-11-04 
07:41:51.000000000 +0800
+++ linux-3.12/drivers/hid/hid-core.c   2014-02-01 01:15:37.532768035 +0800
@@ -1680,6 +1680,7 @@ static const struct hid_device_id hid_ha
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI) },
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
+       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 
USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
         { HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, 
USB_DEVICE_ID_AUREAL_W01RN) },
diff -uprN linux-3.12.vanilla/drivers/hid/hid-ids.h 
linux-3.12/drivers/hid/hid-ids.h
--- linux-3.12.vanilla/drivers/hid/hid-ids.h    2013-11-04 
07:41:51.000000000 +0800
+++ linux-3.12/drivers/hid/hid-ids.h    2014-02-01 01:15:37.532768035 +0800
@@ -135,6 +135,7 @@
  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS   0x023b
  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI  0x0255
  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
+#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI   0x0290
  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO    0x0291
  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS    0x0292
