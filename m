From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/RFT PATCH 1/3] Input: ad7879 - convert to use regmap
Date: Fri, 17 Feb 2017 15:31:50 -0800
Message-ID: <20170217233152.31715-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36631 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964829AbdBQXbz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Feb 2017 18:31:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of rolling our own infrastructure to provide uniform access to I2C
and SPI buses, let's switch to using regmap.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Michael,

I am a bit (actually a lot) confused how this driver was working with SPI
and Blackfin, which is, as far as I understand, little-endian, because from
my reading of the spec the data on wire is big-endian. If this is not
correct we need to change spi regmap config to be:

static const struct regmap_config ad7879_spi_regmap_config = {
	.reg_bits = 16,
	.val_bits = 16,
	.max_register = 15,
	.read_flag_mask = AD7879_CMD_MAGIC | AD7879_CMD_READ,
	.write_flag_mask = AD7879_CMD_MAGIC,
	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
};

Also, the original ad7879_spi_xfer was funky to tell the least. We
allocated n+2 spi_transfer structures, then smashed the beginning of the
first one with u16 command, then basically "restored" it???

Anyway, if you could try it out (and fix ;) ), that would be great.

Thanks.

 drivers/input/touchscreen/ad7879-i2c.c |  50 ++++-----------
 drivers/input/touchscreen/ad7879-spi.c | 112 ++++++---------------------------
 drivers/input/touchscreen/ad7879.c     |  46 +++++++++-----
 drivers/input/touchscreen/ad7879.h     |  12 +---
 4 files changed, 63 insertions(+), 157 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 58f72e0246ab..25aa9b89a6aa 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -12,53 +12,23 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 
 #include "ad7879.h"
 
 #define AD7879_DEVID		0x79	/* AD7879-1/AD7889-1 */
 
-/* All registers are word-sized.
- * AD7879 uses a high-byte first convention.
- */
-static int ad7879_i2c_read(struct device *dev, u8 reg)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	return i2c_smbus_read_word_swapped(client, reg);
-}
-
-static int ad7879_i2c_multi_read(struct device *dev,
-				 u8 first_reg, u8 count, u16 *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	u8 idx;
-
-	i2c_smbus_read_i2c_block_data(client, first_reg, count * 2, (u8 *)buf);
-
-	for (idx = 0; idx < count; ++idx)
-		buf[idx] = swab16(buf[idx]);
-
-	return 0;
-}
-
-static int ad7879_i2c_write(struct device *dev, u8 reg, u16 val)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	return i2c_smbus_write_word_swapped(client, reg, val);
-}
-
-static const struct ad7879_bus_ops ad7879_i2c_bus_ops = {
-	.bustype	= BUS_I2C,
-	.read		= ad7879_i2c_read,
-	.multi_read	= ad7879_i2c_multi_read,
-	.write		= ad7879_i2c_write,
+static const struct regmap_config ad7879_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 15,
 };
 
 static int ad7879_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct ad7879 *ts;
+	struct regmap *regmap;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
@@ -66,8 +36,12 @@ static int ad7879_i2c_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	ts = ad7879_probe(&client->dev, AD7879_DEVID, client->irq,
-			  &ad7879_i2c_bus_ops);
+	regmap = devm_regmap_init_i2c(client, &ad7879_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ts = ad7879_probe(&client->dev, regmap, client->irq,
+			  BUS_I2C, AD7879_DEVID);
 	if (IS_ERR(ts))
 		return PTR_ERR(ts);
 
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index d42b6b9af191..e9535aacaabf 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -11,109 +11,29 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #include "ad7879.h"
 
 #define AD7879_DEVID		0x7A	/* AD7879/AD7889 */
 
 #define MAX_SPI_FREQ_HZ      5000000
-#define AD7879_CMD_MAGIC     0xE000
-#define AD7879_CMD_READ      (1 << 10)
-#define AD7879_CMD(reg)      (AD7879_CMD_MAGIC | ((reg) & 0xF))
-#define AD7879_WRITECMD(reg) (AD7879_CMD(reg))
-#define AD7879_READCMD(reg)  (AD7879_CMD(reg) | AD7879_CMD_READ)
-
-/*
- * ad7879_read/write are only used for initial setup and for sysfs controls.
- * The main traffic is done in ad7879_collect().
- */
-
-static int ad7879_spi_xfer(struct spi_device *spi,
-			   u16 cmd, u8 count, u16 *tx_buf, u16 *rx_buf)
-{
-	struct spi_message msg;
-	struct spi_transfer *xfers;
-	void *spi_data;
-	u16 *command;
-	u16 *_rx_buf = _rx_buf; /* shut gcc up */
-	u8 idx;
-	int ret;
-
-	xfers = spi_data = kzalloc(sizeof(*xfers) * (count + 2), GFP_KERNEL);
-	if (!spi_data)
-		return -ENOMEM;
-
-	spi_message_init(&msg);
-
-	command = spi_data;
-	command[0] = cmd;
-	if (count == 1) {
-		/* ad7879_spi_{read,write} gave us buf on stack */
-		command[1] = *tx_buf;
-		tx_buf = &command[1];
-		_rx_buf = rx_buf;
-		rx_buf = &command[2];
-	}
-
-	++xfers;
-	xfers[0].tx_buf = command;
-	xfers[0].len = 2;
-	spi_message_add_tail(&xfers[0], &msg);
-	++xfers;
-
-	for (idx = 0; idx < count; ++idx) {
-		if (rx_buf)
-			xfers[idx].rx_buf = &rx_buf[idx];
-		if (tx_buf)
-			xfers[idx].tx_buf = &tx_buf[idx];
-		xfers[idx].len = 2;
-		spi_message_add_tail(&xfers[idx], &msg);
-	}
-
-	ret = spi_sync(spi, &msg);
-
-	if (count == 1)
-		_rx_buf[0] = command[2];
-
-	kfree(spi_data);
-
-	return ret;
-}
 
-static int ad7879_spi_multi_read(struct device *dev,
-				 u8 first_reg, u8 count, u16 *buf)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return ad7879_spi_xfer(spi, AD7879_READCMD(first_reg), count, NULL, buf);
-}
-
-static int ad7879_spi_read(struct device *dev, u8 reg)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	u16 ret, dummy;
-
-	return ad7879_spi_xfer(spi, AD7879_READCMD(reg), 1, &dummy, &ret) ? : ret;
-}
-
-static int ad7879_spi_write(struct device *dev, u8 reg, u16 val)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	u16 dummy;
-
-	return ad7879_spi_xfer(spi, AD7879_WRITECMD(reg), 1, &val, &dummy);
-}
-
-static const struct ad7879_bus_ops ad7879_spi_bus_ops = {
-	.bustype	= BUS_SPI,
-	.read		= ad7879_spi_read,
-	.multi_read	= ad7879_spi_multi_read,
-	.write		= ad7879_spi_write,
+#define AD7879_CMD_MAGIC     0xE000
+#define AD7879_CMD_READ      BIT(10)
+
+static const struct regmap_config ad7879_spi_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.max_register = 15,
+	.read_flag_mask = AD7879_CMD_MAGIC | AD7879_CMD_READ,
+	.write_flag_mask = AD7879_CMD_MAGIC,
 };
 
 static int ad7879_spi_probe(struct spi_device *spi)
 {
 	struct ad7879 *ts;
+	struct regmap *regmap;
 	int err;
 
 	/* don't exceed max specified SPI CLK frequency */
@@ -125,11 +45,15 @@ static int ad7879_spi_probe(struct spi_device *spi)
 	spi->bits_per_word = 16;
 	err = spi_setup(spi);
 	if (err) {
-	        dev_dbg(&spi->dev, "spi master doesn't support 16 bits/word\n");
-	        return err;
+		dev_dbg(&spi->dev, "spi master doesn't support 16 bits/word\n");
+		return err;
 	}
 
-	ts = ad7879_probe(&spi->dev, AD7879_DEVID, spi->irq, &ad7879_spi_bus_ops);
+	regmap = devm_regmap_init_spi(spi, &ad7879_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ts = ad7879_probe(&spi->dev, regmap, spi->irq, BUS_SPI, AD7879_DEVID);
 	if (IS_ERR(ts))
 		return PTR_ERR(ts);
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e16a44667da7..6465db7a1b20 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -26,9 +26,8 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/spi/spi.h>
-#include <linux/i2c.h>
 #include <linux/gpio.h>
 
 #include <linux/input/touchscreen.h>
@@ -106,8 +105,7 @@ enum {
 #define	TS_PEN_UP_TIMEOUT		msecs_to_jiffies(50)
 
 struct ad7879 {
-	const struct ad7879_bus_ops *bops;
-
+	struct regmap		*regmap;
 	struct device		*dev;
 	struct input_dev	*input;
 	struct timer_list	timer;
@@ -137,17 +135,32 @@ struct ad7879 {
 
 static int ad7879_read(struct ad7879 *ts, u8 reg)
 {
-	return ts->bops->read(ts->dev, reg);
-}
+	unsigned int val;
+	int error;
 
-static int ad7879_multi_read(struct ad7879 *ts, u8 first_reg, u8 count, u16 *buf)
-{
-	return ts->bops->multi_read(ts->dev, first_reg, count, buf);
+	error = regmap_read(ts->regmap, reg, &val);
+	if (error) {
+		dev_err(ts->dev, "failed to read register %#02x: %d\n",
+			reg, error);
+		return error;
+	}
+
+	return val;
 }
 
 static int ad7879_write(struct ad7879 *ts, u8 reg, u16 val)
 {
-	return ts->bops->write(ts->dev, reg, val);
+	int error;
+
+	error = regmap_write(ts->regmap, reg, val);
+	if (error) {
+		dev_err(ts->dev,
+			"failed to write %#04x to register %#02x: %d\n",
+			val, reg, error);
+		return error;
+	}
+
+	return 0;
 }
 
 static int ad7879_report(struct ad7879 *ts)
@@ -234,7 +247,8 @@ static irqreturn_t ad7879_irq(int irq, void *handle)
 {
 	struct ad7879 *ts = handle;
 
-	ad7879_multi_read(ts, AD7879_REG_XPLUS, AD7879_NR_SENSE, ts->conversion_data);
+	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
+			 ts->conversion_data, AD7879_NR_SENSE);
 
 	if (!ad7879_report(ts))
 		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
@@ -511,8 +525,8 @@ static int ad7879_parse_dt(struct device *dev, struct ad7879 *ts)
 	return 0;
 }
 
-struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
-			    const struct ad7879_bus_ops *bops)
+struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
+			    int irq, u16 bustype, u8 devid)
 {
 	struct ad7879_platform_data *pdata = dev_get_platdata(dev);
 	struct ad7879 *ts;
@@ -520,7 +534,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	int err;
 	u16 revid;
 
-	if (!irq) {
+	if (irq <= 0) {
 		dev_err(dev, "No IRQ specified\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -553,10 +567,10 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ts->bops = bops;
 	ts->dev = dev;
 	ts->input = input_dev;
 	ts->irq = irq;
+	ts->regmap = regmap;
 
 	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
@@ -564,7 +578,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	input_dev->name = "AD7879 Touchscreen";
 	input_dev->phys = ts->phys;
 	input_dev->dev.parent = dev;
-	input_dev->id.bustype = bops->bustype;
+	input_dev->id.bustype = bustype;
 
 	input_dev->open = ad7879_open;
 	input_dev->close = ad7879_close;
diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
index 6fd13c48d373..1131f8aa118b 100644
--- a/drivers/input/touchscreen/ad7879.h
+++ b/drivers/input/touchscreen/ad7879.h
@@ -13,18 +13,12 @@
 
 struct ad7879;
 struct device;
-
-struct ad7879_bus_ops {
-	u16 bustype;
-	int (*read)(struct device *dev, u8 reg);
-	int (*multi_read)(struct device *dev, u8 first_reg, u8 count, u16 *buf);
-	int (*write)(struct device *dev, u8 reg, u16 val);
-};
+struct regmap;
 
 extern const struct dev_pm_ops ad7879_pm_ops;
 
-struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned irq,
-			    const struct ad7879_bus_ops *bops);
+struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
+			    int irq, u16 bustype, u8 devid);
 void ad7879_remove(struct ad7879 *);
 
 #endif
-- 
2.11.0.483.g087da7b7c-goog

