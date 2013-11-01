From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 05/13] HID: wiimote: add hid_wiimote.legacy parameter
Date: Fri,  1 Nov 2013 21:16:16 +0100
Message-ID: <1383336984-26601-6-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:40686 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAUQv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:51 -0400
Received: by mail-ee0-f51.google.com with SMTP id d41so4942eek.10
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:50 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

The first hid-wiimote driver had horrible default mappings which we have
to support now for compatibility reasons. This was no big problem as the
wiimote needs special user-space drivers to really make sense, anyway.

However, there are several wiimote extensions which can be used on their
own (especially the gamepads). To allow new mappings which comply to the
common gamepad rules, we introduce the hid_wiimote.legacy parameter so
users can get the old behavior back, if they need it.

This patch only introduces the module parameter, the following patches
will change the mappings.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 9 +++++++++
 drivers/hid/hid-wiimote.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 1446f52..89ca031 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -20,6 +20,9 @@
 #include "hid-ids.h"
 #include "hid-wiimote.h"
 
+/* set to 1 to enable legacy-mode and old reports */
+static unsigned int wiimote_legacy = 0;
+
 /* output queue handling */
 
 static int wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
@@ -1731,6 +1734,9 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->hdev = hdev;
 	hid_set_drvdata(hdev, wdata);
 
+	if (wiimote_legacy)
+		wdata->state.flags |= WIIPROTO_FLAG_LEGACY;
+
 	spin_lock_init(&wdata->queue.lock);
 	INIT_WORK(&wdata->queue.worker, wiimote_queue_worker);
 
@@ -1873,6 +1879,9 @@ static struct hid_driver wiimote_hid_driver = {
 };
 module_hid_driver(wiimote_hid_driver);
 
+MODULE_PARM_DESC(legacy, "Enable legacy mode and reports");
+module_param_named(legacy, wiimote_legacy, int, 0600);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
 MODULE_DESCRIPTION("Driver for Nintendo Wii / Wii U peripherals");
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 03065f1..6f70823 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -47,6 +47,7 @@
 #define WIIPROTO_FLAG_BUILTIN_MP	0x010000
 #define WIIPROTO_FLAG_NO_MP		0x020000
 #define WIIPROTO_FLAG_PRO_CALIB_DONE	0x040000
+#define WIIPROTO_FLAG_LEGACY		0x080000
 
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
-- 
1.8.4.1

