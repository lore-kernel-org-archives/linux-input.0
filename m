From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: ad714x - read the interrupt status registers in a row
Date: Sun, 21 Aug 2011 13:09:05 -0700
Message-ID: <1313957345-22608-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33069 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab1HUUJN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 16:09:13 -0400
Received: by yxj19 with SMTP id 19so3131635yxj.19
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2011 13:09:13 -0700 (PDT)
In-Reply-To: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

From: Michael Hennerich <michael.hennerich@analog.com>

The interrupt status registers should be read in row to avoid invalid data.

Alter "read" method for both bus options to allow reading several registers
in a row and make sure we read interrupt status registers properly.

Read sequence saves 50% of bus transactions compared to single register
reads. So use it also for the result registers, which are also located
in a row.

Also update copyright notice.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/ad714x-i2c.c |   11 ++++--
 drivers/input/misc/ad714x-spi.c |   11 ++++--
 drivers/input/misc/ad714x.c     |   62 ++++++++++++++++++++-------------------
 drivers/input/misc/ad714x.h     |    4 +-
 4 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 6c61218..025417d 100644
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
@@ -47,9 +47,10 @@ static int ad714x_i2c_write(struct ad714x_chip *chip,
 }
 
 static int ad714x_i2c_read(struct ad714x_chip *chip,
-			   unsigned short reg, unsigned short *data)
+			   unsigned short reg, unsigned short *data, size_t len)
 {
 	struct i2c_client *client = to_i2c_client(chip->dev);
+	int i;
 	int error;
 
 	chip->xfer_buf[0] = cpu_to_be16(reg);
@@ -58,14 +59,16 @@ static int ad714x_i2c_read(struct ad714x_chip *chip,
 				sizeof(*chip->xfer_buf));
 	if (error >= 0)
 		error = i2c_master_recv(client, (u8 *)chip->xfer_buf,
-					sizeof(*chip->xfer_buf));
+					len * sizeof(*chip->xfer_buf));
 
 	if (unlikely(error < 0)) {
 		dev_err(&client->dev, "I2C read error: %d\n", error);
 		return error;
 	}
 
-	*data = be16_to_cpup(chip->xfer_buf);
+	for (i = 0; i < len; i++)
+		data[i] = be16_to_cpu(chip->xfer_buf[i]);
+
 	return 0;
 }
 
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 306577d..875b508 100644
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
@@ -31,11 +31,12 @@ static int ad714x_spi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ad714x_spi_pm, ad714x_spi_suspend, ad714x_spi_resume);
 
 static int ad714x_spi_read(struct ad714x_chip *chip,
-			   unsigned short reg, unsigned short *data)
+			   unsigned short reg, unsigned short *data, size_t len)
 {
 	struct spi_device *spi = to_spi_device(chip->dev);
 	struct spi_message message;
 	struct spi_transfer xfer[2];
+	int i;
 	int error;
 
 	spi_message_init(&message);
@@ -48,7 +49,7 @@ static int ad714x_spi_read(struct ad714x_chip *chip,
 	spi_message_add_tail(&xfer[0], &message);
 
 	xfer[1].rx_buf = &chip->xfer_buf[1];
-	xfer[1].len = sizeof(chip->xfer_buf[1]);
+	xfer[1].len = sizeof(chip->xfer_buf[1]) * len;
 	spi_message_add_tail(&xfer[1], &message);
 
 	error = spi_sync(spi, &message);
@@ -57,7 +58,9 @@ static int ad714x_spi_read(struct ad714x_chip *chip,
 		return error;
 	}
 
-	*data = be16_to_cpu(chip->xfer_buf[1]);
+	for (i = 0; i < len; i++)
+		data[i] = be16_to_cpu(chip->xfer_buf[i + 1]);
+
 	return 0;
 }
 
diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 2be0366..ca42c7d 100644
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
@@ -123,6 +123,7 @@ struct ad714x_driver_data {
  * information to integrate all things which will be private data
  * of spi/i2c device
  */
+
 static void ad714x_use_com_int(struct ad714x_chip *ad714x,
 				int start_stage, int end_stage)
 {
@@ -131,11 +132,11 @@ static void ad714x_use_com_int(struct ad714x_chip *ad714x,
 
 	mask = ((1 << (end_stage + 1)) - 1) - ((1 << start_stage) - 1);
 
-	ad714x->read(ad714x, STG_COM_INT_EN_REG, &data);
+	ad714x->read(ad714x, STG_COM_INT_EN_REG, &data, 1);
 	data |= 1 << end_stage;
 	ad714x->write(ad714x, STG_COM_INT_EN_REG, data);
 
-	ad714x->read(ad714x, STG_HIGH_INT_EN_REG, &data);
+	ad714x->read(ad714x, STG_HIGH_INT_EN_REG, &data, 1);
 	data &= ~mask;
 	ad714x->write(ad714x, STG_HIGH_INT_EN_REG, data);
 }
@@ -148,11 +149,11 @@ static void ad714x_use_thr_int(struct ad714x_chip *ad714x,
 
 	mask = ((1 << (end_stage + 1)) - 1) - ((1 << start_stage) - 1);
 
-	ad714x->read(ad714x, STG_COM_INT_EN_REG, &data);
+	ad714x->read(ad714x, STG_COM_INT_EN_REG, &data, 1);
 	data &= ~(1 << end_stage);
 	ad714x->write(ad714x, STG_COM_INT_EN_REG, data);
 
-	ad714x->read(ad714x, STG_HIGH_INT_EN_REG, &data);
+	ad714x->read(ad714x, STG_HIGH_INT_EN_REG, &data, 1);
 	data |= mask;
 	ad714x->write(ad714x, STG_HIGH_INT_EN_REG, data);
 }
@@ -250,13 +251,16 @@ static void ad714x_slider_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
 	struct ad714x_slider_plat *hw = &ad714x->hw->slider[idx];
 	int i;
 
+	ad714x->read(ad714x, CDC_RESULT_S0 + hw->start_stage,
+			&ad714x->adc_reg[hw->start_stage],
+			hw->end_stage - hw->start_stage + 1);
+
 	for (i = hw->start_stage; i <= hw->end_stage; i++) {
-		ad714x->read(ad714x, CDC_RESULT_S0 + i, &ad714x->adc_reg[i]);
 		ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
-				&ad714x->amb_reg[i]);
+				&ad714x->amb_reg[i], 1);
 
-		ad714x->sensor_val[i] = abs(ad714x->adc_reg[i] -
-				ad714x->amb_reg[i]);
+		ad714x->sensor_val[i] =
+			abs(ad714x->adc_reg[i] - ad714x->amb_reg[i]);
 	}
 }
 
@@ -419,13 +423,16 @@ static void ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
 	struct ad714x_wheel_plat *hw = &ad714x->hw->wheel[idx];
 	int i;
 
+	ad714x->read(ad714x, CDC_RESULT_S0 + hw->start_stage,
+			&ad714x->adc_reg[hw->start_stage],
+			hw->end_stage - hw->start_stage + 1);
+
 	for (i = hw->start_stage; i <= hw->end_stage; i++) {
-		ad714x->read(ad714x, CDC_RESULT_S0 + i, &ad714x->adc_reg[i]);
 		ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
-				&ad714x->amb_reg[i]);
+				&ad714x->amb_reg[i], 1);
 		if (ad714x->adc_reg[i] > ad714x->amb_reg[i])
-			ad714x->sensor_val[i] = ad714x->adc_reg[i] -
-				ad714x->amb_reg[i];
+			ad714x->sensor_val[i] =
+				ad714x->adc_reg[i] - ad714x->amb_reg[i];
 		else
 			ad714x->sensor_val[i] = 0;
 	}
@@ -570,13 +577,16 @@ static void touchpad_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
 	struct ad714x_touchpad_plat *hw = &ad714x->hw->touchpad[idx];
 	int i;
 
+	ad714x->read(ad714x, CDC_RESULT_S0 + hw->x_start_stage,
+			&ad714x->adc_reg[hw->x_start_stage],
+			hw->x_end_stage - hw->x_start_stage + 1);
+
 	for (i = hw->x_start_stage; i <= hw->x_end_stage; i++) {
-		ad714x->read(ad714x, CDC_RESULT_S0 + i, &ad714x->adc_reg[i]);
 		ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
-				&ad714x->amb_reg[i]);
+				&ad714x->amb_reg[i], 1);
 		if (ad714x->adc_reg[i] > ad714x->amb_reg[i])
-			ad714x->sensor_val[i] = ad714x->adc_reg[i] -
-				ad714x->amb_reg[i];
+			ad714x->sensor_val[i] =
+				ad714x->adc_reg[i] - ad714x->amb_reg[i];
 		else
 			ad714x->sensor_val[i] = 0;
 	}
@@ -862,7 +872,7 @@ static int ad714x_hw_detect(struct ad714x_chip *ad714x)
 {
 	unsigned short data;
 
-	ad714x->read(ad714x, AD714X_PARTID_REG, &data);
+	ad714x->read(ad714x, AD714X_PARTID_REG, &data, 1);
 	switch (data & 0xFFF0) {
 	case AD7142_PARTID:
 		ad714x->product = 0x7142;
@@ -919,14 +929,12 @@ static void ad714x_hw_init(struct ad714x_chip *ad714x)
 		ad714x->write(ad714x, AD714X_SYSCFG_REG + i,
 			ad714x->hw->sys_cfg_reg[i]);
 	for (i = 0; i < SYS_CFGREG_NUM; i++)
-		ad714x->read(ad714x, AD714X_SYSCFG_REG + i, &data);
+		ad714x->read(ad714x, AD714X_SYSCFG_REG + i, &data, 1);
 
 	ad714x->write(ad714x, AD714X_STG_CAL_EN_REG, 0xFFF);
 
 	/* clear all interrupts */
-	ad714x->read(ad714x, STG_LOW_INT_STA_REG, &data);
-	ad714x->read(ad714x, STG_HIGH_INT_STA_REG, &data);
-	ad714x->read(ad714x, STG_COM_INT_STA_REG, &data);
+	ad714x->read(ad714x, STG_LOW_INT_STA_REG, &ad714x->l_state, 3);
 }
 
 static irqreturn_t ad714x_interrupt_thread(int irq, void *data)
@@ -936,9 +944,7 @@ static irqreturn_t ad714x_interrupt_thread(int irq, void *data)
 
 	mutex_lock(&ad714x->mutex);
 
-	ad714x->read(ad714x, STG_LOW_INT_STA_REG, &ad714x->l_state);
-	ad714x->read(ad714x, STG_HIGH_INT_STA_REG, &ad714x->h_state);
-	ad714x->read(ad714x, STG_COM_INT_STA_REG, &ad714x->c_state);
+	ad714x->read(ad714x, STG_LOW_INT_STA_REG, &ad714x->l_state, 3);
 
 	for (i = 0; i < ad714x->hw->button_num; i++)
 		ad714x_button_state_machine(ad714x, i);
@@ -1225,8 +1231,6 @@ EXPORT_SYMBOL(ad714x_disable);
 
 int ad714x_enable(struct ad714x_chip *ad714x)
 {
-	unsigned short data;
-
 	dev_dbg(ad714x->dev, "%s enter\n", __func__);
 
 	mutex_lock(&ad714x->mutex);
@@ -1240,9 +1244,7 @@ int ad714x_enable(struct ad714x_chip *ad714x)
 	 * otherwise we will get no chance to enter falling-edge irq again
 	 */
 
-	ad714x->read(ad714x, STG_LOW_INT_STA_REG, &data);
-	ad714x->read(ad714x, STG_HIGH_INT_STA_REG, &data);
-	ad714x->read(ad714x, STG_COM_INT_STA_REG, &data);
+	ad714x->read(ad714x, STG_LOW_INT_STA_REG, &ad714x->l_state, 3);
 
 	mutex_unlock(&ad714x->mutex);
 
diff --git a/drivers/input/misc/ad714x.h b/drivers/input/misc/ad714x.h
index d12d149..6edc080 100644
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
@@ -18,7 +18,7 @@ struct ad714x_platform_data;
 struct ad714x_driver_data;
 struct ad714x_chip;
 
-typedef int (*ad714x_read_t)(struct ad714x_chip *, unsigned short, unsigned short *);
+typedef int (*ad714x_read_t)(struct ad714x_chip *, unsigned short, unsigned short *, size_t);
 typedef int (*ad714x_write_t)(struct ad714x_chip *, unsigned short, unsigned short);
 
 struct ad714x_chip {
-- 
1.7.6

