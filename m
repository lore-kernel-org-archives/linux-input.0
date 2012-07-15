From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/3] HID: Add HID_CLAIMED_OTHER for non-generic drivers
Date: Sun, 15 Jul 2012 20:21:47 +0200
Message-ID: <1342376509-7228-2-git-send-email-dh.herrmann@googlemail.com>
References: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37971 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2GOSWQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jul 2012 14:22:16 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so309295wgb.1
        for <linux-input@vger.kernel.org>; Sun, 15 Jul 2012 11:22:15 -0700 (PDT)
In-Reply-To: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

All normal devices that correctly conform to the HID specs are handled by
the hid-input driver. However, for non-standard drivers we often don't
want hid-input to handle them but rather use specific hid drivers. But
hid_connect() requires at least one generic driver to claim the devices.
As hid_hw_start() calls hid_connect() we currently use an ugly workaround
by adding HID_CLAIMED_INPUT to hid->claimed and clear it after
hid_hw_start() again (see hid-picolcd.c for examples).

This adds the HID_CLAIMED_OTHER flag which can be set by device drivers to
tell the hid-core that they handle the device without the need of any
generic driver like hidinput, hiddev or hidraw.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-core.c | 2 ++
 include/linux/hid.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9cdc74e..2039f32 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1391,6 +1391,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	if (hdev->claimed & HID_CLAIMED_HIDRAW)
 		len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
 				((struct hidraw *)hdev->hidraw)->minor);
+	if (hdev->claimed & HID_CLAIMED_OTHER)
+		len += sprintf(buf + len, "%sother", len ? "," : "");
 
 	type = "Device";
 	for (i = 0; i < hdev->maxcollection; i++) {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 449fa38..26b336a 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -452,6 +452,7 @@ struct hid_output_fifo {
 #define HID_CLAIMED_INPUT	1
 #define HID_CLAIMED_HIDDEV	2
 #define HID_CLAIMED_HIDRAW	4
+#define HID_CLAIMED_OTHER	8
 
 #define HID_STAT_ADDED		1
 #define HID_STAT_PARSED		2
-- 
1.7.11.2

