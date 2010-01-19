From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v2] Input: ad7879: split bus logic out
Date: Mon, 18 Jan 2010 23:52:44 -0500
Message-ID: <1263876764-6464-1-git-send-email-vapier@gentoo.org>
References: <1263742686-22305-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:43836 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab0ASEwg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 23:52:36 -0500
In-Reply-To: <1263742686-22305-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

The ad7879 driver is using the old bus method of only supporting one at a
time (I2C or SPI).  So refactor it like the other input drivers that
support multiple busses simultaneously.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
v2
	- forgot the kconfig/makefile changes ;x

 drivers/input/touchscreen/Kconfig      |   37 ++--
 drivers/input/touchscreen/Makefile     |    2 +
 drivers/input/touchscreen/ad7879-i2c.c |  113 ++++++++
 drivers/input/touchscreen/ad7879-spi.c |  162 +++++++++++
 drivers/input/touchscreen/ad7879.c     |  466 +++++++-------------------------
 drivers/input/touchscreen/ad7879.h     |   33 +++
 6 files changed, 421 insertions(+), 392 deletions(-)
 create mode 100644 drivers/input/touchscreen/ad7879-i2c.c
 create mode 100644 drivers/input/touchscreen/ad7879-spi.c
 create mode 100644 drivers/input/touchscreen/ad7879.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index dfafc76..ba306ff 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -42,37 +42,36 @@ config TOUCHSCREEN_AD7877
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7877.
 
-config TOUCHSCREEN_AD7879_I2C
-	tristate "AD7879 based touchscreens: AD7879-1 I2C Interface"
-	depends on I2C
-	select TOUCHSCREEN_AD7879
+config TOUCHSCREEN_AD7879
+	tristate "Analog Devices AD7879-1/AD7889-1 touchscreen interface"
 	help
-	  Say Y here if you have a touchscreen interface using the
-	  AD7879-1/AD7889-1 controller, and your board-specific
-	  initialization code includes that in its table of I2C devices.
+	  Say Y here if you want to support a touchscreen interface using
+	  the AD7879-1/AD7889-1 controller.
 
-	  If unsure, say N (but it's safe to say "Y").
+	  You should select a bus connection too.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7879.
 
+config TOUCHSCREEN_AD7879_I2C
+	tristate "support I2C bus connection"
+	depends on TOUCHSCREEN_AD7879 && I2C
+	help
+	  Say Y here if you have AD7879-1/AD7889-1 hooked to an I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7879-i2c.
+
 config TOUCHSCREEN_AD7879_SPI
-	tristate "AD7879 based touchscreens: AD7879 SPI Interface"
-	depends on SPI_MASTER && TOUCHSCREEN_AD7879_I2C = n
-	select TOUCHSCREEN_AD7879
+	tristate "support SPI bus connection"
+	depends on TOUCHSCREEN_AD7879 && SPI_MASTER
 	help
-	  Say Y here if you have a touchscreen interface using the
-	  AD7879/AD7889 controller, and your board-specific initialization
-	  code includes that in its table of SPI devices.
+	  Say Y here if you have AD7879-1/AD7889-1 hooked to a SPI bus.
 
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called ad7879.
-
-config TOUCHSCREEN_AD7879
-	tristate
-	default n
+	  module will be called ad7879-spi.
 
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index d61a3b4..5993b3e 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -8,6 +8,8 @@ wm97xx-ts-y := wm97xx-core.o
 
 obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
+obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
+obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
new file mode 100644
index 0000000..5e0e6dd
--- /dev/null
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -0,0 +1,113 @@
+/*
+ * AD7879-1/AD7889-1 touchscreen (I2C bus)
+ *
+ * Copyright (C) 2008-2010 Michael Hennerich, Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/input.h>	/* BUS_I2C */
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "ad7879.h"
+
+#define AD7879_DEVID		0x79	/* AD7879-1/AD7889-1 */
+
+#ifdef CONFIG_PM
+static int ad7879_i2c_suspend(struct i2c_client *client, pm_message_t message)
+{
+	return ad7879_disable(&client->dev);
+}
+
+static int ad7879_i2c_resume(struct i2c_client *client)
+{
+	return ad7879_enable(&client->dev);
+}
+#else
+# define ad7879_i2c_suspend NULL
+# define ad7879_i2c_resume  NULL
+#endif
+
+/* All registers are word-sized.
+ * AD7879 uses a high-byte first convention.
+ */
+static int ad7879_i2c_read(void *client, u8 reg)
+{
+	return swab16(i2c_smbus_read_word_data(client, reg));
+}
+
+static int ad7879_i2c_multi_read(void *client, u8 first_reg, u8 count, u16 *buf)
+{
+	u8 idx;
+	for (idx = 0; idx < count; ++idx)
+		buf[idx] = ad7879_i2c_read(client, first_reg + idx);
+	return 0;
+}
+
+static int ad7879_i2c_write(void *client, u8 reg, u16 val)
+{
+	return i2c_smbus_write_word_data(client, reg, swab16(val));
+}
+
+static int __devinit ad7879_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	struct ad7879_bus_ops bops = {
+		.bus_data = client,
+		.irq = client->irq,
+		.read = ad7879_i2c_read,
+		.multi_read = ad7879_i2c_multi_read,
+		.write = ad7879_i2c_write,
+	};
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA)) {
+		dev_err(&client->dev, "SMBUS Word Data not Supported\n");
+		return -EIO;
+	}
+
+	return ad7879_probe(&client->dev, &bops, AD7879_DEVID, BUS_I2C);
+}
+
+static int __devexit ad7879_i2c_remove(struct i2c_client *client)
+{
+	return ad7879_remove(&client->dev);
+}
+
+static const struct i2c_device_id ad7879_id[] = {
+	{ "ad7879", 0 },
+	{ "ad7889", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad7879_id);
+
+static struct i2c_driver ad7879_i2c_driver = {
+	.driver = {
+		.name	= "ad7879",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad7879_i2c_probe,
+	.remove		= __devexit_p(ad7879_i2c_remove),
+	.suspend	= ad7879_i2c_suspend,
+	.resume		= ad7879_i2c_resume,
+	.id_table	= ad7879_id,
+};
+
+static int __init ad7879_i2c_init(void)
+{
+	return i2c_add_driver(&ad7879_i2c_driver);
+}
+module_init(ad7879_i2c_init);
+
+static void __exit ad7879_i2c_exit(void)
+{
+	i2c_del_driver(&ad7879_i2c_driver);
+}
+module_exit(ad7879_i2c_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("AD7879(-1) touchscreen I2C bus driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("i2c:ad7879");
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
new file mode 100644
index 0000000..af8200d
--- /dev/null
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -0,0 +1,162 @@
+/*
+ * AD7879/AD7889 touchscreen (SPI bus)
+ *
+ * Copyright (C) 2008-2010 Michael Hennerich, Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/input.h>	/* BUS_SPI */
+#include <linux/spi/spi.h>
+
+#include "ad7879.h"
+
+#define AD7879_DEVID		0x7A	/* AD7879/AD7889 */
+
+#define MAX_SPI_FREQ_HZ      5000000
+#define AD7879_CMD_MAGIC     0xE000
+#define AD7879_CMD_READ      (1 << 10)
+#define AD7879_CMD(reg)      (AD7879_CMD_MAGIC | ((reg) & 0xF))
+#define AD7879_WRITECMD(reg) (AD7879_CMD(reg))
+#define AD7879_READCMD(reg)  (AD7879_CMD(reg) | AD7879_CMD_READ)
+
+#ifdef CONFIG_PM
+static int ad7879_spi_suspend(struct spi_device *spi, pm_message_t message)
+{
+	return ad7879_disable(&spi->dev);
+}
+
+static int ad7879_spi_resume(struct spi_device *spi)
+{
+	return ad7879_enable(&spi->dev);
+}
+#else
+# define ad7879_spi_suspend NULL
+# define ad7879_spi_resume  NULL
+#endif
+
+/*
+ * ad7879_read/write are only used for initial setup and for sysfs controls.
+ * The main traffic is done in ad7879_collect().
+ */
+
+static int ad7879_spi_xfer(void *spi, u16 cmd, u8 count, u16 *tx_buf, u16 *rx_buf)
+{
+	struct spi_message msg;
+	struct spi_transfer *xfers;
+	void *spi_data;
+	u16 *command;
+	u16 *_rx_buf = _rx_buf; /* shut gcc up */
+	u8 idx;
+	int ret;
+
+	xfers = spi_data = kzalloc(sizeof(*xfers) * (count + 2), GFP_KERNEL);
+	if (!spi_data)
+		return -ENOMEM;
+
+	spi_message_init(&msg);
+
+	command = spi_data;
+	command[0] = cmd;
+	if (count == 1) {
+		/* ad7879_spi_{read,write} gave us buf on stack */
+		command[1] = *tx_buf;
+		tx_buf = &command[1];
+		_rx_buf = rx_buf;
+		rx_buf = &command[2];
+	}
+
+	++xfers;
+	xfers[0].tx_buf = command;
+	xfers[0].len = 2;
+	spi_message_add_tail(&xfers[0], &msg);
+	++xfers;
+
+	for (idx = 0; idx < count; ++idx) {
+		if (rx_buf)
+			xfers[idx].rx_buf = &rx_buf[idx];
+		if (tx_buf)
+			xfers[idx].tx_buf = &tx_buf[idx];
+		xfers[idx].len = 2;
+		spi_message_add_tail(&xfers[idx], &msg);
+	}
+
+	ret = spi_sync(spi, &msg);
+
+	if (count == 1)
+		_rx_buf[0] = command[2];
+
+	kfree(spi_data);
+
+	return ret;
+}
+
+static int ad7879_spi_multi_read(void *spi, u8 first_reg, u8 count, u16 *buf)
+{
+	return ad7879_spi_xfer(spi, AD7879_READCMD(first_reg), count, NULL, buf);
+}
+
+static int ad7879_spi_read(void *spi, u8 reg)
+{
+	u16 ret, dummy;
+	return ad7879_spi_xfer(spi, AD7879_READCMD(reg), 1, &dummy, &ret) ? : ret;
+}
+
+static int ad7879_spi_write(void *spi, u8 reg, u16 val)
+{
+	u16 dummy;
+	return ad7879_spi_xfer(spi, AD7879_WRITECMD(reg), 1, &val, &dummy);
+}
+
+static int __devinit ad7879_spi_probe(struct spi_device *spi)
+{
+	struct ad7879_bus_ops bops = {
+		.bus_data = spi,
+		.irq = spi->irq,
+		.read = ad7879_spi_read,
+		.multi_read = ad7879_spi_multi_read,
+		.write = ad7879_spi_write,
+	};
+
+	/* don't exceed max specified SPI CLK frequency */
+	if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
+		dev_err(&spi->dev, "SPI CLK %d Hz?\n", spi->max_speed_hz);
+		return -EINVAL;
+	}
+
+	return ad7879_probe(&spi->dev, &bops, AD7879_DEVID, BUS_SPI);
+}
+
+static int __devexit ad7879_spi_remove(struct spi_device *spi)
+{
+	return ad7879_remove(&spi->dev);
+}
+
+static struct spi_driver ad7879_spi_driver = {
+	.driver = {
+		.name	= "ad7879",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad7879_spi_probe,
+	.remove		= __devexit_p(ad7879_spi_remove),
+	.suspend	= ad7879_spi_suspend,
+	.resume		= ad7879_spi_resume,
+};
+
+static int __init ad7879_spi_init(void)
+{
+	return spi_register_driver(&ad7879_spi_driver);
+}
+module_init(ad7879_spi_init);
+
+static void __exit ad7879_spi_exit(void)
+{
+	spi_unregister_driver(&ad7879_spi_driver);
+}
+module_exit(ad7879_spi_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("AD7879(-1) touchscreen SPI bus driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:ad7879");
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index a0876a9..280de45 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -1,25 +1,9 @@
 /*
- * Copyright (C) 2008-2009 Michael Hennerich, Analog Devices Inc.
+ * AD7879/AD7889 based touchscreen and GPIO driver
  *
- * Description:	AD7879/AD7889 based touchscreen, and GPIO driver
- *		(I2C/SPI Interface)
+ * Copyright (C) 2008-2010 Michael Hennerich, Analog Devices Inc.
  *
- * Bugs:        Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Licensed under the GPL-2 or later.
  *
  * History:
  * Copyright (c) 2005 David Brownell
@@ -45,11 +29,10 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
-#include <linux/spi/spi.h>
-#include <linux/i2c.h>
 #include <linux/gpio.h>
 
 #include <linux/spi/ad7879.h>
+#include "ad7879.h"
 
 #define AD7879_REG_ZEROS		0
 #define AD7879_REG_CTRL1		1
@@ -120,16 +103,8 @@ enum {
 #define	MAX_12BIT			((1<<12)-1)
 #define	TS_PEN_UP_TIMEOUT		msecs_to_jiffies(50)
 
-#if defined(CONFIG_TOUCHSCREEN_AD7879_SPI) || defined(CONFIG_TOUCHSCREEN_AD7879_SPI_MODULE)
-#define AD7879_DEVID		0x7A
-typedef struct spi_device	bus_device;
-#elif defined(CONFIG_TOUCHSCREEN_AD7879_I2C) || defined(CONFIG_TOUCHSCREEN_AD7879_I2C_MODULE)
-#define AD7879_DEVID		0x79
-typedef struct i2c_client	bus_device;
-#endif
-
 struct ad7879 {
-	bus_device		*bus;
+	struct ad7879_bus_ops	bops;
 	struct input_dev	*input;
 	struct work_struct	work;
 	struct timer_list	timer;
@@ -138,12 +113,6 @@ struct ad7879 {
 #endif
 	struct mutex		mutex;
 	unsigned		disabled:1;	/* P: mutex */
-
-#if defined(CONFIG_TOUCHSCREEN_AD7879_SPI) || defined(CONFIG_TOUCHSCREEN_AD7879_SPI_MODULE)
-	struct spi_message	msg;
-	struct spi_transfer	xfer[AD7879_NR_SENSE + 1];
-	u16			cmd;
-#endif
 	u16			conversion_data[AD7879_NR_SENSE];
 	char			phys[32];
 	u8			first_conversion_delay;
@@ -158,9 +127,18 @@ struct ad7879 {
 	u16			cmd_crtl3;
 };
 
-static int ad7879_read(bus_device *, u8);
-static int ad7879_write(bus_device *, u8, u16);
-static void ad7879_collect(struct ad7879 *);
+static int ad7879_read(struct ad7879 *ts, u8 reg)
+{
+	return ts->bops.read(ts->bops.bus_data, reg);
+}
+static int ad7879_multi_read(struct ad7879 *ts, u8 first_reg, u8 count, u16 *buf)
+{
+	return ts->bops.multi_read(ts->bops.bus_data, first_reg, count, buf);
+}
+static int ad7879_write(struct ad7879 *ts, u8 reg, u16 val)
+{
+	return ts->bops.write(ts->bops.bus_data, reg, val);
+}
 
 static void ad7879_report(struct ad7879 *ts)
 {
@@ -201,7 +179,7 @@ static void ad7879_work(struct work_struct *work)
 	struct ad7879 *ts = container_of(work, struct ad7879, work);
 
 	/* use keventd context to read the result registers */
-	ad7879_collect(ts);
+	ad7879_multi_read(ts, AD7879_REG_XPLUS, AD7879_NR_SENSE, ts->conversion_data);
 	ad7879_report(ts);
 	mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 }
@@ -238,44 +216,54 @@ static irqreturn_t ad7879_irq(int irq, void *handle)
 
 static void ad7879_setup(struct ad7879 *ts)
 {
-	ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
-	ad7879_write(ts->bus, AD7879_REG_CTRL3, ts->cmd_crtl3);
-	ad7879_write(ts->bus, AD7879_REG_CTRL1, ts->cmd_crtl1);
+	ad7879_write(ts, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	ad7879_write(ts, AD7879_REG_CTRL3, ts->cmd_crtl3);
+	ad7879_write(ts, AD7879_REG_CTRL1, ts->cmd_crtl1);
 }
 
-static void ad7879_disable(struct ad7879 *ts)
+int ad7879_disable(struct device *dev)
 {
+	struct ad7879 *ts = dev_get_drvdata(dev);
+
 	mutex_lock(&ts->mutex);
 
 	if (!ts->disabled) {
 
 		ts->disabled = 1;
-		disable_irq(ts->bus->irq);
+		disable_irq(ts->bops.irq);
 
 		cancel_work_sync(&ts->work);
 
 		if (del_timer_sync(&ts->timer))
 			ad7879_ts_event_release(ts);
 
-		ad7879_write(ts->bus, AD7879_REG_CTRL2,
+		ad7879_write(ts, AD7879_REG_CTRL2,
 			     AD7879_PM(AD7879_PM_SHUTDOWN));
 	}
 
 	mutex_unlock(&ts->mutex);
+
+	return 0;
 }
+EXPORT_SYMBOL(ad7879_disable);
 
-static void ad7879_enable(struct ad7879 *ts)
+int ad7879_enable(struct device *dev)
 {
+	struct ad7879 *ts = dev_get_drvdata(dev);
+
 	mutex_lock(&ts->mutex);
 
 	if (ts->disabled) {
 		ad7879_setup(ts);
 		ts->disabled = 0;
-		enable_irq(ts->bus->irq);
+		enable_irq(ts->bops.irq);
 	}
 
 	mutex_unlock(&ts->mutex);
+
+	return 0;
 }
+EXPORT_SYMBOL(ad7879_enable);
 
 static ssize_t ad7879_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -289,7 +277,6 @@ static ssize_t ad7879_disable_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct ad7879 *ts = dev_get_drvdata(dev);
 	unsigned long val;
 	int error;
 
@@ -298,9 +285,9 @@ static ssize_t ad7879_disable_store(struct device *dev,
 		return error;
 
 	if (val)
-		ad7879_disable(ts);
+		ad7879_disable(dev);
 	else
-		ad7879_enable(ts);
+		ad7879_enable(dev);
 
 	return count;
 }
@@ -324,7 +311,7 @@ int ad7879_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 
 	mutex_lock(&ts->mutex);
 	ts->cmd_crtl2 |= AD7879_GPIO_EN | AD7879_GPIODIR | AD7879_GPIOPOL;
-	err = ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	err = ad7879_write(ts, AD7879_REG_CTRL2, ts->cmd_crtl2);
 	mutex_unlock(&ts->mutex);
 
 	return err;
@@ -343,7 +330,7 @@ int ad7879_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int leve
 	else
 		ts->cmd_crtl2 &= ~AD7879_GPIO_DATA;
 
-	err = ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	err = ad7879_write(ts, AD7879_REG_CTRL2, ts->cmd_crtl2);
 	mutex_unlock(&ts->mutex);
 
 	return err;
@@ -355,7 +342,7 @@ int ad7879_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 	u16 val;
 
 	mutex_lock(&ts->mutex);
-	val = ad7879_read(ts->bus, AD7879_REG_CTRL2);
+	val = ad7879_read(ts, AD7879_REG_CTRL2);
 	mutex_unlock(&ts->mutex);
 
 	return !!(val & AD7879_GPIO_DATA);
@@ -371,7 +358,7 @@ void ad7879_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
 	else
 		ts->cmd_crtl2 &= ~AD7879_GPIO_DATA;
 
-	ad7879_write(ts->bus, AD7879_REG_CTRL2, ts->cmd_crtl2);
+	ad7879_write(ts, AD7879_REG_CTRL2, ts->cmd_crtl2);
 	mutex_unlock(&ts->mutex);
 }
 
@@ -429,28 +416,38 @@ static inline int ad7879_gpio_remove(struct device *dev)
 }
 #endif
 
-static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
+__devinit int
+ad7879_probe(struct device *dev, struct ad7879_bus_ops *bops, u8 devid, u16 bustype)
 {
 	struct input_dev *input_dev;
-	struct ad7879_platform_data *pdata = bus->dev.platform_data;
+	struct ad7879_platform_data *pdata = dev->platform_data;
 	int err;
 	u16 revid;
+	struct ad7879 *ts;
 
-	if (!bus->irq) {
-		dev_err(&bus->dev, "no IRQ?\n");
+	if (!bops->irq) {
+		dev_err(dev, "no IRQ?\n");
 		return -ENODEV;
 	}
 
 	if (!pdata) {
-		dev_err(&bus->dev, "no platform data?\n");
+		dev_err(dev, "no platform data?\n");
 		return -ENODEV;
 	}
 
+	err = -ENOMEM;
+
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		goto err_free_ts_mem;
+
 	input_dev = input_allocate_device();
 	if (!input_dev)
-		return -ENOMEM;
+		goto err_free_ts_mem;
 
+	ts->bops = *bops;
 	ts->input = input_dev;
+	dev_set_drvdata(dev, ts);
 
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
 	INIT_WORK(&ts->work, ad7879_work);
@@ -465,11 +462,12 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 	ts->pen_down_acc_interval = pdata->pen_down_acc_interval;
 	ts->median = pdata->median;
 
-	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&bus->dev));
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
 	input_dev->name = "AD7879 Touchscreen";
 	input_dev->phys = ts->phys;
-	input_dev->dev.parent = &bus->dev;
+	input_dev->dev.parent = dev;
+	input_dev->id.bustype = bustype;
 
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(ABS_X, input_dev->absbit);
@@ -487,17 +485,19 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 	input_set_abs_params(input_dev, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
-	err = ad7879_write(bus, AD7879_REG_CTRL2, AD7879_RESET);
+	err = ad7879_write(ts, AD7879_REG_CTRL2, AD7879_RESET);
 
 	if (err < 0) {
-		dev_err(&bus->dev, "Failed to write %s\n", input_dev->name);
+		dev_err(dev, "Failed to write %s\n", input_dev->name);
 		goto err_free_mem;
 	}
 
-	revid = ad7879_read(bus, AD7879_REG_REVID);
-
-	if ((revid & 0xFF) != AD7879_DEVID) {
-		dev_err(&bus->dev, "Failed to probe %s\n", input_dev->name);
+	revid = ad7879_read(ts, AD7879_REG_REVID);
+	input_dev->id.product = (revid & 0xff);
+	input_dev->id.version = revid >> 8;
+	if (input_dev->id.product != devid) {
+		dev_err(dev, "Failed to probe %s (%x vs %x)\n",
+			input_dev->name, devid, revid);
 		err = -ENODEV;
 		goto err_free_mem;
 	}
@@ -521,19 +521,18 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 
 	ad7879_setup(ts);
 
-	err = request_irq(bus->irq, ad7879_irq,
-			  IRQF_TRIGGER_FALLING, bus->dev.driver->name, ts);
-
+	err = request_irq(ts->bops.irq, ad7879_irq, IRQF_TRIGGER_FALLING,
+			  dev_name(dev), ts);
 	if (err) {
-		dev_err(&bus->dev, "irq %d busy?\n", bus->irq);
+		dev_err(dev, "irq %d busy?\n", ts->bops.irq);
 		goto err_free_mem;
 	}
 
-	err = sysfs_create_group(&bus->dev.kobj, &ad7879_attr_group);
+	err = sysfs_create_group(&dev->kobj, &ad7879_attr_group);
 	if (err)
 		goto err_free_irq;
 
-	err = ad7879_gpio_add(&bus->dev);
+	err = ad7879_gpio_add(dev);
 	if (err)
 		goto err_remove_attr;
 
@@ -541,324 +540,45 @@ static int __devinit ad7879_construct(bus_device *bus, struct ad7879 *ts)
 	if (err)
 		goto err_remove_gpio;
 
-	dev_info(&bus->dev, "Rev.%d touchscreen, irq %d\n",
-		 revid >> 8, bus->irq);
+	dev_info(dev, "Rev.%d touchscreen, irq %d\n",
+		 revid >> 8, ts->bops.irq);
 
 	return 0;
 
 err_remove_gpio:
-	ad7879_gpio_remove(&bus->dev);
+	ad7879_gpio_remove(dev);
 err_remove_attr:
-	sysfs_remove_group(&bus->dev.kobj, &ad7879_attr_group);
+	sysfs_remove_group(&dev->kobj, &ad7879_attr_group);
 err_free_irq:
-	free_irq(bus->irq, ts);
+	free_irq(ts->bops.irq, ts);
 err_free_mem:
 	input_free_device(input_dev);
+err_free_ts_mem:
+	kfree(ts);
+	dev_set_drvdata(dev, NULL);
 
 	return err;
 }
+EXPORT_SYMBOL(ad7879_probe);
 
-static int __devexit ad7879_destroy(bus_device *bus, struct ad7879 *ts)
-{
-	ad7879_gpio_remove(&bus->dev);
-	ad7879_disable(ts);
-	sysfs_remove_group(&ts->bus->dev.kobj, &ad7879_attr_group);
-	free_irq(ts->bus->irq, ts);
-	input_unregister_device(ts->input);
-	dev_dbg(&bus->dev, "unregistered touchscreen\n");
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int ad7879_suspend(bus_device *bus, pm_message_t message)
-{
-	struct ad7879 *ts = dev_get_drvdata(&bus->dev);
-
-	ad7879_disable(ts);
-
-	return 0;
-}
-
-static int ad7879_resume(bus_device *bus)
-{
-	struct ad7879 *ts = dev_get_drvdata(&bus->dev);
-
-	ad7879_enable(ts);
-
-	return 0;
-}
-#else
-#define ad7879_suspend NULL
-#define ad7879_resume  NULL
-#endif
-
-#if defined(CONFIG_TOUCHSCREEN_AD7879_SPI) || defined(CONFIG_TOUCHSCREEN_AD7879_SPI_MODULE)
-#define MAX_SPI_FREQ_HZ		5000000
-#define AD7879_CMD_MAGIC	0xE000
-#define AD7879_CMD_READ		(1 << 10)
-#define AD7879_WRITECMD(reg)	(AD7879_CMD_MAGIC | (reg & 0xF))
-#define AD7879_READCMD(reg)	(AD7879_CMD_MAGIC | AD7879_CMD_READ | (reg & 0xF))
-
-struct ser_req {
-	u16			command;
-	u16			data;
-	struct spi_message	msg;
-	struct spi_transfer	xfer[2];
-};
-
-/*
- * ad7879_read/write are only used for initial setup and for sysfs controls.
- * The main traffic is done in ad7879_collect().
- */
-
-static int ad7879_read(struct spi_device *spi, u8 reg)
-{
-	struct ser_req *req;
-	int status, ret;
-
-	req = kzalloc(sizeof *req, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	spi_message_init(&req->msg);
-
-	req->command = (u16) AD7879_READCMD(reg);
-	req->xfer[0].tx_buf = &req->command;
-	req->xfer[0].len = 2;
-
-	req->xfer[1].rx_buf = &req->data;
-	req->xfer[1].len = 2;
-
-	spi_message_add_tail(&req->xfer[0], &req->msg);
-	spi_message_add_tail(&req->xfer[1], &req->msg);
-
-	status = spi_sync(spi, &req->msg);
-	ret = status ? : req->data;
-
-	kfree(req);
-
-	return ret;
-}
-
-static int ad7879_write(struct spi_device *spi, u8 reg, u16 val)
-{
-	struct ser_req *req;
-	int status;
-
-	req = kzalloc(sizeof *req, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	spi_message_init(&req->msg);
-
-	req->command = (u16) AD7879_WRITECMD(reg);
-	req->xfer[0].tx_buf = &req->command;
-	req->xfer[0].len = 2;
-
-	req->data = val;
-	req->xfer[1].tx_buf = &req->data;
-	req->xfer[1].len = 2;
-
-	spi_message_add_tail(&req->xfer[0], &req->msg);
-	spi_message_add_tail(&req->xfer[1], &req->msg);
-
-	status = spi_sync(spi, &req->msg);
-
-	kfree(req);
-
-	return status;
-}
-
-static void ad7879_collect(struct ad7879 *ts)
+__devexit int ad7879_remove(struct device *dev)
 {
-	int status = spi_sync(ts->bus, &ts->msg);
-
-	if (status)
-		dev_err(&ts->bus->dev, "spi_sync --> %d\n", status);
-}
-
-static void ad7879_setup_ts_def_msg(struct ad7879 *ts)
-{
-	struct spi_message *m;
-	int i;
-
-	ts->cmd = (u16) AD7879_READCMD(AD7879_REG_XPLUS);
-
-	m = &ts->msg;
-	spi_message_init(m);
-	ts->xfer[0].tx_buf = &ts->cmd;
-	ts->xfer[0].len = 2;
-
-	spi_message_add_tail(&ts->xfer[0], m);
-
-	for (i = 0; i < AD7879_NR_SENSE; i++) {
-		ts->xfer[i + 1].rx_buf = &ts->conversion_data[i];
-		ts->xfer[i + 1].len = 2;
-		spi_message_add_tail(&ts->xfer[i + 1], m);
-	}
-}
-
-static int __devinit ad7879_probe(struct spi_device *spi)
-{
-	struct ad7879 *ts;
-	int error;
-
-	/* don't exceed max specified SPI CLK frequency */
-	if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
-		dev_err(&spi->dev, "SPI CLK %d Hz?\n", spi->max_speed_hz);
-		return -EINVAL;
-	}
-
-	ts = kzalloc(sizeof(struct ad7879), GFP_KERNEL);
-	if (!ts)
-		return -ENOMEM;
-
-	dev_set_drvdata(&spi->dev, ts);
-	ts->bus = spi;
-
-	ad7879_setup_ts_def_msg(ts);
-
-	error = ad7879_construct(spi, ts);
-	if (error) {
-		dev_set_drvdata(&spi->dev, NULL);
-		kfree(ts);
-	}
-
-	return error;
-}
-
-static int __devexit ad7879_remove(struct spi_device *spi)
-{
-	struct ad7879 *ts = dev_get_drvdata(&spi->dev);
+	struct ad7879 *ts = dev_get_drvdata(dev);
 
-	ad7879_destroy(spi, ts);
-	dev_set_drvdata(&spi->dev, NULL);
+	ad7879_gpio_remove(dev);
+	ad7879_disable(dev);
+	sysfs_remove_group(&dev->kobj, &ad7879_attr_group);
+	free_irq(ts->bops.irq, ts);
+	input_unregister_device(ts->input);
+	dev_set_drvdata(dev, NULL);
 	kfree(ts);
 
-	return 0;
-}
-
-static struct spi_driver ad7879_driver = {
-	.driver = {
-		.name	= "ad7879",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
-	},
-	.probe		= ad7879_probe,
-	.remove		= __devexit_p(ad7879_remove),
-	.suspend	= ad7879_suspend,
-	.resume		= ad7879_resume,
-};
-
-static int __init ad7879_init(void)
-{
-	return spi_register_driver(&ad7879_driver);
-}
-module_init(ad7879_init);
-
-static void __exit ad7879_exit(void)
-{
-	spi_unregister_driver(&ad7879_driver);
-}
-module_exit(ad7879_exit);
-
-#elif defined(CONFIG_TOUCHSCREEN_AD7879_I2C) || defined(CONFIG_TOUCHSCREEN_AD7879_I2C_MODULE)
-
-/* All registers are word-sized.
- * AD7879 uses a high-byte first convention.
- */
-static int ad7879_read(struct i2c_client *client, u8 reg)
-{
-	return swab16(i2c_smbus_read_word_data(client, reg));
-}
-
-static int ad7879_write(struct i2c_client *client, u8 reg, u16 val)
-{
-	return i2c_smbus_write_word_data(client, reg, swab16(val));
-}
-
-static void ad7879_collect(struct ad7879 *ts)
-{
-	int i;
-
-	for (i = 0; i < AD7879_NR_SENSE; i++)
-		ts->conversion_data[i] = ad7879_read(ts->bus,
-						     AD7879_REG_XPLUS + i);
-}
-
-static int __devinit ad7879_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
-{
-	struct ad7879 *ts;
-	int error;
-
-	if (!i2c_check_functionality(client->adapter,
-					I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(&client->dev, "SMBUS Word Data not Supported\n");
-		return -EIO;
-	}
-
-	ts = kzalloc(sizeof(struct ad7879), GFP_KERNEL);
-	if (!ts)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, ts);
-	ts->bus = client;
-
-	error = ad7879_construct(client, ts);
-	if (error) {
-		i2c_set_clientdata(client, NULL);
-		kfree(ts);
-	}
-
-	return error;
-}
-
-static int __devexit ad7879_remove(struct i2c_client *client)
-{
-	struct ad7879 *ts = dev_get_drvdata(&client->dev);
-
-	ad7879_destroy(client, ts);
-	i2c_set_clientdata(client, NULL);
-	kfree(ts);
+	dev_dbg(dev, "unregistered touchscreen\n");
 
 	return 0;
 }
-
-static const struct i2c_device_id ad7879_id[] = {
-	{ "ad7879", 0 },
-	{ "ad7889", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ad7879_id);
-
-static struct i2c_driver ad7879_driver = {
-	.driver = {
-		.name	= "ad7879",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= ad7879_probe,
-	.remove		= __devexit_p(ad7879_remove),
-	.suspend	= ad7879_suspend,
-	.resume		= ad7879_resume,
-	.id_table	= ad7879_id,
-};
-
-static int __init ad7879_init(void)
-{
-	return i2c_add_driver(&ad7879_driver);
-}
-module_init(ad7879_init);
-
-static void __exit ad7879_exit(void)
-{
-	i2c_del_driver(&ad7879_driver);
-}
-module_exit(ad7879_exit);
-#endif
+EXPORT_SYMBOL(ad7879_remove);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("AD7879(-1) touchscreen Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:ad7879");
diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
new file mode 100644
index 0000000..397ae82
--- /dev/null
+++ b/drivers/input/touchscreen/ad7879.h
@@ -0,0 +1,33 @@
+/*
+ * AD7879/AD7889 touchscreen (bus interfaces)
+ *
+ * Copyright (C) 2008-2010 Michael Hennerich, Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef _AD7879_H_
+#define _AD7879_H_
+
+#include <linux/types.h>
+
+struct ad7879;
+
+typedef int (ad7879_read_t) (void *bus_data, u8 reg);
+typedef int (ad7879_multi_read_t) (void *bus_data, u8 first_reg, u8 count, u16 *buf);
+typedef int (ad7879_write_t) (void *bus_data, u8 reg, u16 val);
+
+struct ad7879_bus_ops {
+	void *bus_data;
+	int irq;
+	ad7879_read_t *read;
+	ad7879_multi_read_t *multi_read;
+	ad7879_write_t *write;
+};
+
+int ad7879_disable(struct device *dev);
+int ad7879_enable(struct device *dev);
+int ad7879_probe(struct device *dev, struct ad7879_bus_ops *bops, u8 devid, u16 bustype);
+int ad7879_remove(struct device *dev);
+
+#endif
-- 
1.6.6

