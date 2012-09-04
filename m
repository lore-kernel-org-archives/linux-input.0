From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH] hid: usbhid: add quirk for SB arena headset
Date: Tue, 04 Sep 2012 17:15:58 -0500
Message-ID: <50467D9E.2080007@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090909030802090102040000"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34651 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739Ab2IDWQB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Sep 2012 18:16:01 -0400
Received: from cpe-70-112-44-241.austin.res.rr.com ([70.112.44.241] helo=[192.168.1.117])
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <chris.j.arges@canonical.com>)
	id 1T91Pb-0006Bg-9V
	for linux-input@vger.kernel.org; Tue, 04 Sep 2012 22:15:59 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------090909030802090102040000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,
Here is a patch that fixes a bug when using the SB Arena USB headset.
The bug link is here:
BugLink: http://bugs.launchpad.net/bugs/1007575. This patch has been
tested and fixes the issue.
Thanks,

--------------090909030802090102040000
Content-Type: text/x-patch;
 name="0001-hid-usbhid-add-quirk-for-SB-arena-headset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-hid-usbhid-add-quirk-for-SB-arena-headset.patch"

>From 534f357a72849f19ab38a75de9f7faa9efc5bd05 Mon Sep 17 00:00:00 2001
From: Chris J Arges <chris.j.arges@canonical.com>
Date: Mon, 27 Aug 2012 19:19:26 -0500
Subject: [PATCH] hid: usbhid: add quirk for SB arena headset

When an SB Arena USB headset is plugged in, it registers the volume
keys on the headset as a keyboard and continually sends events causing
issues with normal keyboard input. This quirk disables the volume keys.

BugLink: http://bugs.launchpad.net/bugs/1007575
Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 drivers/hid/hid-ids.h           |    2 +-
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9d9bb9a..c502420 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -224,9 +224,9 @@
 
 #define USB_VENDOR_ID_CREATIVELABS	0x041e
 #define USB_DEVICE_ID_PRODIKEYS_PCMIDI	0x2801
-
 #define USB_VENDOR_ID_CVTOUCH		0x1ff7
 #define USB_DEVICE_ID_CVTOUCH_SCREEN	0x0013
+#define USB_DEVICE_ID_SB_ARENA_HEADSET	0x0403
 
 #define USB_VENDOR_ID_CYGNAL		0x10c4
 #define USB_DEVICE_ID_CYGNAL_RADIO_SI470X	0x818a
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 903eef3..4b89f73 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -68,6 +68,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_SB_ARENA_HEADSET, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NO_INIT_REPORTS },
-- 
1.7.9.5



--------------090909030802090102040000--
