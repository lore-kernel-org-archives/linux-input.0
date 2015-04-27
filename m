From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 10/17] i2c: add locomo i2c driver
Date: Tue, 28 Apr 2015 02:55:47 +0300
Message-ID: <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430178954-11138-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

LoCoMo chip contains a tiny i2c controller destined to control
M62332 DAC. Provide a separate I2C driver for this cell.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig      |  12 ++++
 drivers/i2c/busses/Makefile     |   1 +
 drivers/i2c/busses/i2c-locomo.c | 136 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-locomo.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2255af2..114d9da 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -602,6 +602,18 @@ config I2C_KEMPLD
 	  This driver can also be built as a module. If so, the module
 	  will be called i2c-kempld.
 
+config I2C_LOCOMO
+	tristate "I2C bus support for LoCoMo chips"
+	depends on MFD_LOCOMO
+	select I2C_ALGOBIT
+	help
+	  Say yes if you will run the kernel on Sharp SL-5x00 family of devices.
+
+	  If you don't know what to do here, say N.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-locomo.
+
 config I2C_MESON
 	tristate "Amlogic Meson I2C controller"
 	depends on ARCH_MESON
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index cdf941d..e09dcf6 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_JZ4780)	+= i2c-jz4780.o
 obj-$(CONFIG_I2C_KEMPLD)	+= i2c-kempld.o
+obj-$(CONFIG_I2C_LOCOMO)	+= i2c-locomo.o
 obj-$(CONFIG_I2C_MESON)		+= i2c-meson.o
 obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
 obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
diff --git a/drivers/i2c/busses/i2c-locomo.c b/drivers/i2c/busses/i2c-locomo.c
new file mode 100644
index 0000000..640b46cd
--- /dev/null
+++ b/drivers/i2c/busses/i2c-locomo.c
@@ -0,0 +1,136 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/mfd/locomo.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+struct locomo_i2c {
+	struct regmap		*regmap;
+	struct i2c_adapter	 adap;
+	struct i2c_algo_bit_data bit;
+};
+
+static void locomo_i2c_setsda(void *data, int state)
+{
+	struct locomo_i2c *li2c = data;
+
+	regmap_update_bits(li2c->regmap, LOCOMO_DAC,
+			LOCOMO_DAC_SDAOEB,
+			state ? LOCOMO_DAC_SDAOEB : 0);
+}
+
+static void locomo_i2c_setscl(void *data, int state)
+{
+	struct locomo_i2c *li2c = data;
+
+	regmap_update_bits(li2c->regmap, LOCOMO_DAC,
+			LOCOMO_DAC_SCLOEB,
+			state ? LOCOMO_DAC_SCLOEB : 0);
+}
+
+static int locomo_i2c_getsda(void *data)
+{
+	struct locomo_i2c *li2c = data;
+	unsigned int r;
+
+	regmap_read(li2c->regmap, LOCOMO_DAC, &r);
+
+	return !!(r & LOCOMO_DAC_SDA);
+}
+
+static int locomo_i2c_probe(struct platform_device *dev)
+{
+	struct locomo_i2c *li2c;
+	int ret;
+
+	li2c = devm_kzalloc(&dev->dev, sizeof(struct locomo_i2c), GFP_KERNEL);
+	if (li2c == NULL)
+		return -ENOMEM;
+
+	li2c->regmap = dev_get_regmap(dev->dev.parent, NULL);
+	if (!li2c->regmap)
+		return -ENODEV;
+
+	li2c->adap.owner = THIS_MODULE;
+	li2c->adap.dev.parent = &dev->dev;
+	li2c->adap.dev.of_node = dev->dev.of_node;
+	li2c->adap.algo_data = &li2c->bit;
+	li2c->adap.nr = 1; /* On poodle, 0 is pxa internal bus */
+
+	strlcpy(li2c->adap.name, "LoCoMo I2C", sizeof(li2c->adap.name));
+
+	li2c->bit.data = li2c;
+	li2c->bit.setsda = locomo_i2c_setsda;
+	li2c->bit.setscl = locomo_i2c_setscl;
+	li2c->bit.getsda = locomo_i2c_getsda;
+	li2c->bit.udelay = 6;
+	li2c->bit.timeout = HZ;
+
+	ret = i2c_bit_add_numbered_bus(&li2c->adap);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(dev, li2c);
+
+	return 0;
+}
+
+static int locomo_i2c_remove(struct platform_device *dev)
+{
+	struct locomo_i2c *li2c = platform_get_drvdata(dev);
+
+	i2c_del_adapter(&li2c->adap);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int locomo_i2c_suspend(struct device *dev)
+{
+	struct locomo_i2c *li2c = dev_get_drvdata(dev);
+
+	regmap_write(li2c->regmap, LOCOMO_DAC, 0x00);
+
+	return 0;
+}
+
+static int locomo_i2c_resume(struct device *dev)
+{
+	struct locomo_i2c *li2c = dev_get_drvdata(dev);
+
+	regmap_write(li2c->regmap, LOCOMO_DAC,
+			LOCOMO_DAC_SDAOEB | LOCOMO_DAC_SCLOEB);
+
+	return 0;
+}
+static SIMPLE_DEV_PM_OPS(locomo_i2c_pm, locomo_i2c_suspend, locomo_i2c_resume);
+#define LOCOMO_I2C_PM	(&locomo_i2c_pm)
+#else
+#define LOCOMO_I2C_PM	NULL
+#endif
+
+
+static struct platform_driver locomo_i2c_driver = {
+	.driver		= {
+		.name	= "locomo-i2c",
+		.pm	= LOCOMO_I2C_PM,
+	},
+	.probe		= locomo_i2c_probe,
+	.remove		= locomo_i2c_remove,
+};
+
+module_platform_driver(locomo_i2c_driver);
+
+MODULE_DESCRIPTION("LoCoMo i2c bus driver");
+MODULE_AUTHOR("Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:locomo-i2c");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
