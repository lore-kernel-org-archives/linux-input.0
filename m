From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 3/4] Input: tsc2004 - Add support for tsc2004
Date: Fri, 30 Oct 2015 19:41:25 -0500
Message-ID: <1446252086-24334-4-git-send-email-mwelling@ieee.org>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-input@vger.kernel.org

Adds support for the i2c based tsc2004.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/input/touchscreen/Kconfig   | 13 ++++++
 drivers/input/touchscreen/Makefile  |  1 +
 drivers/input/touchscreen/tsc2004.c | 86 +++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/input/touchscreen/tsc2004.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 6a5878b..ae33da7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -942,6 +942,19 @@ config TOUCHSCREEN_TSC_SERIO
 config TOUCHSCREEN_TSC200X_CORE
 	tristate
 
+config TOUCHSCREEN_TSC2004
+	tristate "TSC2004 based touchscreens"
+	depends on I2C
+	select REGMAP_I2C
+	select TOUCHSCREEN_TSC200X_CORE
+	help
+	  Say Y here if you have a TSC2004 based touchscreen.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2004.
+
 config TOUCHSCREEN_TSC2005
 	tristate "TSC2005 based touchscreens"
 	depends on SPI_MASTER
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 03179f2..cbaa6ab 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
 obj-$(CONFIG_TOUCHSCREEN_TSC200X_CORE)	+= tsc200x-core.o
+obj-$(CONFIG_TOUCHSCREEN_TSC2004)	+= tsc2004.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
diff --git a/drivers/input/touchscreen/tsc2004.c b/drivers/input/touchscreen/tsc2004.c
new file mode 100644
index 0000000..d2f7a6b
--- /dev/null
+++ b/drivers/input/touchscreen/tsc2004.c
@@ -0,0 +1,86 @@
+/*
+ * TSC2004 touchscreen driver
+ *
+ * Copyright (C) 2015 QWERTY Embedded Design
+ * Copyright (C) 2015 EMAC Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include "tsc200x-core.h"
+
+static int tsc2004_cmd(struct device *dev, u8 cmd)
+{
+	u8 tx = TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
+	s32 data;
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	data = i2c_smbus_write_byte(i2c, tx);
+	if (data < 0) {
+		dev_err(dev, "%s: failed, command: %x i2c error: %d\n",
+			__func__, cmd, data);
+		return data;
+	}
+
+	return 0;
+}
+
+static int tsc2004_probe(struct i2c_client *i2c,
+			 const struct i2c_device_id *id)
+
+{
+	return tsc200x_probe(&i2c->dev, i2c->irq, BUS_I2C,
+			     devm_regmap_init_i2c(i2c, &tsc200x_regmap_config),
+			     &tsc2004_cmd);
+}
+
+static int tsc2004_remove(struct i2c_client *i2c)
+{
+	return tsc200x_remove(&i2c->dev);
+}
+
+static const struct i2c_device_id tsc2004_idtable[] = {
+	{ "tsc2004", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, tsc2004_idtable);
+
+#ifdef CONFIG_OF
+static const struct of_device_id tsc2004_of_match[] = {
+	{ .compatible = "ti,tsc2004" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tsc2004_of_match);
+#endif
+
+static struct i2c_driver tsc2004_driver = {
+	.driver = {
+		.name   = "tsc2004",
+		.of_match_table = of_match_ptr(tsc2004_of_match),
+		.pm     = &tsc200x_pm_ops,
+	},
+	.id_table       = tsc2004_idtable,
+	.probe          = tsc2004_probe,
+	.remove         = tsc2004_remove,
+};
+
+module_i2c_driver(tsc2004_driver);
+
+MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
+MODULE_DESCRIPTION("TSC2004 Touchscreen Driver");
+MODULE_LICENSE("GPL");
-- 
2.1.4
