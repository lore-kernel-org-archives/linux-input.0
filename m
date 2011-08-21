From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: ad714x - fix endianness issues
Date: Sun, 21 Aug 2011 13:09:03 -0700
Message-ID: <1313957345-22608-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:42483 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1HUUJK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 16:09:10 -0400
Received: by iye16 with SMTP id 16so9091424iye.1
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 13:09:09 -0700 (PDT)
In-Reply-To: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

From: Michael Hennerich <michael.hennerich@analog.com>

Allow driver to be used on Big Endian boxes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/ad714x-i2c.c |   34 ++++++++++------------------------
 drivers/input/misc/ad714x-spi.c |   24 +++++++++++++++---------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index e21deb1..00a6a22 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -32,17 +32,12 @@ static int ad714x_i2c_write(struct device *dev, unsigned short reg,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret = 0;
-	u8 *_reg = (u8 *)&reg;
-	u8 *_data = (u8 *)&data;
-
-	u8 tx[4] = {
-		_reg[1],
-		_reg[0],
-		_data[1],
-		_data[0]
+	unsigned short tx[2] = {
+		cpu_to_be16(reg),
+		cpu_to_be16(data)
 	};
 
-	ret = i2c_master_send(client, tx, 4);
+	ret = i2c_master_send(client, (u8 *)tx, 4);
 	if (ret < 0)
 		dev_err(&client->dev, "I2C write error\n");
 
@@ -54,25 +49,16 @@ static int ad714x_i2c_read(struct device *dev, unsigned short reg,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret = 0;
-	u8 *_reg = (u8 *)&reg;
-	u8 *_data = (u8 *)data;
+	unsigned short tx = cpu_to_be16(reg);
 
-	u8 tx[2] = {
-		_reg[1],
-		_reg[0]
-	};
-	u8 rx[2];
-
-	ret = i2c_master_send(client, tx, 2);
+	ret = i2c_master_send(client, (u8 *)&tx, 2);
 	if (ret >= 0)
-		ret = i2c_master_recv(client, rx, 2);
+		ret = i2c_master_recv(client, (u8 *)data, 2);
 
-	if (unlikely(ret < 0)) {
+	if (unlikely(ret < 0))
 		dev_err(&client->dev, "I2C read error\n");
-	} else {
-		_data[0] = rx[1];
-		_data[1] = rx[0];
-	}
+	else
+		*data = be16_to_cpu(*data);
 
 	return ret;
 }
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index da83ac9..0c7f948 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -6,7 +6,7 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/input.h>	/* BUS_I2C */
+#include <linux/input.h>	/* BUS_SPI */
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/pm.h>
@@ -30,22 +30,28 @@ static int ad714x_spi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ad714x_spi_pm, ad714x_spi_suspend, ad714x_spi_resume);
 
-static int ad714x_spi_read(struct device *dev, unsigned short reg,
-		unsigned short *data)
+static int ad714x_spi_read(struct device *dev,
+			   unsigned short reg, unsigned short *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	unsigned short tx = AD714x_SPI_CMD_PREFIX | AD714x_SPI_READ | reg;
+	unsigned short tx = cpu_to_be16(AD714x_SPI_CMD_PREFIX |
+					AD714x_SPI_READ | reg);
+	int ret;
 
-	return spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, 2);
+	ret = spi_write_then_read(spi, &tx, 2, data, 2);
+
+	*data = be16_to_cpup(data);
+
+	return ret;
 }
 
-static int ad714x_spi_write(struct device *dev, unsigned short reg,
-		unsigned short data)
+static int ad714x_spi_write(struct device *dev,
+			    unsigned short reg, unsigned short data)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	unsigned short tx[2] = {
-		AD714x_SPI_CMD_PREFIX | reg,
-		data
+		cpu_to_be16(AD714x_SPI_CMD_PREFIX | reg),
+		cpu_to_be16(data)
 	};
 
 	return spi_write(spi, (u8 *)tx, 4);
-- 
1.7.6

