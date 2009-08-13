From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Thu, 13 Aug 2009 20:52:00 -0300
Message-ID: <200908132052.01012.lamarque@gmail.com>
References: <200908062247.29254.lamarque@gmail.com> <200908072223.21450.lamarque@gmail.com> <alpine.LNX.2.00.0908131343290.25797@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hcKhKrOiQBGcFEb"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:48021 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbZHMXwR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 19:52:17 -0400
Received: by qyk34 with SMTP id 34so911020qyk.33
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2009 16:52:17 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908131343290.25797@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

--Boundary-00=_hcKhKrOiQBGcFEb
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

	I think  I have found a good solution for my problem, see the attached patch. 
I just need to find a better name for the define USB_DEVICE_ID_KYE_58.

-- 
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/

--Boundary-00=_hcKhKrOiQBGcFEb
Content-Type: text/x-patch;
  charset="UTF-8";
  name="bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch"

diff -Nru --show-c-function a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
--- a/drivers/hid/hid-core.c	2009-08-13 20:45:11.000000000 -0300
+++ b/drivers/hid/hid-core.c	2009-08-13 20:46:12.000000000 -0300
@@ -1636,6 +1636,7 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_58) },
 	{ }
 };
 
diff -Nru --show-c-function a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
--- a/drivers/hid/hid-ids.h	2009-08-13 20:45:04.000000000 -0300
+++ b/drivers/hid/hid-ids.h	2009-08-13 20:51:24.172588296 -0300
@@ -434,6 +434,7 @@
 #define USB_VENDOR_ID_KYE		0x0458
 #define USB_DEVICE_ID_KYE_ERGO_525V	0x0087
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
+#define USB_DEVICE_ID_KYE_58		0x0058
 
 
 #endif

--Boundary-00=_hcKhKrOiQBGcFEb--
