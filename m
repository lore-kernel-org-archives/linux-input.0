From: Jimmy Hon <honyuenkwun@gmail.com>
Subject: [PATCH 2.6.38.6 1/1] usbhid: add quirks for HyperPen 10000U
Date: Fri, 20 May 2011 06:58:18 -0400
Message-ID: <4DD6494A.6010102@gmail.com>
Reply-To: honj@alum.rpi.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33505 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1ETK53 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2011 06:57:29 -0400
Received: by qyg14 with SMTP id 14so2050032qyg.19
        for <linux-input@vger.kernel.org>; Fri, 20 May 2011 03:57:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Add 5543:0064 UC-Logic Technology Corp. Aiptek HyperPen 10000U to quirks 
with HID_QUIRK_MULTI_INPUT.

Originally the device is reporting the x,y coordinates on Z and RX. By 
adding this quirk, there will be two kernel devices. The first one is 
muted and the second device will report coordinates on X and Y.

---
diff -ur a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h    2011-05-20 06:31:15.471495292 -0400
+++ b/drivers/hid/hid-ids.h    2011-05-20 05:51:38.598147606 -0400
@@ -559,6 +559,7 @@
  #define USB_VENDOR_ID_UCLOGIC        0x5543
  #define USB_DEVICE_ID_UCLOGIC_TABLET_PF1209    0x0042
  #define USB_DEVICE_ID_UCLOGIC_TABLET_KNA5    0x6001
+#define USB_DEVICE_ID_UCLOGIC_TABLET_TWA60    0x0064
  #define USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U    0x0003
  #define USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U    0x0004
  #define USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U    0x0005
diff -ur a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
--- a/drivers/hid/usbhid/hid-quirks.c    2011-05-20 04:01:28.541441025 -0400
+++ b/drivers/hid/usbhid/hid-quirks.c    2011-05-20 04:10:21.881444247 -0400
@@ -71,6 +71,7 @@
      { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, 
HID_QUIRK_MULTI_INPUT },
      { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U, 
HID_QUIRK_MULTI_INPUT },
      { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5, 
HID_QUIRK_MULTI_INPUT },
+    { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60, 
HID_QUIRK_MULTI_INPUT },
      { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U, 
HID_QUIRK_MULTI_INPUT },
      { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U, 
HID_QUIRK_MULTI_INPUT },
      { USB_VENDOR_ID_WALTOP, 
USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH, HID_QUIRK_MULTI_INPUT },
