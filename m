From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/7] Input: cyttsp - device does not belong in bus structure
Date: Mon, 14 Nov 2011 00:16:01 -0800
Message-ID: <20111114081601.10141.59566.stgit@hammer.corenet.prv>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1KNIQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:16:05 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:16:05 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

bus structure is supposed to be constant and shared between several
instances of the device.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |    8 +++--
 drivers/input/touchscreen/cyttsp_core.h |    8 +++--
 drivers/input/touchscreen/cyttsp_i2c.c  |   31 +++++++++++---------
 drivers/input/touchscreen/cyttsp_spi.c  |   48 ++++++++++++++++---------------
 4 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 54f36d6..4bc9fcd 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -145,7 +145,7 @@ struct cyttsp {
 	struct input_dev *input;
 	char phys[32];
 	const struct cyttsp_platform_data *platform_data;
-	struct cyttsp_bus_ops *bus_ops;
+	const struct cyttsp_bus_ops *bus_ops;
 	struct cyttsp_bootloader_data bl_data;
 	struct cyttsp_sysinfo_data sysinfo_data;
 	struct completion bl_ready;
@@ -169,7 +169,7 @@ static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
 		return -EINVAL;
 
 	for (tries = 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
-		retval = ts->bus_ops->read(ts->bus_ops, command, length, buf);
+		retval = ts->bus_ops->read(ts->dev, command, length, buf);
 		if (retval)
 			msleep(CY_DELAY_DFLT);
 	}
@@ -187,7 +187,7 @@ static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
 		return -EINVAL;
 
 	for (tries = 0; tries < CY_NUM_RETRY && (retval < 0); tries++) {
-		retval = ts->bus_ops->write(ts->bus_ops, command, length, buf);
+		retval = ts->bus_ops->write(ts->dev, command, length, buf);
 		if (retval)
 			msleep(CY_DELAY_DFLT);
 	}
@@ -672,7 +672,7 @@ static void cyttsp_close(struct input_dev *dev)
 	free_irq(ts->irq, ts);
 }
 
-void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
+void *cyttsp_core_init(const struct cyttsp_bus_ops *bus_ops,
 		       struct device *dev, int irq)
 {
 	struct input_dev *input_device;
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 1a0fd9d..36f94ec 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -42,12 +42,12 @@
 
 
 struct cyttsp_bus_ops {
-	s32 (*write)(void *handle, u8 addr, u8 length, const void *values);
-	s32 (*read)(void *handle, u8 addr, u8 length, void *values);
-	struct device *dev;
+	int (*write)(struct device *dev,
+		     u8 addr, u8 length, const void *values);
+	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
 };
 
-void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
+void *cyttsp_core_init(const struct cyttsp_bus_ops *bus_ops,
 		       struct device *dev, int irq);
 
 void cyttsp_core_release(void *handle);
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 697c7a88..5911d9c 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -37,16 +37,16 @@
 #define CY_I2C_DATA_SIZE  128
 
 struct cyttsp_i2c {
-	struct cyttsp_bus_ops ops;
 	struct i2c_client *client;
 	void *ttsp_client;
 	u8 wr_buf[CY_I2C_DATA_SIZE];
 };
 
-static s32 ttsp_i2c_read_block_data(void *handle, u8 addr,
-	u8 length, void *values)
+static int ttsp_i2c_read_block_data(struct device *dev,
+				    u8 addr, u8 length, void *values)
 {
-	struct cyttsp_i2c *ts = container_of(handle, struct cyttsp_i2c, ops);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
 	int retval = 0;
 
 	retval = i2c_master_send(ts->client, &addr, 1);
@@ -61,10 +61,11 @@ static s32 ttsp_i2c_read_block_data(void *handle, u8 addr,
 	return (retval < 0) ? retval : 0;
 }
 
-static s32 ttsp_i2c_write_block_data(void *handle, u8 addr,
-	u8 length, const void *values)
+static int ttsp_i2c_write_block_data(struct device *dev,
+				     u8 addr, u8 length, const void *values)
 {
-	struct cyttsp_i2c *ts = container_of(handle, struct cyttsp_i2c, ops);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
 	int retval;
 
 	ts->wr_buf[0] = addr;
@@ -78,8 +79,13 @@ static s32 ttsp_i2c_write_block_data(void *handle, u8 addr,
 	return (retval < 0) ? retval : 0;
 }
 
+static const struct cyttsp_bus_ops cyttsp_i2c_bus_ops = {
+	.write		= ttsp_i2c_write_block_data,
+	.read		= ttsp_i2c_read_block_data,
+};
+
 static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+				      const struct i2c_device_id *id)
 {
 	struct cyttsp_i2c *ts;
 
@@ -96,11 +102,8 @@ static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 	/* register driver_data */
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
-	ts->ops.write = ttsp_i2c_write_block_data;
-	ts->ops.read = ttsp_i2c_read_block_data;
-	ts->ops.dev = &client->dev;
 
-	ts->ttsp_client = cyttsp_core_init(&ts->ops, &client->dev, client->irq);
+	ts->ttsp_client = cyttsp_core_init(&cyttsp_i2c_bus_ops, &client->dev, client->irq);
 	if (IS_ERR(ts->ttsp_client)) {
 		int retval = PTR_ERR(ts->ttsp_client);
 		kfree(ts);
@@ -114,11 +117,11 @@ static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 /* registered in driver struct */
 static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
 {
-	struct cyttsp_i2c *ts;
+	struct cyttsp_i2c *ts = i2c_get_clientdata(client);
 
-	ts = i2c_get_clientdata(client);
 	cyttsp_core_release(ts->ttsp_client);
 	kfree(ts);
+
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 8138a96..4540262 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -45,8 +45,7 @@
 #define CY_SPI_BITS_PER_WORD 8
 
 struct cyttsp_spi {
-	struct cyttsp_bus_ops bus_ops;
-	struct spi_device *spi_client;
+	struct spi_device *spi;
 	void *ttsp_client;
 	u8 wr_buf[CY_SPI_DATA_BUF_SIZE];
 	u8 rd_buf[CY_SPI_DATA_BUF_SIZE];
@@ -62,7 +61,7 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 	int retval;
 
 	if (length > CY_SPI_DATA_SIZE) {
-		dev_dbg(ts->bus_ops.dev,
+		dev_dbg(&ts->spi->dev,
 			"%s: length %d is too big.\n",
 			__func__, length);
 		return -EINVAL;
@@ -99,9 +98,9 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 		spi_message_add_tail(&xfer[1], &msg);
 	}
 
-	retval = spi_sync(ts->spi_client, &msg);
+	retval = spi_sync(ts->spi, &msg);
 	if (retval < 0) {
-		dev_dbg(ts->bus_ops.dev,
+		dev_dbg(&ts->spi->dev,
 			"%s: spi_sync() error %d, len=%d, op=%d\n",
 			__func__, retval, xfer[1].len, op);
 
@@ -118,11 +117,11 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 	else {
 		int i;
 		for (i = 0; i < (CY_SPI_CMD_BYTES); i++)
-			dev_dbg(ts->bus_ops.dev,
+			dev_dbg(&ts->spi->dev,
 				"%s: test rd_buf[%d]:0x%02x\n",
 				__func__, i, rd_buf[i]);
 		for (i = 0; i < (length); i++)
-			dev_dbg(ts->bus_ops.dev,
+			dev_dbg(&ts->spi->dev,
 				"%s: test buf[%d]:0x%02x\n",
 				__func__, i, buf[i]);
 
@@ -133,11 +132,11 @@ static int cyttsp_spi_xfer(u8 op, struct cyttsp_spi *ts,
 	return retval;
 }
 
-static s32 ttsp_spi_read_block_data(void *handle, u8 addr,
-				    u8 length, void *data)
+static int ttsp_spi_read_block_data(struct device *dev,
+				    u8 addr, u8 length, void *data)
 {
-	struct cyttsp_spi *ts =
-		container_of(handle, struct cyttsp_spi, bus_ops);
+	struct spi_device *spi = to_spi_device(dev);
+	struct cyttsp_spi *ts = spi_get_drvdata(spi);
 	int retval;
 
 	retval = cyttsp_spi_xfer(CY_SPI_RD_OP, ts, addr, data, length);
@@ -156,11 +155,11 @@ static s32 ttsp_spi_read_block_data(void *handle, u8 addr,
 	return retval;
 }
 
-static s32 ttsp_spi_write_block_data(void *handle, u8 addr,
-				     u8 length, const void *data)
+static int ttsp_spi_write_block_data(struct device *dev,
+				     u8 addr, u8 length, const void *data)
 {
-	struct cyttsp_spi *ts =
-		container_of(handle, struct cyttsp_spi, bus_ops);
+	struct spi_device *spi = to_spi_device(dev);
+	struct cyttsp_spi *ts = spi_get_drvdata(spi);
 	int retval;
 
 	retval = cyttsp_spi_xfer(CY_SPI_WR_OP, ts, addr, (void *)data, length);
@@ -179,6 +178,11 @@ static s32 ttsp_spi_write_block_data(void *handle, u8 addr,
 	return retval;
 }
 
+static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
+	.write		= ttsp_spi_write_block_data,
+	.read		= ttsp_spi_read_block_data,
+};
+
 static int __devinit cyttsp_spi_probe(struct spi_device *spi)
 {
 	struct cyttsp_spi *ts;
@@ -200,30 +204,28 @@ static int __devinit cyttsp_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	ts->spi_client = spi;
-	dev_set_drvdata(&spi->dev, ts);
-	ts->bus_ops.write = ttsp_spi_write_block_data;
-	ts->bus_ops.read = ttsp_spi_read_block_data;
-	ts->bus_ops.dev = &spi->dev;
+	ts->spi = spi;
+	spi_set_drvdata(spi, ts);
 
-	ts->ttsp_client = cyttsp_core_init(&ts->bus_ops, &spi->dev, spi->irq);
+	ts->ttsp_client = cyttsp_core_init(&cyttsp_spi_bus_ops, &spi->dev, spi->irq);
 	if (IS_ERR(ts->ttsp_client)) {
 		int retval = PTR_ERR(ts->ttsp_client);
 		kfree(ts);
 		return retval;
 	}
 
-	dev_dbg(ts->bus_ops.dev, "%s: Registration complete\n", __func__);
+	dev_dbg(&ts->spi->dev, "%s: Registration complete\n", __func__);
 
 	return 0;
 }
 
 static int __devexit cyttsp_spi_remove(struct spi_device *spi)
 {
-	struct cyttsp_spi *ts = dev_get_drvdata(&spi->dev);
+	struct cyttsp_spi *ts = spi_get_drvdata(spi);
 
 	cyttsp_core_release(ts->ttsp_client);
 	kfree(ts);
+
 	return 0;
 }
 

