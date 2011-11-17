From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 04/17] HID: wiimote: Add extension support stub
Date: Thu, 17 Nov 2011 14:12:01 +0100
Message-ID: <1321535534-7950-5-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab1KQNM5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:12:57 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873323eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:12:56 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

The wiimote supports several extensions. This adds a separate source file which
handles all extensions and can be disabled at compile-time.

The driver reacts on "plug"-events on the extension port and starts a worker
which initializes or deinitializes the extensions.

Currently, the initialization logic is not fully understood and we can only
detect and enable all extensions when all extensions are deactivated. Therefore,
we need to disable all extensions, then detect and activate them again to react
on "plug"-events.
However, deactivating extensions will generate a new "plug"-event and we will
never leave that loop. Hence, we only support extensions if they are plugged
before the wiimote is connected (or before the ext-input device is opened). In
the future we may support full extension hotplug support, but
reverse-engineering this may take a while.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Add comment which explains the unusual order in the deinitialization
function.

 drivers/hid/Kconfig            |    9 +++
 drivers/hid/Makefile           |    3 +
 drivers/hid/hid-wiimote-core.c |   23 ++++++-
 drivers/hid/hid-wiimote-ext.c  |  130 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h      |   17 +++++
 5 files changed, 178 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote-ext.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 9907dc9..edf2b2b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -594,6 +594,15 @@ config HID_WIIMOTE
 	---help---
 	Support for the Nintendo Wii Remote bluetooth device.
 
+config HID_WIIMOTE_EXT
+	bool "Nintendo Wii Remote Extension support"
+	depends on HID_WIIMOTE
+	default HID_WIIMOTE
+	---help---
+	Support for extension controllers of the Nintendo Wii Remote. Say yes
+	here if you want to use the Nintendo Motion+, Nunchuck or Classic
+	extension controllers with your Wii Remote.
+
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 07e750a..57d46e6 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -26,6 +26,9 @@ ifdef CONFIG_LOGIWII_FF
 endif
 
 hid-wiimote-y		:= hid-wiimote-core.o
+ifdef CONFIG_HID_WIIMOTE_EXT
+	hid-wiimote-y	+= hid-wiimote-ext.o
+endif
 
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index f7f8b7f..2ca8bfd 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -201,6 +201,7 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 static __u8 select_drm(struct wiimote_data *wdata)
 {
 	__u8 ir = wdata->state.flags & WIIPROTO_FLAGS_IR;
+	bool ext = wiiext_active(wdata);
 
 	if (ir == WIIPROTO_FLAG_IR_BASIC) {
 		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
@@ -212,10 +213,17 @@ static __u8 select_drm(struct wiimote_data *wdata)
 	} else if (ir == WIIPROTO_FLAG_IR_FULL) {
 		return WIIPROTO_REQ_DRM_SKAI1;
 	} else {
-		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
-			return WIIPROTO_REQ_DRM_KA;
-		else
-			return WIIPROTO_REQ_DRM_K;
+		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL) {
+			if (ext)
+				return WIIPROTO_REQ_DRM_KAE;
+			else
+				return WIIPROTO_REQ_DRM_KA;
+		} else {
+			if (ext)
+				return WIIPROTO_REQ_DRM_KE;
+			else
+				return WIIPROTO_REQ_DRM_K;
+		}
 	}
 }
 
@@ -795,6 +803,8 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 	/* on status reports the drm is reset so we need to resend the drm */
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
 
+	wiiext_event(wdata, payload[2] & 0x02);
+
 	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_SREQ, 0)) {
 		wdata->state.cmd_battery = payload[5];
 		wiimote_cmd_complete(wdata);
@@ -1145,6 +1155,7 @@ err:
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+	wiiext_deinit(wdata);
 	wiimote_leds_destroy(wdata);
 
 	power_supply_unregister(&wdata->battery);
@@ -1216,6 +1227,10 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	if (ret)
 		goto err_free;
 
+	ret = wiiext_init(wdata);
+	if (ret)
+		goto err_free;
+
 	hid_info(hdev, "New device registered\n");
 
 	/* by default set led1 after device initialization */
diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
new file mode 100644
index 0000000..fa9c677
--- /dev/null
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -0,0 +1,130 @@
+/*
+ * HID driver for Nintendo Wiimote extension devices
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
+#include <linux/atomic.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include "hid-wiimote.h"
+
+struct wiimote_ext {
+	struct wiimote_data *wdata;
+	struct work_struct worker;
+
+	atomic_t opened;
+	atomic_t mp_opened;
+	bool plugged;
+	bool motionp;
+	__u8 ext_type;
+};
+
+enum wiiext_type {
+	WIIEXT_NONE,		/* placeholder */
+	WIIEXT_CLASSIC,		/* Nintendo classic controller */
+	WIIEXT_NUNCHUCK,	/* Nintendo nunchuck controller */
+};
+
+static void wiiext_worker(struct work_struct *work)
+{
+	struct wiimote_ext *ext = container_of(work, struct wiimote_ext,
+									worker);
+}
+
+/* schedule work only once, otherwise mark for reschedule */
+static void wiiext_schedule(struct wiimote_ext *ext)
+{
+	queue_work(system_nrt_wq, &ext->worker);
+}
+
+/*
+ * Reacts on extension port events
+ * Whenever the driver gets an event from the wiimote that an extension has been
+ * plugged or unplugged, this funtion shall be called. It checks what extensions
+ * are connected and initializes and activates them.
+ * This can be called in atomic context. The initialization is done in a
+ * separate worker thread. The state.lock spinlock must be held by the caller.
+ */
+void wiiext_event(struct wiimote_data *wdata, bool plugged)
+{
+	if (!wdata->ext)
+		return;
+
+	if (wdata->ext->plugged == plugged)
+		return;
+
+	wdata->ext->plugged = plugged;
+	/*
+	 * We need to call wiiext_schedule(wdata->ext) here, however, the
+	 * extension initialization logic is not fully understood and so
+	 * automatic initialization is not supported, yet.
+	 */
+}
+
+/*
+ * Returns true if the current DRM mode should contain extension data and false
+ * if there is no interest in extension data.
+ * All supported extensions send 6 byte extension data so any DRM that contains
+ * extension bytes is fine.
+ * The caller must hold the state.lock spinlock.
+ */
+bool wiiext_active(struct wiimote_data *wdata)
+{
+	if (!wdata->ext)
+		return false;
+
+	return wdata->ext->motionp || wdata->ext->ext_type;
+}
+
+/* Initializes the extension driver of a wiimote */
+int wiiext_init(struct wiimote_data *wdata)
+{
+	struct wiimote_ext *ext;
+	unsigned long flags;
+
+	ext = kzalloc(sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	ext->wdata = wdata;
+	INIT_WORK(&ext->worker, wiiext_worker);
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->ext = ext;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+/* Deinitializes the extension driver of a wiimote */
+void wiiext_deinit(struct wiimote_data *wdata)
+{
+	struct wiimote_ext *ext = wdata->ext;
+	unsigned long flags;
+
+	if (!ext)
+		return;
+
+	/*
+	 * We first unset wdata->ext to avoid further input from the wiimote
+	 * core. The worker thread does not access this pointer so it is not
+	 * affected by this.
+	 * We kill the worker after this so it does not get respawned during
+	 * deinitialization.
+	 */
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->ext = NULL;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	cancel_work_sync(&ext->worker);
+	kfree(ext);
+}
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 865740d..abbfab8 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -73,6 +73,7 @@ struct wiimote_data {
 	struct input_dev *accel;
 	struct input_dev *ir;
 	struct power_supply battery;
+	struct wiimote_ext *ext;
 
 	spinlock_t qlock;
 	__u8 head;
@@ -118,6 +119,22 @@ extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
 							__u8 *rmem, __u8 size);
 
+#ifdef CONFIG_HID_WIIMOTE_EXT
+
+extern int wiiext_init(struct wiimote_data *wdata);
+extern void wiiext_deinit(struct wiimote_data *wdata);
+extern void wiiext_event(struct wiimote_data *wdata, bool plugged);
+extern bool wiiext_active(struct wiimote_data *wdata);
+
+#else
+
+static inline int wiiext_init(void *u) { return 0; }
+static inline void wiiext_deinit(void *u) { }
+static inline void wiiext_event(void *u, bool p) { }
+static inline bool wiiext_active(void *u) { return false; }
+
+#endif
+
 /* requires the state.lock spinlock to be held */
 static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
 								__u32 opt)
-- 
1.7.7.3

