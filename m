From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 6/6] Input - surface3_button_array: Introduce button support for the Surface 3
Date: Fri, 13 May 2016 18:05:54 +0200
Message-ID: <1463155554-11747-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36383 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbcEMQGJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 12:06:09 -0400
In-Reply-To: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>

The Surface 3 is not following the ACPI spec for PNP0C40, but nearly.
The device is connected to a I2C device that might have some magic
but we don't know about.
Just create the device after the enumeration and use the declared GPIOs
to provide button support.

The Surface Pro 3 is using an ACPI driver and matches against the bid
of the device ("VGBI") but I think it also could use this. To prevent
this driver to be used on the Surface Pro, we add a match on the
Surface 3 bid "TEV2".

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
new in v2

 drivers/input/misc/Kconfig                 |   9 +++
 drivers/input/misc/Makefile                |   1 +
 drivers/input/misc/surface3_button_array.c | 115 +++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/input/misc/surface3_button_array.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1f2337a..17c2205 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -762,6 +762,15 @@ config INPUT_SOC_BUTTON_ARRAY
 	  To compile this driver as a module, choose M here: the
 	  module will be called soc_button_array.
 
+config INPUT_SURFACE3_BUTTON_ARRAY
+	tristate "Microsoft Surface 3 SoC Button Array"
+	depends on INPUT_SOC_BUTTON_ARRAY
+	help
+	  Say Y here if you have a MS Surface tablet.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called surface3_button_array.
+
 config INPUT_DRV260X_HAPTICS
 	tristate "TI DRV260X haptics support"
 	depends on INPUT && I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 0357a08..1624a23 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
+obj-$(CONFIG_INPUT_SURFACE3_BUTTON_ARRAY)	+= surface3_button_array.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
diff --git a/drivers/input/misc/surface3_button_array.c b/drivers/input/misc/surface3_button_array.c
new file mode 100644
index 0000000..b48307c
--- /dev/null
+++ b/drivers/input/misc/surface3_button_array.c
@@ -0,0 +1,115 @@
+/*
+ * Supports for the button array on the Surface tablets.
+ *
+ * (C) Copyright 2016 Red Hat, Inc
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/input/soc_button_array.h>
+#include <uapi/linux/input-event-codes.h>
+
+struct soc_device_info {
+	const char * const *obj_names;
+	struct soc_button_info *buttons;
+};
+
+static int surface3_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	const char *bid, *obj_name;
+	struct soc_device_info *device_info;
+	struct soc_button_data *priv;
+	int error;
+	int i;
+
+	if (!id->driver_data)
+		return -EINVAL;
+
+	device_info = (struct soc_device_info *)id->driver_data;
+
+	if (device_info->obj_names) {
+		bid = acpi_device_bid(ACPI_COMPANION(&client->dev));
+		i = 0;
+		do {
+			obj_name = device_info->obj_names[i++];
+			if (obj_name && !strcmp(bid, obj_name))
+				break;
+		} while (obj_name);
+		/* no acpi_device_bid match, bail out */
+		if (!obj_name)
+			return -ENODEV;
+	}
+
+	priv = soc_dev_button_data_allocate(&client->dev);
+	if (!priv)
+		return -ENOMEM;
+
+	error = soc_dev_button_enumerate(&client->dev, priv, NULL,
+					 device_info->buttons);
+	if (error)
+		return error;
+
+	i2c_set_clientdata(client, priv);
+
+	return 0;
+}
+
+static int surface3_remove(struct i2c_client *client)
+{
+	return soc_dev_button_remove(i2c_get_clientdata(client));
+}
+
+static struct soc_button_info soc_button_surface3[] = {
+	{ "power", 0, EV_KEY, KEY_POWER, false, true, true },
+	{ "home", 1, EV_KEY, KEY_LEFTMETA, false, true, false },
+	{ "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false, true },
+	{ "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false, true },
+	{ }
+};
+
+static const char * const soc_device_obj_names_surface3[] = {
+	"TEV2",
+	0,
+};
+
+static const struct soc_device_info soc_device_surface3 = {
+	.obj_names = soc_device_obj_names_surface3,
+	.buttons = soc_button_surface3,
+};
+
+static const struct i2c_device_id surface3_id[] = {
+	{ "MSHW0028:00", (unsigned long)&soc_device_surface3 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, surface3_id);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id surface3_acpi_match[] = {
+	{ "MSHW0028", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, surface3_acpi_match);
+#endif
+
+static struct i2c_driver surface3_driver = {
+	.probe = surface3_probe,
+	.remove = surface3_remove,
+	.id_table = surface3_id,
+	.driver = {
+		.name = "surface3",
+		.acpi_match_table = ACPI_PTR(surface3_acpi_match),
+	},
+};
+module_i2c_driver(surface3_driver);
+
+MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
+MODULE_DESCRIPTION("surface3 button array driver");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0

