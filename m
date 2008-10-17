From: Dan Nicholson <dbn.lists@gmail.com>
Subject: [PATCH] Revert "HID: Invert HWHEEL mappings for some Logitech mice"
Date: Thu, 16 Oct 2008 22:06:14 -0700
Message-ID: <1224219974-4216-1-git-send-email-dbn.lists@gmail.com>
References: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:44160 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYJQFGf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2008 01:06:35 -0400
Received: by wf-out-1314.google.com with SMTP id 27so425843wfd.4
        for <linux-input@vger.kernel.org>; Thu, 16 Oct 2008 22:06:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ander Conselvan de Oliveira <ander@c3sl.ufpr.br>, linux-input@vger.kernel.org, stable@kernel.org

This reverts commit 740f370dc61dc478d891d7d47660bb3ae39ddb4f.

It turned out to be correct in the first place: a positive value should
be sent when the wheel is moved to the right, and a negative value when
moved to the left. This is the behavior expected by the Xorg evdev
driver. I must have had a remapping somewhere else in my system when
originally testing this. Testing on another system shows that the
unpatched kernel is correct.

Here is a bug report from Mandriva that brought the problem to my
attention:

    https://qa.mandriva.com/show_bug.cgi?id=44309#c19

Signed-off-by: Dan Nicholson <dbn.lists@gmail.com>
---
 drivers/hid/usbhid/hid-quirks.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b15f882..49144cb 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -247,8 +247,6 @@
 #define USB_DEVICE_ID_LD_MACHINETEST	0x2040
 
 #define USB_VENDOR_ID_LOGITECH		0x046d
-#define USB_DEVICE_ID_LOGITECH_LX3	0xc044
-#define USB_DEVICE_ID_LOGITECH_V150	0xc047
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
 #define USB_DEVICE_ID_LOGITECH_HARMONY  0xc110
 #define USB_DEVICE_ID_LOGITECH_HARMONY_2 0xc111
@@ -603,8 +601,6 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_ELITE_KBD, HID_QUIRK_LOGITECH_IGNORE_DOUBLED_WHEEL | HID_QUIRK_LOGITECH_EXPANDED_KEYMAP },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500, HID_QUIRK_LOGITECH_IGNORE_DOUBLED_WHEEL | HID_QUIRK_LOGITECH_EXPANDED_KEYMAP },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_LX3, HID_QUIRK_INVERT_HWHEEL },
-	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_V150, HID_QUIRK_INVERT_HWHEEL },
 
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K, HID_QUIRK_MICROSOFT_KEYS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K, HID_QUIRK_MICROSOFT_KEYS },
-- 
1.5.6.2

