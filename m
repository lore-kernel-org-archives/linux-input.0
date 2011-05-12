From: <michael.hennerich@analog.com>
Subject: [PATCH v2 6/6] input: misc: AD714x: Fix endianness issues.
Date: Thu, 12 May 2011 10:45:11 +0200
Message-ID: <1305189911-24769-6-git-send-email-michael.hennerich@analog.com>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:36626
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754558Ab1ELI4E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 04:56:04 -0400
In-Reply-To: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Add support for Big Endian.
Force SPI bus into the default 8-bit mode.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x-i2c.c |   43 ++++++++++----------------------------
 drivers/input/misc/ad714x-spi.c |   33 +++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index fb6564e..9794b36 100644
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
@@ -82,14 +68,9 @@ static int ad714x_i2c_read_seq(struct device *dev, unsigned short reg,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret = 0, i;
-	u8 *_reg = (u8 *)&reg;
-
-	u8 tx[2] = {
-		_reg[1],
-		_reg[0]
-	};
+	unsigned short tx = cpu_to_be16(reg);
 
-	ret = i2c_master_send(client, tx, 2);
+	ret = i2c_master_send(client, (u8 *)&tx, 2);
 	if (ret >= 0)
 		ret = i2c_master_recv(client, (u8 *)data, len * 2);
 
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index d352aa5..4418b5b 100644
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
@@ -34,18 +34,31 @@ static int ad714x_spi_read(struct device *dev, unsigned short reg,
 		unsigned short *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	unsigned short tx = AD714x_SPI_CMD_PREFIX | AD714x_SPI_READ | reg;
+	int ret;
+	unsigned short tx = cpu_to_be16(AD714x_SPI_CMD_PREFIX |
+					AD714x_SPI_READ | reg);
 
-	return spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, 2);
+	ret = spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, 2);
+
+	*data = be16_to_cpu(*data);
+
+	return ret;
 }
 
 static int ad714x_spi_read_seq(struct device *dev, unsigned short reg,
 		unsigned short *data, unsigned len)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	unsigned short tx = AD714x_SPI_CMD_PREFIX | AD714x_SPI_READ | reg;
+	int ret, i;
+	unsigned short tx = cpu_to_be16(AD714x_SPI_CMD_PREFIX |
+					AD714x_SPI_READ | reg);
+
+	ret = spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, len * 2);
 
-	return spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, len * 2);
+	for (i = 0; i < len; i++)
+		data[i] = be16_to_cpu(data[i]);
+
+	return ret;
 }
 
 static int ad714x_spi_write(struct device *dev, unsigned short reg,
@@ -53,8 +66,8 @@ static int ad714x_spi_write(struct device *dev, unsigned short reg,
 {
 	struct spi_device *spi = to_spi_device(dev);
 	unsigned short tx[2] = {
-		AD714x_SPI_CMD_PREFIX | reg,
-		data
+		cpu_to_be16(AD714x_SPI_CMD_PREFIX | reg),
+		cpu_to_be16(data)
 	};
 
 	return spi_write(spi, (u8 *)tx, 4);
@@ -63,6 +76,12 @@ static int ad714x_spi_write(struct device *dev, unsigned short reg,
 static int __devinit ad714x_spi_probe(struct spi_device *spi)
 {
 	struct ad714x_chip *chip;
+	int err;
+
+	spi->bits_per_word = 8;
+	err = spi_setup(spi);
+	if (err < 0)
+		return err;
 
 	chip = ad714x_probe(&spi->dev, BUS_SPI, spi->irq,
 			    ad714x_spi_read, ad714x_spi_read_seq,
-- 
1.6.0.2


