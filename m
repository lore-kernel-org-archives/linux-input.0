From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 06/36]  [Driver][Qualcomm 1070][EC_BRG] EC Bridge driver porting
Date: Mon, 26 Jul 2010 16:30:15 +0800
Message-ID: <1280133045-25945-6-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51523 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab0GZIbD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:31:03 -0400
Received: by pvc7 with SMTP id 7so4320726pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:31:03 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 drivers/hwmon/Kconfig    |    8 ++
 drivers/hwmon/Makefile   |    1 +
 drivers/hwmon/wpce775x.c |  166 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/wpce775x.h |   30 ++++++++
 4 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100755 drivers/hwmon/wpce775x.c
 create mode 100755 include/linux/wpce775x.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83a283e..d652272 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1061,4 +1061,12 @@ config SENSORS_ISL29011
         help
           ISL29011 Light Sensor Driver implemented by Quanta.
 
+config SENSORS_WPCE775X
+  	tristate "Winbond WPCE775X"
+  	depends on I2C
+  	default n
+        help
+	  This driver provides support for the Winbond WPCE775XX Embedded
+	  Controller, which provides lcd backlight, LEDs, and Battery control.
+
 endif # HWMON
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 6237580..fb99aa8 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_ISL29011)  += isl29011.o
+obj-$(CONFIG_SENSORS_WPCE775X)  += wpce775x.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/wpce775x.c b/drivers/hwmon/wpce775x.c
new file mode 100755
index 0000000..dc296ea
--- /dev/null
+++ b/drivers/hwmon/wpce775x.c
@@ -0,0 +1,166 @@
+/* Quanta EC driver for the Winbond Embedded Controller
+ *
+ * Copyright (C) 2009 Quanta Computer Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+
+#define EC_ID_NAME          "qci-i2cec"
+#define EC_BUFFER_LEN		16
+#define EC_CMD_POWER_OFF	0xAC
+#define EC_CMD_RESTART	0xAB
+
+static struct i2c_client *g_i2cec_client;
+
+/* General structure to hold the driver data */
+struct i2cec_drv_data {
+		struct i2c_client *i2cec_client;
+		struct work_struct work;
+		char ec_data[EC_BUFFER_LEN+1];
+};
+
+static int __devinit wpce_probe(struct i2c_client *client,
+	const struct i2c_device_id *id);
+static int __devexit wpce_remove(struct i2c_client *kbd);
+
+#ifdef CONFIG_PM
+static int wpce_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int wpce_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static struct dev_pm_ops wpce_pm_ops = {
+	.suspend  = wpce_suspend,
+	.resume   = wpce_resume,
+};
+#endif
+
+static const struct i2c_device_id wpce_idtable[] = {
+       { EC_ID_NAME, 0 },
+       { }
+};
+
+static struct i2c_driver wpce_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name  = EC_ID_NAME,
+#ifdef CONFIG_PM
+		.pm = &wpce_pm_ops,
+#endif
+	},
+	.probe	  = wpce_probe,
+	.remove	  = __devexit_p(wpce_remove),
+	.id_table   = wpce_idtable,
+};
+
+static int __devinit wpce_probe(struct i2c_client *client,
+				    const struct i2c_device_id *id)
+{
+	int err = -ENOMEM;
+	struct i2cec_drv_data *context = 0;
+
+	/* there is no need to call i2c_check_functionality() since it is the
+	client's job to use the interface (I2C vs SMBUS) appropriate for it. */
+	client->driver = &wpce_driver;
+	context = kzalloc(sizeof(struct i2cec_drv_data), GFP_KERNEL);
+	if (!context)
+		return err;
+
+	context->i2cec_client = client;
+	g_i2cec_client = client;
+	i2c_set_clientdata(context->i2cec_client, context);
+
+	return 0;
+}
+
+static int __devexit wpce_remove(struct i2c_client *dev)
+{
+	struct i2cec_drv_data *context = i2c_get_clientdata(dev);
+	g_i2cec_client = NULL;
+	kfree(context);
+
+	return 0;
+}
+
+static int __init wpce_init(void)
+{
+	return i2c_add_driver(&wpce_driver);
+}
+
+static void __exit wpce_exit(void)
+{
+	i2c_del_driver(&wpce_driver);
+}
+
+struct i2c_client *wpce_get_i2c_client(void)
+{
+	return g_i2cec_client;
+}
+EXPORT_SYMBOL_GPL(wpce_get_i2c_client);
+
+void wpce_poweroff(void)
+{
+	if (g_i2cec_client == NULL)
+		return;
+	i2c_smbus_write_byte(g_i2cec_client, EC_CMD_POWER_OFF);
+}
+EXPORT_SYMBOL_GPL(wpce_poweroff);
+
+void wpce_restart(void)
+{
+	if (g_i2cec_client == NULL)
+		return;
+	i2c_smbus_write_byte(g_i2cec_client, EC_CMD_RESTART);
+}
+EXPORT_SYMBOL_GPL(wpce_restart);
+
+int wpce_i2c_transfer(struct i2c_msg *msg)
+{
+	if (g_i2cec_client == NULL)
+		return -1;
+	msg->addr = g_i2cec_client->addr;
+	return i2c_transfer(g_i2cec_client->adapter, msg, 1);
+}
+EXPORT_SYMBOL_GPL(wpce_i2c_transfer);
+
+int wpce_smbus_write_word_data(u8 command, u16 value)
+{
+	if (g_i2cec_client == NULL)
+		return -1;
+	return i2c_smbus_write_word_data(g_i2cec_client, command, value);
+}
+EXPORT_SYMBOL_GPL(wpce_smbus_write_word_data);
+
+int wpce_smbus_write_byte_data(u8 command, u8 value)
+{
+	if (g_i2cec_client == NULL)
+		return -1;
+	return i2c_smbus_write_byte_data(g_i2cec_client, command, value);
+}
+EXPORT_SYMBOL_GPL(wpce_smbus_write_byte_data);
+
+module_init(wpce_init);
+module_exit(wpce_exit);
+
+MODULE_AUTHOR("Quanta Computer Inc.");
+MODULE_DESCRIPTION("Quanta Embedded Controller I2C Bridge Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/wpce775x.h b/include/linux/wpce775x.h
new file mode 100755
index 0000000..1803122
--- /dev/null
+++ b/include/linux/wpce775x.h
@@ -0,0 +1,30 @@
+/* Quanta EC driver for the Winbond Embedded Controller
+ *
+ * Copyright (C) 2009 Quanta Computer Inc.
+ * 
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef WPCE775X_DRV_H
+#define WPCE775X_DRV_H
+
+#include <linux/i2c.h>
+
+struct i2c_client *wpce_get_i2c_client(void);
+int wpce_smbus_write_word_data(u8 command, u16 value);
+struct i2c_client *wpce_get_i2c_client(void);
+void wpce_poweroff(void);
+void wpce_restart(void);
+int wpce_i2c_transfer(struct i2c_msg *msg);
+int wpce_smbus_write_word_data(u8 command, u16 value);
+int wpce_smbus_write_byte_data(u8 command, u8 value);
+
+#endif
-- 
1.7.0.4

