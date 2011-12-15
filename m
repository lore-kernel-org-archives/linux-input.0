From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] input: mpu3050: Configure the sampling method
Date: Thu, 15 Dec 2011 22:18:47 +0000
Message-ID: <20111215221845.8657.17958.stgit@bob.linux.org.uk>
References: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58665 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606Ab1LOWWt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 17:22:49 -0500
In-Reply-To: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This will improve the output of the sensor.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/misc/mpu3050.c |  101 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 96 insertions(+), 5 deletions(-)


diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index da47b10..89c7160 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -42,12 +42,7 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 
-#define MPU3050_CHIP_ID_REG	0x00
 #define MPU3050_CHIP_ID		0x69
-#define MPU3050_XOUT_H		0x1D
-#define MPU3050_PWR_MGM		0x3E
-#define MPU3050_PWR_MGM_POS	6
-#define MPU3050_PWR_MGM_MASK	0x40
 
 #define MPU3050_AUTO_DELAY	1000
 
@@ -55,6 +50,58 @@
 #define MPU3050_MAX_VALUE	32767
 
 #define MPU3050_DEFAULT_POLL_INTERVAL	200
+#define MPU3050_DEFAULT_FS_RANGE	3
+
+/* Register map */
+#define MPU3050_CHIP_ID_REG	0x00
+#define MPU3050_SMPLRT_DIV	0x15
+#define MPU3050_DLPF_FS_SYNC	0x16
+#define MPU3050_INT_CFG		0x17
+#define MPU3050_XOUT_H		0x1D
+#define MPU3050_PWR_MGM		0x3E
+#define MPU3050_PWR_MGM_POS	6
+
+/* Register bits */
+
+/* DLPF_FS_SYNC */
+#define MPU3050_EXT_SYNC_NONE		0x00
+#define MPU3050_EXT_SYNC_TEMP		0x20
+#define MPU3050_EXT_SYNC_GYROX		0x40
+#define MPU3050_EXT_SYNC_GYROY		0x60
+#define MPU3050_EXT_SYNC_GYROZ		0x80
+#define MPU3050_EXT_SYNC_ACCELX		0xA0
+#define MPU3050_EXT_SYNC_ACCELY		0xC0
+#define MPU3050_EXT_SYNC_ACCELZ		0xE0
+#define MPU3050_EXT_SYNC_MASK		0xE0
+#define MPU3050_FS_250DPS		0x00
+#define MPU3050_FS_500DPS		0x08
+#define MPU3050_FS_1000DPS		0x10
+#define MPU3050_FS_2000DPS		0x18
+#define MPU3050_FS_MASK			0x18
+#define MPU3050_DLPF_CFG_256HZ_NOLPF2	0x00
+#define MPU3050_DLPF_CFG_188HZ		0x01
+#define MPU3050_DLPF_CFG_98HZ		0x02
+#define MPU3050_DLPF_CFG_42HZ		0x03
+#define MPU3050_DLPF_CFG_20HZ		0x04
+#define MPU3050_DLPF_CFG_10HZ		0x05
+#define MPU3050_DLPF_CFG_5HZ		0x06
+#define MPU3050_DLPF_CFG_2100HZ_NOLPF	0x07
+#define MPU3050_DLPF_CFG_MASK		0x07
+/* INT_CFG */
+#define MPU3050_RAW_RDY_EN		0x01
+#define MPU3050_MPU_RDY_EN		0x02
+#define MPU3050_LATCH_INT_EN		0x04
+/* PWR_MGM */
+#define MPU3050_PWR_MGM_PLL_X		0x01
+#define MPU3050_PWR_MGM_PLL_Y		0x02
+#define MPU3050_PWR_MGM_PLL_Z		0x03
+#define MPU3050_PWR_MGM_CLKSEL		0x07
+#define MPU3050_PWR_MGM_STBY_ZG		0x08
+#define MPU3050_PWR_MGM_STBY_YG		0x10
+#define MPU3050_PWR_MGM_STBY_XG		0x20
+#define MPU3050_PWR_MGM_SLEEP		0x40
+#define MPU3050_PWR_MGM_RESET		0x80
+#define MPU3050_PWR_MGM_MASK		0x40
 
 struct axis_data {
 	s16 x;
@@ -219,6 +266,46 @@ static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Configures the sampling method */
+static int mpu3050_hw_init(struct mpu3050_sensor *sensor)
+{
+	struct i2c_client *client = sensor->client;
+	int ret;
+	u8 reg;
+
+	/* Reset */
+	ret = i2c_smbus_write_byte_data(client, MPU3050_PWR_MGM,
+					MPU3050_PWR_MGM_RESET);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, MPU3050_PWR_MGM);
+	if (ret < 0)
+		return ret;
+
+	ret &= ~MPU3050_PWR_MGM_CLKSEL;
+	ret |= MPU3050_PWR_MGM_PLL_Z;
+	ret = i2c_smbus_write_byte_data(client, MPU3050_PWR_MGM, ret);
+	if (ret < 0)
+		return ret;
+
+	/* Output frequency divider. The poll interval */
+	ret = i2c_smbus_write_byte_data(client, MPU3050_SMPLRT_DIV,
+					MPU3050_DEFAULT_POLL_INTERVAL - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set low pass filter and full scale */
+	reg = MPU3050_DEFAULT_FS_RANGE;
+	reg |= MPU3050_DLPF_CFG_42HZ << 3;
+	reg |= MPU3050_EXT_SYNC_NONE << 5;
+	ret = i2c_smbus_write_byte_data(client, MPU3050_DLPF_FS_SYNC, reg);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static void __devinit mpu3050_init_idev(struct mpu3050_sensor *sensor,
 						struct input_dev *idev)
 {
@@ -336,6 +423,10 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 
 	pm_runtime_set_active(&client->dev);
 
+	error = mpu3050_hw_init(sensor);
+	if (error)
+		goto err_free_mem;
+
 	if (client->irq > 0) {
 		error = mpu3050_create_idev(sensor);
 		if (error) {

