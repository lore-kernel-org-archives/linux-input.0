From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 02/17] HID: wiimote: Move common symbols into header
Date: Thu, 17 Nov 2011 14:11:59 +0100
Message-ID: <1321535534-7950-3-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQNMy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:12:54 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873323eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:12:54 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

Wiimote extension and sound support need access to several symbols so move them
into a new header.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c |  134 +--------------------------------
 drivers/hid/hid-wiimote.h      |  163 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 131 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote.h

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 76739c0..c955d50 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -20,91 +20,9 @@
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
 #include "hid-ids.h"
+#include "hid-wiimote.h"
 
 #define WIIMOTE_VERSION "0.2"
-#define WIIMOTE_NAME "Nintendo Wii Remote"
-#define WIIMOTE_BUFSIZE 32
-
-struct wiimote_buf {
-	__u8 data[HID_MAX_BUFFER_SIZE];
-	size_t size;
-};
-
-struct wiimote_state {
-	spinlock_t lock;
-	__u8 flags;
-	__u8 accel_split[2];
-
-	/* synchronous cmd requests */
-	struct mutex sync;
-	struct completion ready;
-	int cmd;
-	__u32 opt;
-
-	/* results of synchronous requests */
-	__u8 cmd_battery;
-	__u8 cmd_err;
-};
-
-struct wiimote_data {
-	struct hid_device *hdev;
-	struct input_dev *input;
-	struct led_classdev *leds[4];
-	struct input_dev *accel;
-	struct input_dev *ir;
-	struct power_supply battery;
-
-	spinlock_t qlock;
-	__u8 head;
-	__u8 tail;
-	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
-	struct work_struct worker;
-
-	struct wiimote_state state;
-};
-
-#define WIIPROTO_FLAG_LED1		0x01
-#define WIIPROTO_FLAG_LED2		0x02
-#define WIIPROTO_FLAG_LED3		0x04
-#define WIIPROTO_FLAG_LED4		0x08
-#define WIIPROTO_FLAG_RUMBLE		0x10
-#define WIIPROTO_FLAG_ACCEL		0x20
-#define WIIPROTO_FLAG_IR_BASIC		0x40
-#define WIIPROTO_FLAG_IR_EXT		0x80
-#define WIIPROTO_FLAG_IR_FULL		0xc0 /* IR_BASIC | IR_EXT */
-#define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
-					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
-#define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT | \
-							WIIPROTO_FLAG_IR_FULL)
-
-/* return flag for led \num */
-#define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
-
-enum wiiproto_reqs {
-	WIIPROTO_REQ_NULL = 0x0,
-	WIIPROTO_REQ_RUMBLE = 0x10,
-	WIIPROTO_REQ_LED = 0x11,
-	WIIPROTO_REQ_DRM = 0x12,
-	WIIPROTO_REQ_IR1 = 0x13,
-	WIIPROTO_REQ_SREQ = 0x15,
-	WIIPROTO_REQ_WMEM = 0x16,
-	WIIPROTO_REQ_RMEM = 0x17,
-	WIIPROTO_REQ_IR2 = 0x1a,
-	WIIPROTO_REQ_STATUS = 0x20,
-	WIIPROTO_REQ_DATA = 0x21,
-	WIIPROTO_REQ_RETURN = 0x22,
-	WIIPROTO_REQ_DRM_K = 0x30,
-	WIIPROTO_REQ_DRM_KA = 0x31,
-	WIIPROTO_REQ_DRM_KE = 0x32,
-	WIIPROTO_REQ_DRM_KAI = 0x33,
-	WIIPROTO_REQ_DRM_KEE = 0x34,
-	WIIPROTO_REQ_DRM_KAE = 0x35,
-	WIIPROTO_REQ_DRM_KIE = 0x36,
-	WIIPROTO_REQ_DRM_KAIE = 0x37,
-	WIIPROTO_REQ_DRM_E = 0x3d,
-	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
-	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
-};
 
 enum wiiproto_keys {
 	WIIPROTO_KEY_LEFT,
@@ -139,52 +57,6 @@ static enum power_supply_property wiimote_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY
 };
 
-/* requires the state.lock spinlock to be held */
-static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
-								__u32 opt)
-{
-	return wdata->state.cmd == cmd && wdata->state.opt == opt;
-}
-
-/* requires the state.lock spinlock to be held */
-static inline void wiimote_cmd_complete(struct wiimote_data *wdata)
-{
-	wdata->state.cmd = WIIPROTO_REQ_NULL;
-	complete(&wdata->state.ready);
-}
-
-static inline int wiimote_cmd_acquire(struct wiimote_data *wdata)
-{
-	return mutex_lock_interruptible(&wdata->state.sync) ? -ERESTARTSYS : 0;
-}
-
-/* requires the state.lock spinlock to be held */
-static inline void wiimote_cmd_set(struct wiimote_data *wdata, int cmd,
-								__u32 opt)
-{
-	INIT_COMPLETION(wdata->state.ready);
-	wdata->state.cmd = cmd;
-	wdata->state.opt = opt;
-}
-
-static inline void wiimote_cmd_release(struct wiimote_data *wdata)
-{
-	mutex_unlock(&wdata->state.sync);
-}
-
-static inline int wiimote_cmd_wait(struct wiimote_data *wdata)
-{
-	int ret;
-
-	ret = wait_for_completion_interruptible_timeout(&wdata->state.ready, HZ);
-	if (ret < 0)
-		return -ERESTARTSYS;
-	else if (ret == 0)
-		return -EIO;
-	else
-		return 0;
-}
-
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 								size_t count)
 {
@@ -347,7 +219,7 @@ static __u8 select_drm(struct wiimote_data *wdata)
 	}
 }
 
-static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
+void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 {
 	__u8 cmd[3];
 
@@ -441,7 +313,7 @@ static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
 }
 
 /* requries the cmd-mutex to be held */
-static int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
+int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size)
 {
 	unsigned long flags;
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
new file mode 100644
index 0000000..d78f79c
--- /dev/null
+++ b/drivers/hid/hid-wiimote.h
@@ -0,0 +1,163 @@
+#ifndef __HID_WIIMOTE_H
+#define __HID_WIIMOTE_H
+
+/*
+ * HID driver for Nintendo Wiimote devices
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
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/spinlock.h>
+
+#define WIIMOTE_NAME "Nintendo Wii Remote"
+#define WIIMOTE_BUFSIZE 32
+
+#define WIIPROTO_FLAG_LED1		0x01
+#define WIIPROTO_FLAG_LED2		0x02
+#define WIIPROTO_FLAG_LED3		0x04
+#define WIIPROTO_FLAG_LED4		0x08
+#define WIIPROTO_FLAG_RUMBLE		0x10
+#define WIIPROTO_FLAG_ACCEL		0x20
+#define WIIPROTO_FLAG_IR_BASIC		0x40
+#define WIIPROTO_FLAG_IR_EXT		0x80
+#define WIIPROTO_FLAG_IR_FULL		0xc0 /* IR_BASIC | IR_EXT */
+#define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
+					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
+#define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT | \
+							WIIPROTO_FLAG_IR_FULL)
+
+/* return flag for led \num */
+#define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
+
+struct wiimote_buf {
+	__u8 data[HID_MAX_BUFFER_SIZE];
+	size_t size;
+};
+
+struct wiimote_state {
+	spinlock_t lock;
+	__u8 flags;
+	__u8 accel_split[2];
+
+	/* synchronous cmd requests */
+	struct mutex sync;
+	struct completion ready;
+	int cmd;
+	__u32 opt;
+
+	/* results of synchronous requests */
+	__u8 cmd_battery;
+	__u8 cmd_err;
+};
+
+struct wiimote_data {
+	struct hid_device *hdev;
+	struct input_dev *input;
+	struct led_classdev *leds[4];
+	struct input_dev *accel;
+	struct input_dev *ir;
+	struct power_supply battery;
+
+	spinlock_t qlock;
+	__u8 head;
+	__u8 tail;
+	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
+	struct work_struct worker;
+
+	struct wiimote_state state;
+};
+
+enum wiiproto_reqs {
+	WIIPROTO_REQ_NULL = 0x0,
+	WIIPROTO_REQ_RUMBLE = 0x10,
+	WIIPROTO_REQ_LED = 0x11,
+	WIIPROTO_REQ_DRM = 0x12,
+	WIIPROTO_REQ_IR1 = 0x13,
+	WIIPROTO_REQ_SREQ = 0x15,
+	WIIPROTO_REQ_WMEM = 0x16,
+	WIIPROTO_REQ_RMEM = 0x17,
+	WIIPROTO_REQ_IR2 = 0x1a,
+	WIIPROTO_REQ_STATUS = 0x20,
+	WIIPROTO_REQ_DATA = 0x21,
+	WIIPROTO_REQ_RETURN = 0x22,
+	WIIPROTO_REQ_DRM_K = 0x30,
+	WIIPROTO_REQ_DRM_KA = 0x31,
+	WIIPROTO_REQ_DRM_KE = 0x32,
+	WIIPROTO_REQ_DRM_KAI = 0x33,
+	WIIPROTO_REQ_DRM_KEE = 0x34,
+	WIIPROTO_REQ_DRM_KAE = 0x35,
+	WIIPROTO_REQ_DRM_KIE = 0x36,
+	WIIPROTO_REQ_DRM_KAIE = 0x37,
+	WIIPROTO_REQ_DRM_E = 0x3d,
+	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
+	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
+};
+
+#define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
+									dev))
+
+extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
+extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
+						const __u8 *wmem, __u8 size);
+
+/* requires the state.lock spinlock to be held */
+static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
+								__u32 opt)
+{
+	return wdata->state.cmd == cmd && wdata->state.opt == opt;
+}
+
+/* requires the state.lock spinlock to be held */
+static inline void wiimote_cmd_complete(struct wiimote_data *wdata)
+{
+	wdata->state.cmd = WIIPROTO_REQ_NULL;
+	complete(&wdata->state.ready);
+}
+
+static inline int wiimote_cmd_acquire(struct wiimote_data *wdata)
+{
+	return mutex_lock_interruptible(&wdata->state.sync) ? -ERESTARTSYS : 0;
+}
+
+/* requires the state.lock spinlock to be held */
+static inline void wiimote_cmd_set(struct wiimote_data *wdata, int cmd,
+								__u32 opt)
+{
+	INIT_COMPLETION(wdata->state.ready);
+	wdata->state.cmd = cmd;
+	wdata->state.opt = opt;
+}
+
+static inline void wiimote_cmd_release(struct wiimote_data *wdata)
+{
+	mutex_unlock(&wdata->state.sync);
+}
+
+static inline int wiimote_cmd_wait(struct wiimote_data *wdata)
+{
+	int ret;
+
+	ret = wait_for_completion_interruptible_timeout(&wdata->state.ready, HZ);
+	if (ret < 0)
+		return -ERESTARTSYS;
+	else if (ret == 0)
+		return -EIO;
+	else
+		return 0;
+}
+
+#endif
-- 
1.7.7.3

