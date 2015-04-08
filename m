From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] Input: atmel_mxt_ts - allow specifying device-specific configs
Date: Tue,  7 Apr 2015 17:26:10 -0700
Message-ID: <1428452770-20767-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37730 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbbDHA01 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Apr 2015 20:26:27 -0400
In-Reply-To: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Olof Johansson <olof@lixom.net>

Atmel controolers are very flexible and to function optimally require
device-specific configuration to be loaded. While the configuration is
stored in NVRAM and is normally persistent, sometimes it gets corrupted
and needs to be reloaded.

Instead of using the same name, maxtouch.cfg, for all systems and all
devices, let's allow platform data to specify the name of configuration
file that should be loaded. This is especially useful for systems that
use Atmel controllers for both touchscren and touchpad, since their
configurations will surely differ.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/atmel,maxtouch.txt       |  6 ++++++
 drivers/input/touchscreen/atmel_mxt_ts.c               | 18 +++++++++++++-----
 include/linux/i2c/atmel_mxt_ts.h                       |  1 +
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 1852906..fd2344d 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -9,6 +9,12 @@ Required properties:
 - interrupts: The sink for the touchpad's IRQ output
     See ../interrupt-controller/interrupts.txt
 
+Optional properties:
+
+- linux,config-name: name of configuration file that should be loaded
+    into device for optimal functioning. If not specified "maxtouch.cfg"
+    will be used.
+
 Optional properties for main touchpad device:
 
 - linux,gpio-keymap: When enabled, the SPT_GPIOPWN_T19 object sends messages
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dfc7309..0dcd455 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2035,7 +2035,8 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		goto err_free_object_table;
 
-	error = request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
+	error = request_firmware_nowait(THIS_MODULE, true,
+					data->pdata->cfg_name ?: MXT_CFG_NAME,
 					&client->dev, GFP_KERNEL, data,
 					mxt_config_cb);
 	if (error) {
@@ -2375,20 +2376,21 @@ static void mxt_input_close(struct input_dev *dev)
 #ifdef CONFIG_OF
 static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 {
+	struct device_node *np;
 	struct mxt_platform_data *pdata;
 	u32 *keymap;
 	u32 keycode;
 	int proplen, i, ret;
 
-	if (!client->dev.of_node)
+	np = client->dev.of_node;
+	if (!np)
 		return ERR_PTR(-ENOENT);
 
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_find_property(client->dev.of_node, "linux,gpio-keymap",
-			     &proplen)) {
+	if (of_find_property(np, "linux,gpio-keymap", &proplen)) {
 		pdata->t19_num_keys = proplen / sizeof(u32);
 
 		keymap = devm_kzalloc(&client->dev,
@@ -2398,7 +2400,7 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 			return ERR_PTR(-ENOMEM);
 
 		for (i = 0; i < pdata->t19_num_keys; i++) {
-			ret = of_property_read_u32_index(client->dev.of_node,
+			ret = of_property_read_u32_index(np,
 					"linux,gpio-keymap", i, &keycode);
 			if (ret)
 				keycode = KEY_RESERVED;
@@ -2409,6 +2411,8 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 		pdata->t19_keymap = keymap;
 	}
 
+	of_property_read_string(np, "linux,config-name", &pdata->cfg_name);
+
 	return pdata;
 }
 #else
@@ -2439,11 +2443,15 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
 		.pdata	= {
 			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
 			.t19_keymap	= samus_touchpad_buttons,
+			.cfg_name	= "samus-337t.raw",
 		},
 	},
 	{
 		/* Touchscreen */
 		.hid	= "ATML0001",
+		.pdata	= {
+			.cfg_name	= "samus-2954t2.raw",
+		},
 	},
 	{ }
 };
diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atmel_mxt_ts.h
index 02bf6ea..aeb8c9a 100644
--- a/include/linux/i2c/atmel_mxt_ts.h
+++ b/include/linux/i2c/atmel_mxt_ts.h
@@ -20,6 +20,7 @@ struct mxt_platform_data {
 	unsigned long irqflags;
 	u8 t19_num_keys;
 	const unsigned int *t19_keymap;
+	const char *cfg_name;
 };
 
 #endif /* __LINUX_ATMEL_MXT_TS_H */
-- 
2.2.0.rc0.207.ga3a616c

