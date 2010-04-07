From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [BUG] hid NULL ptr deref on usb reset with hid disabled quirk
Date: Wed, 07 Apr 2010 19:01:41 +0200
Message-ID: <1270659702.27948.9.camel@lovely>
References: <4BBC4B51.8060005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:57542 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387Ab0DGQ44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 12:56:56 -0400
Received: by fxm23 with SMTP id 23so1244195fxm.21
        for <linux-input@vger.kernel.org>; Wed, 07 Apr 2010 09:56:55 -0700 (PDT)
In-Reply-To: <4BBC4B51.8060005@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-usb <linux-input@vger.kernel.org>

Am Mittwoch, den 07.04.2010, 11:07 +0200 schrieb Hans de Goede:

> usbhid.quirks=0x1908:0x1315:0x4
> 
> To the kernel cmdline. But this results in triggering a bug in the hid
> driver. When a device has the ignore quirk (which the above command sets)

As I can see, 0x4 HID_QUIRK_IGNORE happens after add_device.

just a guess:

diff --cc drivers/input/serio/i8042-x86ia64io.h
index ead0494,924e8ed..0000000
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2e2aa75..19e6a60 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1683,6 +1683,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_USB_DEVICE(0x1908, 0x1315) },
 	{ }
 };


