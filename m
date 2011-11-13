From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 13/16] HID: wiimote: Add debugfs support stubs
Date: Sun, 13 Nov 2011 14:27:16 +0100
Message-ID: <1321190839-3517-14-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab1KMN2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:28:13 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:28:12 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add initializer and deinitializer for debugfs support. This will later allow raw
eeprom access and direct DRM modifications to debug wiimote behaviour and
further protocol reverse-engineerings.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/Makefile            |    3 ++
 drivers/hid/hid-wiimote-core.c  |    5 +++
 drivers/hid/hid-wiimote-debug.c |   52 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h       |   13 +++++++++
 4 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote-debug.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 57d46e6..adbc933 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -29,6 +29,9 @@ hid-wiimote-y		:= hid-wiimote-core.o
 ifdef CONFIG_HID_WIIMOTE_EXT
 	hid-wiimote-y	+= hid-wiimote-ext.o
 endif
+ifdef CONFIG_DEBUG_FS
+	hid-wiimote-y	+= hid-wiimote-debug.o
+endif
 
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index d8ed1ec..919abba 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1161,6 +1161,7 @@ err:
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+	wiidebug_deinit(wdata);
 	wiiext_deinit(wdata);
 	wiimote_leds_destroy(wdata);
 
@@ -1237,6 +1238,10 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	if (ret)
 		goto err_free;
 
+	ret = wiidebug_init(wdata);
+	if (ret)
+		goto err_free;
+
 	hid_info(hdev, "New device registered\n");
 
 	/* by default set led1 after device initialization */
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
new file mode 100644
index 0000000..6282e3c
--- /dev/null
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -0,0 +1,52 @@
+/*
+ * Debug support for HID Nintendo Wiimote devices
+ * Copyright (c) 2011 David Herrmann
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include "hid-wiimote.h"
+
+struct wiimote_debug {
+	struct wiimote_data *wdata;
+};
+
+int wiidebug_init(struct wiimote_data *wdata)
+{
+	struct wiimote_debug *dbg;
+	unsigned long flags;
+
+	dbg = kzalloc(sizeof(*dbg), GFP_KERNEL);
+	if (!dbg)
+		return -ENOMEM;
+
+	dbg->wdata = wdata;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->debug = dbg;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+void wiidebug_deinit(struct wiimote_data *wdata)
+{
+	struct wiimote_debug *dbg = wdata->debug;
+	unsigned long flags;
+
+	if (!dbg)
+		return;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->debug = NULL;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	kfree(dbg);
+}
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 1f3e53a..89b8851 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -74,6 +74,7 @@ struct wiimote_data {
 	struct input_dev *ir;
 	struct power_supply battery;
 	struct wiimote_ext *ext;
+	struct wiimote_debug *debug;
 
 	spinlock_t qlock;
 	__u8 head;
@@ -137,6 +138,18 @@ static inline void wiiext_handle(void *u, const __u8 *p) { }
 
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+
+extern int wiidebug_init(struct wiimote_data *wdata);
+extern void wiidebug_deinit(struct wiimote_data *wdata);
+
+#else
+
+static inline int wiidebug_init(void *u) { return 0; }
+static inline void wiidebug_deinit(void *u) { }
+
+#endif
+
 /* requires the state.lock spinlock to be held */
 static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
 								__u32 opt)
-- 
1.7.7.3

