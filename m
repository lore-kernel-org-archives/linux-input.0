From: <michael.hennerich@analog.com>
Subject: [PATCH 1/5] input: misc: AD714x: The interrupt status registers should be read in row.
Date: Tue, 10 May 2011 13:35:05 +0200
Message-ID: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:42588 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab1EJLog (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2011 07:44:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The interrupt status registers should be read in row to avoid invalid data.

Implement read sequence function for both bus options.
Always use it for reading the interrupt status registers.
Read sequence saves 50% of bus transactions compared to single register reads.
So use it also for the result registers, which are also located in row.
Update copyright notice.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x-i2c.c |   30 ++++++++++++++++++++++++++++--
 drivers/input/misc/ad714x-spi.c |   14 ++++++++++++--
 drivers/input/misc/ad714x.c     |   35 +++++++++++++++++------------------
 drivers/input/misc/ad714x.h     |    7 +++++--
 4 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index e21deb1..fb6564e 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -1,7 +1,7 @@
 /*
  * AD714X CapTouch Programmable Controller driver (I2C bus)
  *
- * Copyright 2009 Analog Devices Inc.
+ * Copyright 2009-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -77,13 +77,39 @@ static int ad714x_i2c_read(struct device *dev, unsigned short reg,
 	return ret;
 }

+static int ad714x_i2c_read_seq(struct device *dev, unsigned short reg,
+				unsigned short *data, unsigned len)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret = 0, i;
+	u8 *_reg = (u8 *)&reg;
+
+	u8 tx[2] = {
+		_reg[1],
+		_reg[0]
+	};
+
+	ret = i2c_master_send(client, tx, 2);
+	if (ret >= 0)
+		ret = i2c_master_recv(client, (u8 *)data, len * 2);
+
+	if (unlikely(ret < 0))
+		dev_err(&client->dev, "I2C read error\n");
+	else
+		for (i = 0; i < len; i++)
+			data[i] = be16_to_cpu(data[i]);
+
+	return ret;
+}
+
 static int __devinit ad714x_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct ad714x_chip *chip;

 	chip = ad714x_probe(&client->dev, BUS_I2C, client->irq,
-			    ad714x_i2c_read, ad714x_i2c_write);
+			    ad714x_i2c_read, ad714x_i2c_read_seq,
+			    ad714x_i2c_write);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);

diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 4120dd5..a0cb115 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -1,7 +1,7 @@
 /*
  * AD714X CapTouch Programmable Controller driver (SPI bus)
  *
- * Copyright 2009 Analog Devices Inc.
+ * Copyright 2009-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -39,6 +39,15 @@ static int ad714x_spi_read(struct device *dev, unsigned short reg,
 	return spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, 2);
 }

+static int ad714x_spi_read_seq(struct device *dev, unsigned short reg,
+		unsigned short *data, unsigned len)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned short tx = AD714x_SPI_CMD_PREFIX | AD714x_SPI_READ | reg;
+
+	return spi_write_then_read(spi, (u8 *)&tx, 2, (u8 *)data, len * 2);
+}
+
 static int ad714x_spi_write(struct device *dev, unsigned short reg,
 		unsigned short data)
 {
@@ -56,7 +65,8 @@ static int __devinit ad714x_spi_probe(struct spi_device *spi)
 	struct ad714x_chip *chip;

 	chip = ad714x_probe(&spi->dev, BUS_SPI, spi->irq,
-			    ad714x_spi_read, ad714x_spi_write);
+			    ad714x_spi_read, ad714x_spi_read_seq,
+			    ad714x_spi_write);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index c431d09..eb352fb 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -1,7 +1,7 @@
 /*
  * AD714X CapTouch Programmable Controller driver supporting AD7142/3/7/8/7A
  *
- * Copyright 2009 Analog Devices Inc.
+ * Copyright 2009-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -131,8 +131,8 @@ struct ad714x_driver_data {
  * of spi/i2c device
  */
 struct ad714x_chip {
-	unsigned short h_state;
 	unsigned short l_state;
+	unsigned short h_state;
 	unsigned short c_state;
 	unsigned short adc_reg[STAGE_NUM];
 	unsigned short amb_reg[STAGE_NUM];
@@ -144,6 +144,7 @@ struct ad714x_chip {
 	int irq;
 	struct device *dev;
 	ad714x_read_t read;
+	ad714x_read_seq_t read_seq;
 	ad714x_write_t write;

 	struct mutex mutex;
@@ -279,9 +280,11 @@ static void ad714x_slider_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
 	struct ad714x_slider_plat *hw = &ad714x->hw->slider[idx];
 	int i;

+	ad714x->read_seq(ad714x->dev, CDC_RESULT_S0 + hw->start_stage,
+			&ad714x->adc_reg[hw->start_stage],
+			hw->end_stage - hw->start_stage + 1);
+
 	for (i = hw->start_stage; i <= hw->end_stage; i++) {
-		ad714x->read(ad714x->dev, CDC_RESULT_S0 + i,
-			&ad714x->adc_reg[i]);
 		ad714x->read(ad714x->dev,
 				STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
 				&ad714x->amb_reg[i]);
@@ -451,9 +454,11 @@ static void ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
 	struct ad714x_wheel_plat *hw = &ad714x->hw->wheel[idx];
 	int i;

+	ad714x->read_seq(ad714x->dev, CDC_RESULT_S0 + hw->start_stage,
+			&ad714x->adc_reg[hw->start_stage],
+			hw->end_stage - hw->start_stage + 1);
+
 	for (i = hw->start_stage; i <= hw->end_stage; i++) {
-		ad714x->read(ad714x->dev, CDC_RESULT_S0 + i,
-			&ad714x->adc_reg[i]);
 		ad714x->read(ad714x->dev,
 				STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
 				&ad714x->amb_reg[i]);
@@ -1025,9 +1030,7 @@ static void ad714x_hw_init(struct ad714x_chip *ad714x)
 	ad714x->write(ad714x->dev, AD714X_STG_CAL_EN_REG, 0xFFF);

 	/* clear all interrupts */
-	ad714x->read(ad714x->dev, STG_LOW_INT_STA_REG, &data);
-	ad714x->read(ad714x->dev, STG_HIGH_INT_STA_REG, &data);
-	ad714x->read(ad714x->dev, STG_COM_INT_STA_REG, &data);
+	ad714x->read_seq(ad714x->dev, STG_LOW_INT_STA_REG, &ad714x->l_state, 3);
 }

 static irqreturn_t ad714x_interrupt_thread(int irq, void *data)
@@ -1037,9 +1040,7 @@ static irqreturn_t ad714x_interrupt_thread(int irq, void *data)

 	mutex_lock(&ad714x->mutex);

-	ad714x->read(ad714x->dev, STG_LOW_INT_STA_REG, &ad714x->l_state);
-	ad714x->read(ad714x->dev, STG_HIGH_INT_STA_REG, &ad714x->h_state);
-	ad714x->read(ad714x->dev, STG_COM_INT_STA_REG, &ad714x->c_state);
+	ad714x->read_seq(ad714x->dev, STG_LOW_INT_STA_REG, &ad714x->l_state, 3);

 	for (i = 0; i < ad714x->hw->button_num; i++)
 		ad714x_button_state_machine(ad714x, i);
@@ -1057,7 +1058,8 @@ static irqreturn_t ad714x_interrupt_thread(int irq, void *data)

 #define MAX_DEVICE_NUM 8
 struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
-				 ad714x_read_t read, ad714x_write_t write)
+				 ad714x_read_t read, ad714x_read_seq_t read_seq,
+				 ad714x_write_t write)
 {
 	int i, alloc_idx;
 	int error;
@@ -1110,6 +1112,7 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	drv_mem += sizeof(*bt_drv) * ad714x->hw->button_num;

 	ad714x->read = read;
+	ad714x->read_seq = read_seq;
 	ad714x->write = write;
 	ad714x->irq = irq;
 	ad714x->dev = dev;
@@ -1316,8 +1319,6 @@ EXPORT_SYMBOL(ad714x_disable);

 int ad714x_enable(struct ad714x_chip *ad714x)
 {
-	unsigned short data;
-
 	dev_dbg(ad714x->dev, "%s enter\n", __func__);

 	mutex_lock(&ad714x->mutex);
@@ -1331,9 +1332,7 @@ int ad714x_enable(struct ad714x_chip *ad714x)
 	 * otherwise we will get no chance to enter falling-edge irq again
 	 */

-	ad714x->read(ad714x->dev, STG_LOW_INT_STA_REG, &data);
-	ad714x->read(ad714x->dev, STG_HIGH_INT_STA_REG, &data);
-	ad714x->read(ad714x->dev, STG_COM_INT_STA_REG, &data);
+	ad714x->read_seq(ad714x->dev, STG_LOW_INT_STA_REG, &ad714x->l_state, 3);

 	mutex_unlock(&ad714x->mutex);

diff --git a/drivers/input/misc/ad714x.h b/drivers/input/misc/ad714x.h
index 45c54fb..58d5e4e 100644
--- a/drivers/input/misc/ad714x.h
+++ b/drivers/input/misc/ad714x.h
@@ -1,7 +1,7 @@
 /*
  * AD714X CapTouch Programmable Controller driver (bus interfaces)
  *
- * Copyright 2009 Analog Devices Inc.
+ * Copyright 2009-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -15,12 +15,15 @@ struct device;
 struct ad714x_chip;

 typedef int (*ad714x_read_t)(struct device *, unsigned short, unsigned short *);
+typedef int (*ad714x_read_seq_t)(struct device *, unsigned short,
+				 unsigned short *, unsigned len);
 typedef int (*ad714x_write_t)(struct device *, unsigned short, unsigned short);

 int ad714x_disable(struct ad714x_chip *ad714x);
 int ad714x_enable(struct ad714x_chip *ad714x);
 struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
-				 ad714x_read_t read, ad714x_write_t write);
+				 ad714x_read_t read, ad714x_read_seq_t read_seq,
+				 ad714x_write_t write);
 void ad714x_remove(struct ad714x_chip *ad714x);

 #endif
--
1.6.0.2


