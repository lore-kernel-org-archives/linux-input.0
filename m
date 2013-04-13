From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 07/21] HID: wiimote: add sub-device module infrastructure
Date: Sat, 13 Apr 2013 12:47:48 +0200
Message-ID: <1365850082-3585-8-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:38167 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKsi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:38 -0400
Received: by mail-ea0-f181.google.com with SMTP id z10so1528786ead.12
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:37 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

To avoid loading all sub-device drivers for every Wii Remote, even though
the required hardware might not be available, we introduce a module layer.

The module layer specifies which sub-devices are available on each
device-type. After device detection, we only load the modules for the
detected device. If module loading fails, we unload everything and mark
the device as WIIMOTE_DEV_UNKNOWN. As long as a device is marked as
"unknown", no sub-devices will be used and the device is considered
unsupported.

All the different sub-devices, including KEYS, RUMBLE, BATTERY, LEDS,
ACCELEROMETER, IR and more will be ported in follow-up patches to the new
module layer.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/Makefile              |   2 +-
 drivers/hid/hid-wiimote-core.c    | 124 +++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-wiimote-modules.c |  45 ++++++++++++++
 drivers/hid/hid-wiimote.h         |  27 +++++++++
 4 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote-modules.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 2735151..6015af5 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -28,7 +28,7 @@ ifdef CONFIG_LOGIWHEELS_FF
 	hid-logitech-y	+= hid-lg4ff.o
 endif
 
-hid-wiimote-y		:= hid-wiimote-core.o
+hid-wiimote-y		:= hid-wiimote-core.o hid-wiimote-modules.o
 ifdef CONFIG_HID_WIIMOTE_EXT
 	hid-wiimote-y	+= hid-wiimote-ext.o
 endif
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 73969d4..5401c11 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -715,6 +715,124 @@ static void wiimote_ir_close(struct input_dev *dev)
 	wiimote_init_ir(wdata, 0);
 }
 
+/* device module handling */
+
+static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
+	[WIIMOTE_DEV_PENDING] = (const __u8[]){
+		WIIMOD_NULL,
+	},
+	[WIIMOTE_DEV_UNKNOWN] = (const __u8[]){
+		WIIMOD_NULL,
+	},
+	[WIIMOTE_DEV_GENERIC] = (const __u8[]){
+		WIIMOD_NULL,
+	},
+	[WIIMOTE_DEV_GEN10] = (const __u8[]){
+		WIIMOD_NULL,
+	},
+	[WIIMOTE_DEV_GEN20] = (const __u8[]){
+		WIIMOD_NULL,
+	},
+};
+
+static void wiimote_modules_load(struct wiimote_data *wdata,
+				 unsigned int devtype)
+{
+	bool need_input = false;
+	const __u8 *mods, *iter;
+	const struct wiimod_ops *ops;
+	int ret;
+
+	mods = wiimote_devtype_mods[devtype];
+
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
+		if (wiimod_table[*iter]->flags & WIIMOD_FLAG_INPUT) {
+			need_input = true;
+			break;
+		}
+	}
+
+	if (need_input) {
+		wdata->input = input_allocate_device();
+		if (!wdata->input)
+			return;
+
+		input_set_drvdata(wdata->input, wdata);
+		wdata->input->dev.parent = &wdata->hdev->dev;
+		wdata->input->id.bustype = wdata->hdev->bus;
+		wdata->input->id.vendor = wdata->hdev->vendor;
+		wdata->input->id.product = wdata->hdev->product;
+		wdata->input->id.version = wdata->hdev->version;
+		wdata->input->name = WIIMOTE_NAME;
+	}
+
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
+		ops = wiimod_table[*iter];
+		if (!ops->probe)
+			continue;
+
+		ret = ops->probe(ops, wdata);
+		if (ret)
+			goto error;
+	}
+
+	if (wdata->input) {
+		ret = input_register_device(wdata->input);
+		if (ret)
+			goto error;
+	}
+
+	spin_lock_irq(&wdata->state.lock);
+	wdata->state.devtype = devtype;
+	spin_unlock_irq(&wdata->state.lock);
+	return;
+
+error:
+	for ( ; iter-- != mods; ) {
+		ops = wiimod_table[*iter];
+		if (ops->remove)
+			ops->remove(ops, wdata);
+	}
+
+	if (wdata->input) {
+		input_free_device(wdata->input);
+		wdata->input = NULL;
+	}
+}
+
+static void wiimote_modules_unload(struct wiimote_data *wdata)
+{
+	const __u8 *mods, *iter;
+	const struct wiimod_ops *ops;
+	unsigned long flags;
+
+	mods = wiimote_devtype_mods[wdata->state.devtype];
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.devtype = WIIMOTE_DEV_UNKNOWN;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	/* find end of list */
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter)
+		/* empty */ ;
+
+	if (wdata->input) {
+		input_get_device(wdata->input);
+		input_unregister_device(wdata->input);
+	}
+
+	for ( ; iter-- != mods; ) {
+		ops = wiimod_table[*iter];
+		if (ops->remove)
+			ops->remove(ops, wdata);
+	}
+
+	if (wdata->input) {
+		input_put_device(wdata->input);
+		wdata->input = NULL;
+	}
+}
+
 /* device (re-)initialization and detection */
 
 static const char *wiimote_devtype_names[WIIMOTE_DEV_NUM] = {
@@ -766,9 +884,7 @@ done:
 		hid_info(wdata->hdev, "detected device: %s\n",
 			 wiimote_devtype_names[devtype]);
 
-	spin_lock_irq(&wdata->state.lock);
-	wdata->state.devtype = devtype;
-	spin_unlock_irq(&wdata->state.lock);
+	wiimote_modules_load(wdata, devtype);
 }
 
 static void wiimote_init_detect(struct wiimote_data *wdata)
@@ -780,6 +896,7 @@ static void wiimote_init_detect(struct wiimote_data *wdata)
 	wiimote_cmd_acquire_noint(wdata);
 
 	spin_lock_irq(&wdata->state.lock);
+	wdata->state.devtype = WIIMOTE_DEV_UNKNOWN;
 	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
 	wiiproto_req_status(wdata);
 	spin_unlock_irq(&wdata->state.lock);
@@ -1313,6 +1430,7 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	wiiext_deinit(wdata);
 	wiimote_leds_destroy(wdata);
 
+	wiimote_modules_unload(wdata);
 	power_supply_unregister(&wdata->battery);
 	kfree(wdata->battery.name);
 	input_unregister_device(wdata->accel);
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
new file mode 100644
index 0000000..5dcdd23
--- /dev/null
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -0,0 +1,45 @@
+/*
+ * Device Modules for Nintendo Wii / Wii U HID Driver
+ * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+/*
+ * Wiimote Modules
+ * Nintendo devices provide different peripherals and many new devices lack
+ * initial features like the IR camera. Therefore, each peripheral device is
+ * implemented as an independent module and we probe on each device only the
+ * modules for the hardware that really is available.
+ *
+ * Module registration is sequential. Unregistration is done in reverse order.
+ * After device detection, the needed modules are loaded. Users can trigger
+ * re-detection which causes all modules to be unloaded and then reload the
+ * modules for the new detected device.
+ *
+ * wdata->input is a shared input device. It is always initialized prior to
+ * module registration. If at least one registered module is marked as
+ * WIIMOD_FLAG_INPUT, then the input device will get registered after all
+ * modules were registered.
+ * Please note that it is unregistered _before_ the "remove" callbacks are
+ * called. This guarantees that no input interaction is done, anymore. However,
+ * the wiimote core keeps a reference to the input device so it is freed only
+ * after all modules were removed. It is safe to send events to unregistered
+ * input devices.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/spinlock.h>
+#include "hid-wiimote.h"
+
+/* module table */
+
+const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
+};
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 74b7a47..d0df93b 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -108,6 +108,33 @@ struct wiimote_data {
 	struct work_struct init_worker;
 };
 
+/* wiimote modules */
+
+enum wiimod_module {
+	WIIMOD_NUM,
+	WIIMOD_NULL = WIIMOD_NUM,
+};
+
+#define WIIMOD_FLAG_INPUT		0x0001
+
+struct wiimod_ops {
+	__u16 flags;
+	unsigned long arg;
+	int (*probe) (const struct wiimod_ops *ops,
+		      struct wiimote_data *wdata);
+	void (*remove) (const struct wiimod_ops *ops,
+			struct wiimote_data *wdata);
+
+	void (*in_keys) (struct wiimote_data *wdata, const __u8 *keys);
+	void (*in_accel) (struct wiimote_data *wdata, const __u8 *accel);
+	void (*in_ir) (struct wiimote_data *wdata, const __u8 *ir, bool packed,
+		       unsigned int id);
+};
+
+extern const struct wiimod_ops *wiimod_table[WIIMOD_NUM];
+
+/* wiimote requests */
+
 enum wiiproto_reqs {
 	WIIPROTO_REQ_NULL = 0x0,
 	WIIPROTO_REQ_RUMBLE = 0x10,
-- 
1.8.2.1

