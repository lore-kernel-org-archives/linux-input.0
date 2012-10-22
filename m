From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] HID: wiimote: add Nintendo-Wii-Remote-Plus IDs
Date: Mon, 22 Oct 2012 10:37:51 +0200
Message-ID: <1350895071-4017-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57629 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2JVIe2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 04:34:28 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so878802bkc.19
        for <linux-input@vger.kernel.org>; Mon, 22 Oct 2012 01:34:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Olson <peter.olson@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>

The newest revision of the Nintendo Wii Remote Plus uses new VID/PIDs. We
already support these devices so we can simply add the IDs.

Reported-by: Peter Olson <peter.olson@gmail.com>
Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
Hi Jiri

I am actually not sure why Nintendo changed the VID/PID for the newest
revisions. I have a WiimotePlus which uses the old IDs and works fine. However,
the Windows WiiMote driver developers reported to me that the protocol stayed
the same so I just added the IDs.
Please wait before applying this until I get a "Tested-by" from Peter (CC'ed).

Thanks
David

 drivers/hid/hid-ids.h          | 1 +
 drivers/hid/hid-wiimote-core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 753f3d6..b5c2231 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -583,6 +583,7 @@
 
 #define USB_VENDOR_ID_NINTENDO		0x057e
 #define USB_DEVICE_ID_NINTENDO_WIIMOTE	0x0306
+#define USB_DEVICE_ID_NINTENDO_WIIMOTE_2 0x0330
 
 #define USB_VENDOR_ID_NOVATEK		0x0603
 #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 84e2fbe..c8a4325 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1283,6 +1283,8 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 static const struct hid_device_id wiimote_hid_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
 				USB_DEVICE_ID_NINTENDO_WIIMOTE) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
+				USB_DEVICE_ID_NINTENDO_WIIMOTE_2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, wiimote_hid_devices);
-- 
1.7.12.4

