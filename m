From: Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 2/2] hid: fix radio-mr800 hidquirks
Date: Thu, 13 Nov 2008 05:44:50 +0300
Message-ID: <1226544290.7246.14.camel@tux.localhost>
References: <491B3E90.5020307@gmail.com>
	 <alpine.LNX.1.10.0811130131190.32143@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:25267 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbYKMCoe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 21:44:34 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1233622ugf.37
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2008 18:44:34 -0800 (PST)
In-Reply-To: <alpine.LNX.1.10.0811130131190.32143@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jirislaby@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This patch fixes radio-mr800 hidqurks. Removes it from blacklist entry
and places it in ignore entry in hid/hid-core.c

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>

---

diff -r f8813f2b16f7 linux/drivers/hid/hid-core.c
--- a/linux/drivers/hid/hid-core.c	Thu Nov 13 05:39:06 2008 +0300
+++ b/linux/drivers/hid/hid-core.c	Thu Nov 13 05:40:26 2008 +0300
@@ -1252,7 +1252,6 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BRIGHT, USB_DEVICE_ID_BRIGHT_ABNT2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION) },
@@ -1408,6 +1407,7 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM)},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM2)},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },


> 
-- 
Best regards, Klimov Alexey

