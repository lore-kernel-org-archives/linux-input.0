From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when stopped
Date: Mon,  3 Aug 2015 16:23:10 +0100
Message-ID: <1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:48101 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754238AbbHCPcs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:48 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

The hardcoded 0x83 CTRL setting overrides other settings in that byte,
enabling extra reporting that may not be useful on a particular platform.

Implement improved suspend mechanism via deep sleep. By writing zero to
both the active and idle cycle times the maXTouch device can be put into a
deep sleep mode, using minimal power. It is necessary to issue a calibrate
command after the chip has spent any time in deep sleep, however a soft
reset is unnecessary.

Use the old method on Chromebook Pixel via platform data option.

This patch also deals with the situation where the power configuration is
zero on probe, which would mean that the device never wakes up to execute
commands.

After a config download, the T7 power configuration may have changed so it
is necessary to re-read it.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
---
 .../devicetree/bindings/input/atmel,maxtouch.txt   |   5 +
 MAINTAINERS                                        |   2 +
 drivers/input/touchscreen/atmel_mxt_ts.c           | 120 +++++++++++++++++++--
 drivers/platform/chrome/chromeos_laptop.c          |   4 +-
 include/dt-bindings/input/atmel_mxt_ts.h           |  21 ++++
 include/linux/i2c/atmel_mxt_ts.h                   |  25 -----
 include/linux/platform_data/atmel_mxt_ts.h         |  27 +++++
 7 files changed, 167 insertions(+), 37 deletions(-)
 create mode 100644 include/dt-bindings/input/atmel_mxt_ts.h
 delete mode 100644 include/linux/i2c/atmel_mxt_ts.h
 create mode 100644 include/linux/platform_data/atmel_mxt_ts.h

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 1852906..1040371 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -22,6 +22,11 @@ Optional properties for main touchpad device:
     experiment to determine which bit corresponds to which input. Use
     KEY_RESERVED for unused padding values.
 
+- atmel,suspend-mode: Select method used to suspend:
+    MXT_SUSPEND_DEEP_SLEEP - use T7 to suspend the device into deep sleep
+    MXT_SUSPEND_T9_CTRL - use T9.CTRL to turn off touch processing
+    Definitions are in <dt-bindings/input/atmel_mxt_ts.h>.
+
 Example:
 
 	touch@4b {
diff --git a/MAINTAINERS b/MAINTAINERS
index d2409bf..c816a87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,6 +1920,8 @@ M:	Nick Dyer <nick.dyer@itdev.co.uk>
 T:	git git://github.com/atmel-maxtouch/linux.git
 S:	Supported
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
+F:	include/dt-bindings/input/atmel_mxt_ts.h
+F:	include/linux/platform_data/atmel_mxt_ts.h
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 8efe7a0..f2bdcdb 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -22,7 +22,7 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
-#include <linux/i2c/atmel_mxt_ts.h>
+#include <linux/platform_data/atmel_mxt_ts.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -103,9 +103,13 @@
 #define MXT_T6_STATUS_COMSERR	(1 << 2)
 
 /* MXT_GEN_POWER_T7 field */
-#define MXT_POWER_IDLEACQINT	0
-#define MXT_POWER_ACTVACQINT	1
-#define MXT_POWER_ACTV2IDLETO	2
+struct t7_config {
+	u8 idle;
+	u8 active;
+} __packed;
+
+#define MXT_POWER_CFG_RUN		0
+#define MXT_POWER_CFG_DEEPSLEEP		1
 
 /* MXT_GEN_ACQUIRE_T8 field */
 #define MXT_ACQUIRE_CHRGTIME	0
@@ -117,7 +121,7 @@
 #define MXT_ACQUIRE_ATCHCALSTHR	7
 
 /* MXT_TOUCH_MULTI_T9 field */
-#define MXT_TOUCH_CTRL		0
+#define MXT_T9_CTRL		0
 #define MXT_T9_ORIENT		9
 #define MXT_T9_RANGE		18
 
@@ -291,6 +295,7 @@ struct mxt_data {
 	u8 last_message_count;
 	u8 num_touchids;
 	u8 multitouch;
+	struct t7_config t7_cfg;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -1361,6 +1366,8 @@ static int mxt_upload_cfg_mem(struct mxt_data *data, unsigned int cfg_start,
 	return 0;
 }
 
+static int mxt_init_t7_power_cfg(struct mxt_data *data);
+
 /*
  * mxt_update_cfg - download configuration to chip
  *
@@ -1508,6 +1515,9 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 
 	dev_info(dev, "Config successfully updated\n");
 
+	/* T7 config may have changed */
+	mxt_init_t7_power_cfg(data);
+
 release_mem:
 	kfree(config_mem);
 	return ret;
@@ -2051,6 +2061,60 @@ err_free_object_table:
 	return error;
 }
 
+static int mxt_set_t7_power_cfg(struct mxt_data *data, u8 sleep)
+{
+	struct device *dev = &data->client->dev;
+	int error;
+	struct t7_config *new_config;
+	struct t7_config deepsleep = { .active = 0, .idle = 0 };
+
+	if (sleep == MXT_POWER_CFG_DEEPSLEEP)
+		new_config = &deepsleep;
+	else
+		new_config = &data->t7_cfg;
+
+	error = __mxt_write_reg(data->client, data->T7_address,
+				sizeof(data->t7_cfg), new_config);
+	if (error)
+		return error;
+
+	dev_dbg(dev, "Set T7 ACTV:%d IDLE:%d\n",
+		new_config->active, new_config->idle);
+
+	return 0;
+}
+
+static int mxt_init_t7_power_cfg(struct mxt_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int error;
+	bool retry = false;
+
+recheck:
+	error = __mxt_read_reg(data->client, data->T7_address,
+				sizeof(data->t7_cfg), &data->t7_cfg);
+	if (error)
+		return error;
+
+	if (data->t7_cfg.active == 0 || data->t7_cfg.idle == 0) {
+		if (!retry) {
+			dev_dbg(dev, "T7 cfg zero, resetting\n");
+			mxt_soft_reset(data);
+			retry = true;
+			goto recheck;
+		} else {
+			dev_dbg(dev, "T7 cfg zero after reset, overriding\n");
+			data->t7_cfg.active = 20;
+			data->t7_cfg.idle = 100;
+			return mxt_set_t7_power_cfg(data, MXT_POWER_CFG_RUN);
+		}
+	}
+
+	dev_dbg(dev, "Initialized power cfg: ACTV %d, IDLE %d\n",
+		data->t7_cfg.active, data->t7_cfg.idle);
+	return 0;
+}
+
 static int mxt_configure_objects(struct mxt_data *data,
 				 const struct firmware *cfg)
 {
@@ -2058,6 +2122,12 @@ static int mxt_configure_objects(struct mxt_data *data,
 	struct mxt_info *info = &data->info;
 	int error;
 
+	error = mxt_init_t7_power_cfg(data);
+	if (error) {
+		dev_err(dev, "Failed to initialize power cfg\n");
+		return error;
+	}
+
 	if (cfg) {
 		error = mxt_update_cfg(data, cfg);
 		if (error)
@@ -2346,14 +2416,41 @@ static const struct attribute_group mxt_attr_group = {
 
 static void mxt_start(struct mxt_data *data)
 {
-	/* Touch enable */
-	mxt_write_object(data, data->multitouch, MXT_TOUCH_CTRL, 0x83);
+	switch (data->pdata->suspend_mode) {
+	case MXT_SUSPEND_T9_CTRL:
+		mxt_soft_reset(data);
+
+		/* Touch enable */
+		/* 0x83 = SCANEN | RPTEN | ENABLE */
+		mxt_write_object(data,
+				MXT_TOUCH_MULTI_T9, MXT_T9_CTRL, 0x83);
+		break;
+
+	case MXT_SUSPEND_DEEP_SLEEP:
+	default:
+		mxt_set_t7_power_cfg(data, MXT_POWER_CFG_RUN);
+
+		/* Recalibrate since chip has been in deep sleep */
+		mxt_t6_command(data, MXT_COMMAND_CALIBRATE, 1, false);
+		break;
+	}
+
 }
 
 static void mxt_stop(struct mxt_data *data)
 {
-	/* Touch disable */
-	mxt_write_object(data, data->multitouch, MXT_TOUCH_CTRL, 0);
+	switch (data->pdata->suspend_mode) {
+	case MXT_SUSPEND_T9_CTRL:
+		/* Touch disable */
+		mxt_write_object(data,
+				MXT_TOUCH_MULTI_T9, MXT_T9_CTRL, 0);
+		break;
+
+	case MXT_SUSPEND_DEEP_SLEEP:
+	default:
+		mxt_set_t7_power_cfg(data, MXT_POWER_CFG_DEEPSLEEP);
+		break;
+	}
 }
 
 static int mxt_input_open(struct input_dev *dev)
@@ -2409,6 +2506,9 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 		pdata->t19_keymap = keymap;
 	}
 
+	of_property_read_u32(client->dev.of_node, "atmel,suspend-mode",
+			     &pdata->suspend_mode);
+
 	return pdata;
 }
 #else
@@ -2625,8 +2725,6 @@ static int __maybe_unused mxt_resume(struct device *dev)
 	struct mxt_data *data = i2c_get_clientdata(client);
 	struct input_dev *input_dev = data->input_dev;
 
-	mxt_soft_reset(data);
-
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index a04019a..0207274 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -23,7 +23,7 @@
 
 #include <linux/dmi.h>
 #include <linux/i2c.h>
-#include <linux/i2c/atmel_mxt_ts.h>
+#include <linux/platform_data/atmel_mxt_ts.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -111,6 +111,7 @@ static struct mxt_platform_data atmel_224s_tp_platform_data = {
 	.irqflags		= IRQF_TRIGGER_FALLING,
 	.t19_num_keys		= ARRAY_SIZE(mxt_t19_keys),
 	.t19_keymap		= mxt_t19_keys,
+	.suspend_mode		= MXT_SUSPEND_T9_CTRL,
 };
 
 static struct i2c_board_info atmel_224s_tp_device = {
@@ -121,6 +122,7 @@ static struct i2c_board_info atmel_224s_tp_device = {
 
 static struct mxt_platform_data atmel_1664s_platform_data = {
 	.irqflags		= IRQF_TRIGGER_FALLING,
+	.suspend_mode		= MXT_SUSPEND_T9_CTRL,
 };
 
 static struct i2c_board_info atmel_1664s_device = {
diff --git a/include/dt-bindings/input/atmel_mxt_ts.h b/include/dt-bindings/input/atmel_mxt_ts.h
new file mode 100644
index 0000000..37a6ab1
--- /dev/null
+++ b/include/dt-bindings/input/atmel_mxt_ts.h
@@ -0,0 +1,21 @@
+/*
+ * Atmel maXTouch Touchscreen driver
+ *
+ * Copyright (C) 2015 Atmel Corporation
+ * Author: Nick Dyer <nick.dyer@itdev.co.uk>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_ATMEL_MXT_TS_H
+#define __DT_BINDINGS_ATMEL_MXT_TS_H
+
+enum mxt_suspend_mode {
+	MXT_SUSPEND_DEEP_SLEEP = 0,
+	MXT_SUSPEND_T9_CTRL = 1,
+};
+
+#endif /* __DT_BINDINGS_ATMEL_MXT_TS_H */
diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atmel_mxt_ts.h
deleted file mode 100644
index 02bf6ea..0000000
--- a/include/linux/i2c/atmel_mxt_ts.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Atmel maXTouch Touchscreen driver
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef __LINUX_ATMEL_MXT_TS_H
-#define __LINUX_ATMEL_MXT_TS_H
-
-#include <linux/types.h>
-
-/* The platform data for the Atmel maXTouch touchscreen driver */
-struct mxt_platform_data {
-	unsigned long irqflags;
-	u8 t19_num_keys;
-	const unsigned int *t19_keymap;
-};
-
-#endif /* __LINUX_ATMEL_MXT_TS_H */
diff --git a/include/linux/platform_data/atmel_mxt_ts.h b/include/linux/platform_data/atmel_mxt_ts.h
new file mode 100644
index 0000000..cabd838
--- /dev/null
+++ b/include/linux/platform_data/atmel_mxt_ts.h
@@ -0,0 +1,27 @@
+/*
+ * Atmel maXTouch Touchscreen driver
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H
+#define __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H
+
+#include <linux/types.h>
+#include <dt-bindings/input/atmel_mxt_ts.h>
+
+/* The platform data for the Atmel maXTouch touchscreen driver */
+struct mxt_platform_data {
+	unsigned long irqflags;
+	u8 t19_num_keys;
+	const unsigned int *t19_keymap;
+	enum mxt_suspend_mode suspend_mode;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H */
-- 
2.4.6

