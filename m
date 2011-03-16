From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 15/17] Input: tsc2005 - handle read errors from SPI layer
Date: Wed, 16 Mar 2011 00:19:18 -0700
Message-ID: <20110316071918.25664.70392.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36065 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHTX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:19:23 -0400
Received: by mail-yw0-f46.google.com with SMTP id 3so546490ywj.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:19:23 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |  100 ++++++++++++++++++++++++++++-------
 1 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 16c9f57..f72df969 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -146,7 +146,7 @@ struct tsc2005 {
 	void			(*set_reset)(bool enable);
 };
 
-static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
+static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 {
 	u8 tx = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
 	struct spi_transfer xfer = {
@@ -155,13 +155,22 @@ static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 		.bits_per_word	= 8,
 	};
 	struct spi_message msg;
+	int error;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
-	spi_sync(ts->spi, &msg);
+
+	error = spi_sync(ts->spi, &msg);
+	if (error) {
+		dev_err(&ts->spi->dev, "%s: failed, command: %x, error: %d\n",
+			__func__, cmd, error);
+		return error;
+	}
+
+	return 0;
 }
 
-static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
+static int tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
 {
 	u32 tx = ((reg | TSC2005_REG_PND0) << 16) | value;
 	struct spi_transfer xfer = {
@@ -170,10 +179,20 @@ static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
 		.bits_per_word	= 24,
 	};
 	struct spi_message msg;
+	int error;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
-	spi_sync(ts->spi, &msg);
+
+	error = spi_sync(ts->spi, &msg);
+	if (error) {
+		dev_err(&ts->spi->dev,
+			"%s: failed, register: %x, value: %x, error: %d\n",
+			__func__, reg, value, error);
+		return error;
+	}
+
+	return 0;
 }
 
 static void tsc2005_setup_read(struct tsc2005_spi_rd *rd, u8 reg, bool last)
@@ -188,18 +207,23 @@ static void tsc2005_setup_read(struct tsc2005_spi_rd *rd, u8 reg, bool last)
 	rd->spi_xfer.cs_change	   = !last;
 }
 
-static void tsc2005_read(struct tsc2005 *ts, u8 reg, u16 *value)
+static int tsc2005_read(struct tsc2005 *ts, u8 reg, u16 *value)
 {
 	struct tsc2005_spi_rd spi_rd;
 	struct spi_message msg;
+	int error;
 
 	tsc2005_setup_read(&spi_rd, reg, true);
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&spi_rd.spi_xfer, &msg);
-	spi_sync(ts->spi, &msg);
+
+	error = spi_sync(ts->spi, &msg);
+	if (error)
+		return error;
 
 	*value = spi_rd.spi_rx;
+	return 0;
 }
 
 static void tsc2005_update_pen_state(struct tsc2005 *ts,
@@ -232,6 +256,7 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 	unsigned int pressure;
 	u32 x, y;
 	u32 z1, z2;
+	int error;
 
 	mutex_lock(&ts->mutex);
 
@@ -239,7 +264,10 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 		goto out;
 
 	/* read the coordinates */
-	spi_sync(ts->spi, &ts->spi_read_msg);
+	error = spi_sync(ts->spi, &ts->spi_read_msg);
+	if (unlikely(error))
+		goto out;
+
 	x = ts->spi_x.spi_rx;
 	y = ts->spi_y.spi_rx;
 	z1 = ts->spi_z1.spi_rx;
@@ -392,7 +420,8 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	u16 temp_high;
 	u16 temp_high_orig;
 	u16 temp_high_test;
-	unsigned int result;
+	bool success = true;
+	int error;
 
 	mutex_lock(&ts->mutex);
 
@@ -400,34 +429,65 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	 * Test TSC2005 communications via temp high register.
 	 */
 	tsc2005_disable(ts);
-	result = 1;
-	tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
+
+	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
+	if (error) {
+		dev_warn(dev, "selftest failed: read error %d\n", error);
+		success = false;
+		goto out;
+	}
+
 	temp_high_test = (temp_high_orig - 1) & MAX_12BIT;
-	tsc2005_write(ts, TSC2005_REG_TEMP_HIGH, temp_high_test);
-	tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
+
+	error = tsc2005_write(ts, TSC2005_REG_TEMP_HIGH, temp_high_test);
+	if (error) {
+		dev_warn(dev, "selftest failed: write error %d\n", error);
+		success = false;
+		goto out;
+	}
+
+	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
+	if (error) {
+		dev_warn(dev, "selftest failed: read error %d after write\n",
+			 error);
+		success = false;
+		goto out;
+	}
+
 	if (temp_high != temp_high_test) {
 		dev_warn(dev, "selftest failed: %d != %d\n",
 			 temp_high, temp_high_test);
-		result = 0;
+		success = false;
 	}
 
 	/* hardware reset */
 	ts->set_reset(false);
 	usleep_range(100, 500); /* only 10us required */
 	ts->set_reset(true);
-	tsc2005_enable(ts);
+
+	if (!success)
+		goto out;
 
 	/* test that the reset really happened */
-	tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
+	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
+	if (error) {
+		dev_warn(dev, "selftest failed: read error %d after reset\n",
+			 error);
+		success = false;
+		goto out;
+	}
+
 	if (temp_high != temp_high_orig) {
 		dev_warn(dev, "selftest failed after reset: %d != %d\n",
 			 temp_high, temp_high_orig);
-		result = 0;
+		success = false;
 	}
 
+out:
+	tsc2005_enable(ts);
 	mutex_unlock(&ts->mutex);
 
-	return sprintf(buf, "%u\n", result);
+	return sprintf(buf, "%d\n", success);
 }
 
 static DEVICE_ATTR(selftest, S_IRUGO, tsc2005_selftest_show, NULL);
@@ -469,6 +529,7 @@ static void tsc2005_esd_timer(unsigned long data)
 static void tsc2005_esd_work(struct work_struct *work)
 {
 	struct tsc2005 *ts = container_of(work, struct tsc2005, esd_work);
+	int error;
 	u16 r;
 
 	mutex_lock(&ts->mutex);
@@ -480,8 +541,9 @@ static void tsc2005_esd_work(struct work_struct *work)
 	 * If we cannot read our known value from configuration register 0 then
 	 * reset the controller as if from power-up and start scanning again.
 	 */
-	tsc2005_read(ts, TSC2005_REG_CFR0, &r);
-	if ((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK) {
+	error = tsc2005_read(ts, TSC2005_REG_CFR0, &r);
+	if (error ||
+	    ((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK)) {
 		dev_info(&ts->spi->dev, "TSC2005 not responding - resetting\n");
 		ts->set_reset(false);
 		tsc2005_update_pen_state(ts, 0, 0, 0);

