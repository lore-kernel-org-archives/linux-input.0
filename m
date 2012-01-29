From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1][INCREMENTAL] Input: cyttsp - Fixes to clean-up patch
Date: Sat, 28 Jan 2012 22:18:02 -0800
Message-ID: <20120129061802.GA25977@core.coreip.homeip.net>
References: <1327816430-19887-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35250 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab2A2GSI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 01:18:08 -0500
Received: by pbaa10 with SMTP id a10so2849215pba.19
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2012 22:18:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327816430-19887-1-git-send-email-javier@dowhile0.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org

On Sun, Jan 29, 2012 at 06:53:50AM +0100, Javier Martinez Canillas wrote:
> This is patch fixes two bugs in Dmitry's last cleanup patch.
> 
> 1- The hardware tracking ids are stored in the ids array and the information for
>    each contact is obtained calling cyttsp_get_tch() with an index. In the clean-up
>    patch the value of the tracking id was used instead of the contact index.
> 

Oops, thank you for fixing that.

> 2- i2c_set_clientdata() is called after the generic cyttsp_probe() function and
>    this function calls cyttsp_power_on() that sends an ttsp command to the device
>    and needs the client data before is set. The fix is to execute cyttsp_power_on
>    inside the transport specific probe function (I2C, SPI) after the generic probe
>    function is executed and the client data is set.
> 

Not quite happy about this one, how about we pass cyttsp directly to bus
methods instead of relying on drvdata (as in the patch below)?

Thanks.

-- 
Dmitry

Input: cyttsp - pass cyttsp structure to bus methods

We may not have set drvdata by the time we try to access the bus,
so let's pass cyttsp structure directly instead.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/cyttsp_core.c |    4 ++--
 drivers/input/touchscreen/cyttsp_core.h |    6 ++++--
 drivers/input/touchscreen/cyttsp_i2c.c  |    9 ++++-----
 drivers/input/touchscreen/cyttsp_spi.c  |   28 ++++++++++++++--------------
 4 files changed, 24 insertions(+), 23 deletions(-)


diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index ff74a33..12cd1da 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -84,7 +84,7 @@ static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
 	int tries;
 
 	for (tries = 0; tries < CY_NUM_RETRY; tries++) {
-		error = ts->bus_ops->read(ts->dev, command, length, buf);
+		error = ts->bus_ops->read(ts, command, length, buf);
 		if (!error)
 			return 0;
 
@@ -101,7 +101,7 @@ static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
 	int tries;
 
 	for (tries = 0; tries < CY_NUM_RETRY; tries++) {
-		error = ts->bus_ops->write(ts->dev, command, length, buf);
+		error = ts->bus_ops->write(ts, command, length, buf);
 		if (!error)
 			return 0;
 
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index 560f959..1aa3c69 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -108,11 +108,13 @@ struct cyttsp_bootloader_data {
 	u8 cid_2;
 };
 
+struct cyttsp;
+
 struct cyttsp_bus_ops {
 	u16 bustype;
-	int (*write)(struct device *dev,
+	int (*write)(struct cyttsp *ts,
 		     u8 addr, u8 length, const void *values);
-	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
+	int (*read)(struct cyttsp *ts, u8 addr, u8 length, void *values);
 };
 
 enum cyttsp_state {
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 6394c8e..c7110cc 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -34,10 +34,10 @@
 
 #define CY_I2C_DATA_SIZE	128
 
-static int cyttsp_i2c_read_block_data(struct device *dev,
+static int cyttsp_i2c_read_block_data(struct cyttsp *ts,
 				      u8 addr, u8 length, void *values)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(ts->dev);
 	struct i2c_msg msgs[] = {
 		{
 			.addr = client->addr,
@@ -61,11 +61,10 @@ static int cyttsp_i2c_read_block_data(struct device *dev,
 	return retval != ARRAY_SIZE(msgs) ? -EIO : 0;
 }
 
-static int cyttsp_i2c_write_block_data(struct device *dev,
+static int cyttsp_i2c_write_block_data(struct cyttsp *ts,
 				       u8 addr, u8 length, const void *values)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp *ts = i2c_get_clientdata(client);
+	struct i2c_client *client = to_i2c_client(ts->dev);
 	int retval;
 
 	ts->xfer_buf[0] = addr;
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index d404cd2..9db5f87 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -43,11 +43,10 @@
 #define CY_SPI_DATA_BUF_SIZE	(CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
 #define CY_SPI_BITS_PER_WORD	8
 
-static int cyttsp_spi_xfer(u8 op, struct device *dev,
-			   u8 reg, u8 *buf, int length)
+static int cyttsp_spi_xfer(struct cyttsp *ts,
+			   u8 op, u8 reg, u8 *buf, int length)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct cyttsp *ts = spi_get_drvdata(spi);
+	struct spi_device *spi = to_spi_device(ts->dev);
 	struct spi_message msg;
 	struct spi_transfer xfer[2];
 	u8 *wr_buf = &ts->xfer_buf[0];
@@ -56,7 +55,8 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 	int i;
 
 	if (length > CY_SPI_DATA_SIZE) {
-		dev_err(dev, "%s: length %d is too big.\n", __func__, length);
+		dev_err(ts->dev, "%s: length %d is too big.\n",
+			__func__, length);
 		return -EINVAL;
 	}
 
@@ -95,13 +95,13 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 		break;
 
 	default:
-		dev_err(dev, "%s: bad operation code=%d\n", __func__, op);
+		dev_err(ts->dev, "%s: bad operation code=%d\n", __func__, op);
 		return -EINVAL;
 	}
 
 	retval = spi_sync(spi, &msg);
 	if (retval < 0) {
-		dev_dbg(dev, "%s: spi_sync() error %d, len=%d, op=%d\n",
+		dev_dbg(ts->dev, "%s: spi_sync() error %d, len=%d, op=%d\n",
 			__func__, retval, xfer[1].len, op);
 
 		/*
@@ -114,13 +114,13 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 	if (rd_buf[CY_SPI_SYNC_BYTE] != CY_SPI_SYNC_ACK1 ||
 	    rd_buf[CY_SPI_SYNC_BYTE + 1] != CY_SPI_SYNC_ACK2) {
 
-		dev_dbg(dev, "%s: operation %d failed\n", __func__, op);
+		dev_dbg(ts->dev, "%s: operation %d failed\n", __func__, op);
 
 		for (i = 0; i < CY_SPI_CMD_BYTES; i++)
-			dev_dbg(dev, "%s: test rd_buf[%d]:0x%02x\n",
+			dev_dbg(ts->dev, "%s: test rd_buf[%d]:0x%02x\n",
 				__func__, i, rd_buf[i]);
 		for (i = 0; i < length; i++)
-			dev_dbg(dev, "%s: test buf[%d]:0x%02x\n",
+			dev_dbg(ts->dev, "%s: test buf[%d]:0x%02x\n",
 				__func__, i, buf[i]);
 
 		return -EIO;
@@ -129,16 +129,16 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 	return 0;
 }
 
-static int cyttsp_spi_read_block_data(struct device *dev,
+static int cyttsp_spi_read_block_data(struct cyttsp *ts,
 				      u8 addr, u8 length, void *data)
 {
-	return cyttsp_spi_xfer(CY_SPI_RD_OP, dev, addr, data, length);
+	return cyttsp_spi_xfer(ts, CY_SPI_RD_OP, addr, data, length);
 }
 
-static int cyttsp_spi_write_block_data(struct device *dev,
+static int cyttsp_spi_write_block_data(struct cyttsp *ts,
 				       u8 addr, u8 length, const void *data)
 {
-	return cyttsp_spi_xfer(CY_SPI_WR_OP, dev, addr, (void *)data, length);
+	return cyttsp_spi_xfer(ts, CY_SPI_WR_OP, addr, (void *)data, length);
 }
 
 static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
