From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 2/4] Input: tsc200x-core - Rename functions and variables
Date: Fri, 30 Oct 2015 19:41:24 -0500
Message-ID: <1446252086-24334-3-git-send-email-mwelling@ieee.org>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-input@vger.kernel.org

The functions, variables, and defines of the new tsc200x-core.c are
renamed to tsc200x instead of tsc2005 avoid possible confusion.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/input/touchscreen/tsc2005.c      |   2 +-
 drivers/input/touchscreen/tsc200x-core.c | 200 +++++++++++++++----------------
 drivers/input/touchscreen/tsc200x-core.h | 102 ++++++++--------
 3 files changed, 152 insertions(+), 152 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index fc879cf..cbff18a 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -28,7 +28,7 @@
 
 static int tsc2005_cmd(struct device *dev, u8 cmd)
 {
-	u8 tx = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
+	u8 tx = TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
 	struct spi_transfer xfer = {
 		.tx_buf         = &tx,
 		.len            = 1,
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 528ad39..6dfcbea 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -37,28 +37,28 @@
  * The touchscreen interface operates as follows:
  *
  * 1) Pen is pressed against the touchscreen.
- * 2) TSC2005 performs AD conversion.
- * 3) After the conversion is done TSC2005 drives DAV line down.
- * 4) GPIO IRQ is received and tsc2005_irq_thread() is scheduled.
- * 5) tsc2005_irq_thread() queues up a transfer to fetch the x, y, z1, z2
+ * 2) TSC200X performs AD conversion.
+ * 3) After the conversion is done TSC200X drives DAV line down.
+ * 4) GPIO IRQ is received and tsc200x_irq_thread() is scheduled.
+ * 5) tsc200x_irq_thread() queues up a transfer to fetch the x, y, z1, z2
  *    values.
- * 6) tsc2005_irq_thread() reports coordinates to input layer and sets up
- *    tsc2005_penup_timer() to be called after TSC2005_PENUP_TIME_MS (40ms).
+ * 6) tsc200x_irq_thread() reports coordinates to input layer and sets up
+ *    tsc200x_penup_timer() to be called after TSC200X_PENUP_TIME_MS (40ms).
  * 7) When the penup timer expires, there have not been touch or DAV interrupts
  *    during the last 40ms which means the pen has been lifted.
  *
- * ESD recovery via a hardware reset is done if the TSC2005 doesn't respond
+ * ESD recovery via a hardware reset is done if the TSC200X doesn't respond
  * after a configurable period (in ms) of activity. If esd_timeout is 0, the
  * watchdog is disabled.
  */
 
-static const struct regmap_range tsc2005_writable_ranges[] = {
-	regmap_reg_range(TSC2005_REG_AUX_HIGH, TSC2005_REG_CFR2),
+static const struct regmap_range tsc200x_writable_ranges[] = {
+	regmap_reg_range(TSC200X_REG_AUX_HIGH, TSC200X_REG_CFR2),
 };
 
-static const struct regmap_access_table tsc2005_writable_table = {
-	.yes_ranges = tsc2005_writable_ranges,
-	.n_yes_ranges = ARRAY_SIZE(tsc2005_writable_ranges),
+static const struct regmap_access_table tsc200x_writable_table = {
+	.yes_ranges = tsc200x_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tsc200x_writable_ranges),
 };
 
 const struct regmap_config tsc200x_regmap_config = {
@@ -66,21 +66,21 @@ const struct regmap_config tsc200x_regmap_config = {
 	.val_bits = 16,
 	.reg_stride = 0x08,
 	.max_register = 0x78,
-	.read_flag_mask = TSC2005_REG_READ,
-	.write_flag_mask = TSC2005_REG_PND0,
-	.wr_table = &tsc2005_writable_table,
+	.read_flag_mask = TSC200X_REG_READ,
+	.write_flag_mask = TSC200X_REG_PND0,
+	.wr_table = &tsc200x_writable_table,
 	.use_single_rw = true,
 };
 
-struct tsc2005_data {
+struct tsc200x_data {
 	u16 x;
 	u16 y;
 	u16 z1;
 	u16 z2;
 } __packed;
-#define TSC2005_DATA_REGS 4
+#define TSC200X_DATA_REGS 4
 
-struct tsc2005 {
+struct tsc200x {
 	struct device           *dev;
 	struct regmap		*regmap;
 	__u16                   bustype;
@@ -118,7 +118,7 @@ struct tsc2005 {
 	int			irq;
 };
 
-static void tsc2005_update_pen_state(struct tsc2005 *ts,
+static void tsc200x_update_pen_state(struct tsc200x *ts,
 				     int x, int y, int pressure)
 {
 	if (pressure) {
@@ -141,17 +141,17 @@ static void tsc2005_update_pen_state(struct tsc2005 *ts,
 		pressure);
 }
 
-static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
+static irqreturn_t tsc200x_irq_thread(int irq, void *_ts)
 {
-	struct tsc2005 *ts = _ts;
+	struct tsc200x *ts = _ts;
 	unsigned long flags;
 	unsigned int pressure;
-	struct tsc2005_data tsdata;
+	struct tsc200x_data tsdata;
 	int error;
 
 	/* read the coordinates */
-	error = regmap_bulk_read(ts->regmap, TSC2005_REG_X, &tsdata,
-				 TSC2005_DATA_REGS);
+	error = regmap_bulk_read(ts->regmap, TSC200X_REG_X, &tsdata,
+				 TSC200X_DATA_REGS);
 	if (unlikely(error))
 		goto out;
 
@@ -192,9 +192,9 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 
 	spin_lock_irqsave(&ts->lock, flags);
 
-	tsc2005_update_pen_state(ts, tsdata.x, tsdata.y, pressure);
+	tsc200x_update_pen_state(ts, tsdata.x, tsdata.y, pressure);
 	mod_timer(&ts->penup_timer,
-		  jiffies + msecs_to_jiffies(TSC2005_PENUP_TIME_MS));
+		  jiffies + msecs_to_jiffies(TSC200X_PENUP_TIME_MS));
 
 	spin_unlock_irqrestore(&ts->lock, flags);
 
@@ -203,30 +203,30 @@ out:
 	return IRQ_HANDLED;
 }
 
-static void tsc2005_penup_timer(unsigned long data)
+static void tsc200x_penup_timer(unsigned long data)
 {
-	struct tsc2005 *ts = (struct tsc2005 *)data;
+	struct tsc200x *ts = (struct tsc200x *)data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ts->lock, flags);
-	tsc2005_update_pen_state(ts, 0, 0, 0);
+	tsc200x_update_pen_state(ts, 0, 0, 0);
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
-static void tsc2005_start_scan(struct tsc2005 *ts)
+static void tsc200x_start_scan(struct tsc200x *ts)
 {
-	regmap_write(ts->regmap, TSC2005_REG_CFR0, TSC2005_CFR0_INITVALUE);
-	regmap_write(ts->regmap, TSC2005_REG_CFR1, TSC2005_CFR1_INITVALUE);
-	regmap_write(ts->regmap, TSC2005_REG_CFR2, TSC2005_CFR2_INITVALUE);
-	ts->tsc200x_cmd(ts->dev, TSC2005_CMD_NORMAL);
+	regmap_write(ts->regmap, TSC200X_REG_CFR0, TSC200X_CFR0_INITVALUE);
+	regmap_write(ts->regmap, TSC200X_REG_CFR1, TSC200X_CFR1_INITVALUE);
+	regmap_write(ts->regmap, TSC200X_REG_CFR2, TSC200X_CFR2_INITVALUE);
+	ts->tsc200x_cmd(ts->dev, TSC200X_CMD_NORMAL);
 }
 
-static void tsc2005_stop_scan(struct tsc2005 *ts)
+static void tsc200x_stop_scan(struct tsc200x *ts)
 {
-	ts->tsc200x_cmd(ts->dev, TSC2005_CMD_STOP);
+	ts->tsc200x_cmd(ts->dev, TSC200X_CMD_STOP);
 }
 
-static void tsc2005_set_reset(struct tsc2005 *ts, bool enable)
+static void tsc200x_set_reset(struct tsc200x *ts, bool enable)
 {
 	if (ts->reset_gpio)
 		gpiod_set_value_cansleep(ts->reset_gpio, enable);
@@ -235,9 +235,9 @@ static void tsc2005_set_reset(struct tsc2005 *ts, bool enable)
 }
 
 /* must be called with ts->mutex held */
-static void __tsc2005_disable(struct tsc2005 *ts)
+static void __tsc200x_disable(struct tsc200x *ts)
 {
-	tsc2005_stop_scan(ts);
+	tsc200x_stop_scan(ts);
 
 	disable_irq(ts->irq);
 	del_timer_sync(&ts->penup_timer);
@@ -248,9 +248,9 @@ static void __tsc2005_disable(struct tsc2005 *ts)
 }
 
 /* must be called with ts->mutex held */
-static void __tsc2005_enable(struct tsc2005 *ts)
+static void __tsc200x_enable(struct tsc200x *ts)
 {
-	tsc2005_start_scan(ts);
+	tsc200x_start_scan(ts);
 
 	if (ts->esd_timeout && (ts->set_reset || ts->reset_gpio)) {
 		ts->last_valid_interrupt = jiffies;
@@ -261,11 +261,11 @@ static void __tsc2005_enable(struct tsc2005 *ts)
 
 }
 
-static ssize_t tsc2005_selftest_show(struct device *dev,
+static ssize_t tsc200x_selftest_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct tsc200x *ts = dev_get_drvdata(dev);
 	unsigned int temp_high;
 	unsigned int temp_high_orig;
 	unsigned int temp_high_test;
@@ -275,11 +275,11 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	mutex_lock(&ts->mutex);
 
 	/*
-	 * Test TSC2005 communications via temp high register.
+	 * Test TSC200X communications via temp high register.
 	 */
-	__tsc2005_disable(ts);
+	__tsc200x_disable(ts);
 
-	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
+	error = regmap_read(ts->regmap, TSC200X_REG_TEMP_HIGH, &temp_high_orig);
 	if (error) {
 		dev_warn(dev, "selftest failed: read error %d\n", error);
 		success = false;
@@ -288,14 +288,14 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 
 	temp_high_test = (temp_high_orig - 1) & MAX_12BIT;
 
-	error = regmap_write(ts->regmap, TSC2005_REG_TEMP_HIGH, temp_high_test);
+	error = regmap_write(ts->regmap, TSC200X_REG_TEMP_HIGH, temp_high_test);
 	if (error) {
 		dev_warn(dev, "selftest failed: write error %d\n", error);
 		success = false;
 		goto out;
 	}
 
-	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high);
+	error = regmap_read(ts->regmap, TSC200X_REG_TEMP_HIGH, &temp_high);
 	if (error) {
 		dev_warn(dev, "selftest failed: read error %d after write\n",
 			 error);
@@ -310,15 +310,15 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	}
 
 	/* hardware reset */
-	tsc2005_set_reset(ts, false);
+	tsc200x_set_reset(ts, false);
 	usleep_range(100, 500); /* only 10us required */
-	tsc2005_set_reset(ts, true);
+	tsc200x_set_reset(ts, true);
 
 	if (!success)
 		goto out;
 
 	/* test that the reset really happened */
-	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high);
+	error = regmap_read(ts->regmap, TSC200X_REG_TEMP_HIGH, &temp_high);
 	if (error) {
 		dev_warn(dev, "selftest failed: read error %d after reset\n",
 			 error);
@@ -333,24 +333,24 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	}
 
 out:
-	__tsc2005_enable(ts);
+	__tsc200x_enable(ts);
 	mutex_unlock(&ts->mutex);
 
 	return sprintf(buf, "%d\n", success);
 }
 
-static DEVICE_ATTR(selftest, S_IRUGO, tsc2005_selftest_show, NULL);
+static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);
 
-static struct attribute *tsc2005_attrs[] = {
+static struct attribute *tsc200x_attrs[] = {
 	&dev_attr_selftest.attr,
 	NULL
 };
 
-static umode_t tsc2005_attr_is_visible(struct kobject *kobj,
+static umode_t tsc200x_attr_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct tsc200x *ts = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
 	if (attr == &dev_attr_selftest.attr) {
@@ -361,14 +361,14 @@ static umode_t tsc2005_attr_is_visible(struct kobject *kobj,
 	return mode;
 }
 
-static const struct attribute_group tsc2005_attr_group = {
-	.is_visible	= tsc2005_attr_is_visible,
-	.attrs		= tsc2005_attrs,
+static const struct attribute_group tsc200x_attr_group = {
+	.is_visible	= tsc200x_attr_is_visible,
+	.attrs		= tsc200x_attrs,
 };
 
-static void tsc2005_esd_work(struct work_struct *work)
+static void tsc200x_esd_work(struct work_struct *work)
 {
-	struct tsc2005 *ts = container_of(work, struct tsc2005, esd_work.work);
+	struct tsc200x *ts = container_of(work, struct tsc200x, esd_work.work);
 	int error;
 	unsigned int r;
 
@@ -386,9 +386,9 @@ static void tsc2005_esd_work(struct work_struct *work)
 		goto out;
 
 	/* We should be able to read register without disabling interrupts. */
-	error = regmap_read(ts->regmap, TSC2005_REG_CFR0, &r);
+	error = regmap_read(ts->regmap, TSC200X_REG_CFR0, &r);
 	if (!error &&
-	    !((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK)) {
+	    !((r ^ TSC200X_CFR0_INITVALUE) & TSC200X_CFR0_RW_MASK)) {
 		goto out;
 	}
 
@@ -397,19 +397,19 @@ static void tsc2005_esd_work(struct work_struct *work)
 	 * then we should reset the controller as if from power-up and start
 	 * scanning again.
 	 */
-	dev_info(ts->dev, "TSC2005 not responding - resetting\n");
+	dev_info(ts->dev, "TSC200X not responding - resetting\n");
 
 	disable_irq(ts->irq);
 	del_timer_sync(&ts->penup_timer);
 
-	tsc2005_update_pen_state(ts, 0, 0, 0);
+	tsc200x_update_pen_state(ts, 0, 0, 0);
 
-	tsc2005_set_reset(ts, false);
+	tsc200x_set_reset(ts, false);
 	usleep_range(100, 500); /* only 10us required */
-	tsc2005_set_reset(ts, true);
+	tsc200x_set_reset(ts, true);
 
 	enable_irq(ts->irq);
-	tsc2005_start_scan(ts);
+	tsc200x_start_scan(ts);
 
 out:
 	mutex_unlock(&ts->mutex);
@@ -420,14 +420,14 @@ reschedule:
 					msecs_to_jiffies(ts->esd_timeout)));
 }
 
-static int tsc2005_open(struct input_dev *input)
+static int tsc200x_open(struct input_dev *input)
 {
-	struct tsc2005 *ts = input_get_drvdata(input);
+	struct tsc200x *ts = input_get_drvdata(input);
 
 	mutex_lock(&ts->mutex);
 
 	if (!ts->suspended)
-		__tsc2005_enable(ts);
+		__tsc200x_enable(ts);
 
 	ts->opened = true;
 
@@ -436,14 +436,14 @@ static int tsc2005_open(struct input_dev *input)
 	return 0;
 }
 
-static void tsc2005_close(struct input_dev *input)
+static void tsc200x_close(struct input_dev *input)
 {
-	struct tsc2005 *ts = input_get_drvdata(input);
+	struct tsc200x *ts = input_get_drvdata(input);
 
 	mutex_lock(&ts->mutex);
 
 	if (!ts->suspended)
-		__tsc2005_disable(ts);
+		__tsc200x_disable(ts);
 
 	ts->opened = false;
 
@@ -457,15 +457,15 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	const struct tsc2005_platform_data *pdata = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 
-	struct tsc2005 *ts;
+	struct tsc200x *ts;
 	struct input_dev *input_dev;
 	unsigned int max_x = MAX_12BIT;
 	unsigned int max_y = MAX_12BIT;
 	unsigned int max_p = MAX_12BIT;
-	unsigned int fudge_x = TSC2005_DEF_X_FUZZ;
-	unsigned int fudge_y = TSC2005_DEF_Y_FUZZ;
-	unsigned int fudge_p = TSC2005_DEF_P_FUZZ;
-	unsigned int x_plate_ohm = TSC2005_DEF_RESISTOR;
+	unsigned int fudge_x = TSC200X_DEF_X_FUZZ;
+	unsigned int fudge_y = TSC200X_DEF_Y_FUZZ;
+	unsigned int fudge_p = TSC200X_DEF_P_FUZZ;
+	unsigned int x_plate_ohm = TSC200X_DEF_RESISTOR;
 	unsigned int esd_timeout;
 	int error;
 
@@ -497,7 +497,7 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 		x_plate_ohm = pdata->ts_x_plate_ohm;
 		esd_timeout = pdata->esd_timeout_ms;
 	} else {
-		x_plate_ohm = TSC2005_DEF_RESISTOR;
+		x_plate_ohm = TSC200X_DEF_RESISTOR;
 		of_property_read_u32(np, "ti,x-plate-ohms", &x_plate_ohm);
 		esd_timeout = 0;
 		of_property_read_u32(np, "ti,esd-recovery-timeout-ms",
@@ -540,14 +540,14 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	mutex_init(&ts->mutex);
 
 	spin_lock_init(&ts->lock);
-	setup_timer(&ts->penup_timer, tsc2005_penup_timer, (unsigned long)ts);
+	setup_timer(&ts->penup_timer, tsc200x_penup_timer, (unsigned long)ts);
 
-	INIT_DELAYED_WORK(&ts->esd_work, tsc2005_esd_work);
+	INIT_DELAYED_WORK(&ts->esd_work, tsc200x_esd_work);
 
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input-ts", dev_name(dev));
 
-	input_dev->name = "TSC2005 touchscreen";
+	input_dev->name = "TSC200X touchscreen";
 	input_dev->phys = ts->phys;
 	input_dev->id.bustype = bustype;
 	input_dev->dev.parent = dev;
@@ -561,18 +561,18 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	if (np)
 		touchscreen_parse_properties(input_dev, false);
 
-	input_dev->open = tsc2005_open;
-	input_dev->close = tsc2005_close;
+	input_dev->open = tsc200x_open;
+	input_dev->close = tsc200x_close;
 
 	input_set_drvdata(input_dev, ts);
 
 	/* Ensure the touchscreen is off */
-	tsc2005_stop_scan(ts);
+	tsc200x_stop_scan(ts);
 
 	error = devm_request_threaded_irq(dev, irq, NULL,
-					  tsc2005_irq_thread,
+					  tsc200x_irq_thread,
 					  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					  "tsc2005", ts);
+					  "tsc200x", ts);
 	if (error) {
 		dev_err(dev, "Failed to request irq, err: %d\n", error);
 		return error;
@@ -586,7 +586,7 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	}
 
 	dev_set_drvdata(dev, ts);
-	error = sysfs_create_group(&dev->kobj, &tsc2005_attr_group);
+	error = sysfs_create_group(&dev->kobj, &tsc200x_attr_group);
 	if (error) {
 		dev_err(dev,
 			"Failed to create sysfs attributes, err: %d\n", error);
@@ -604,7 +604,7 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	return 0;
 
 err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &tsc2005_attr_group);
+	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 disable_regulator:
 	if (ts->vio)
 		regulator_disable(ts->vio);
@@ -614,9 +614,9 @@ EXPORT_SYMBOL_GPL(tsc200x_probe);
 
 int tsc200x_remove(struct device *dev)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct tsc200x *ts = dev_get_drvdata(dev);
 
-	sysfs_remove_group(&dev->kobj, &tsc2005_attr_group);
+	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 
 	if (ts->vio)
 		regulator_disable(ts->vio);
@@ -625,14 +625,14 @@ int tsc200x_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tsc200x_remove);
 
-static int __maybe_unused tsc2005_suspend(struct device *dev)
+static int __maybe_unused tsc200x_suspend(struct device *dev)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct tsc200x *ts = dev_get_drvdata(dev);
 
 	mutex_lock(&ts->mutex);
 
 	if (!ts->suspended && ts->opened)
-		__tsc2005_disable(ts);
+		__tsc200x_disable(ts);
 
 	ts->suspended = true;
 
@@ -641,14 +641,14 @@ static int __maybe_unused tsc2005_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tsc2005_resume(struct device *dev)
+static int __maybe_unused tsc200x_resume(struct device *dev)
 {
-	struct tsc2005 *ts = dev_get_drvdata(dev);
+	struct tsc200x *ts = dev_get_drvdata(dev);
 
 	mutex_lock(&ts->mutex);
 
 	if (ts->suspended && ts->opened)
-		__tsc2005_enable(ts);
+		__tsc200x_enable(ts);
 
 	ts->suspended = false;
 
@@ -657,9 +657,9 @@ static int __maybe_unused tsc2005_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(tsc200x_pm_ops, tsc2005_suspend, tsc2005_resume);
+SIMPLE_DEV_PM_OPS(tsc200x_pm_ops, tsc200x_suspend, tsc200x_resume);
 EXPORT_SYMBOL_GPL(tsc200x_pm_ops);
 
 MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
-MODULE_DESCRIPTION("TSC2005 Touchscreen Driver");
+MODULE_DESCRIPTION("TSC200x Touchscreen Driver Core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/tsc200x-core.h b/drivers/input/touchscreen/tsc200x-core.h
index 3169078..7a482d1 100644
--- a/drivers/input/touchscreen/tsc200x-core.h
+++ b/drivers/input/touchscreen/tsc200x-core.h
@@ -2,70 +2,70 @@
 #define _TSC200X_CORE_H
 
 /* control byte 1 */
-#define TSC2005_CMD			0x80
-#define TSC2005_CMD_NORMAL		0x00
-#define TSC2005_CMD_STOP		0x01
-#define TSC2005_CMD_12BIT		0x04
+#define TSC200X_CMD			0x80
+#define TSC200X_CMD_NORMAL		0x00
+#define TSC200X_CMD_STOP		0x01
+#define TSC200X_CMD_12BIT		0x04
 
 /* control byte 0 */
-#define TSC2005_REG_READ		0x01 /* R/W access */
-#define TSC2005_REG_PND0		0x02 /* Power Not Down Control */
-#define TSC2005_REG_X			(0x0 << 3)
-#define TSC2005_REG_Y			(0x1 << 3)
-#define TSC2005_REG_Z1			(0x2 << 3)
-#define TSC2005_REG_Z2			(0x3 << 3)
-#define TSC2005_REG_AUX			(0x4 << 3)
-#define TSC2005_REG_TEMP1		(0x5 << 3)
-#define TSC2005_REG_TEMP2		(0x6 << 3)
-#define TSC2005_REG_STATUS		(0x7 << 3)
-#define TSC2005_REG_AUX_HIGH		(0x8 << 3)
-#define TSC2005_REG_AUX_LOW		(0x9 << 3)
-#define TSC2005_REG_TEMP_HIGH		(0xA << 3)
-#define TSC2005_REG_TEMP_LOW		(0xB << 3)
-#define TSC2005_REG_CFR0		(0xC << 3)
-#define TSC2005_REG_CFR1		(0xD << 3)
-#define TSC2005_REG_CFR2		(0xE << 3)
-#define TSC2005_REG_CONV_FUNC		(0xF << 3)
+#define TSC200X_REG_READ		0x01 /* R/W access */
+#define TSC200X_REG_PND0		0x02 /* Power Not Down Control */
+#define TSC200X_REG_X			(0x0 << 3)
+#define TSC200X_REG_Y			(0x1 << 3)
+#define TSC200X_REG_Z1			(0x2 << 3)
+#define TSC200X_REG_Z2			(0x3 << 3)
+#define TSC200X_REG_AUX			(0x4 << 3)
+#define TSC200X_REG_TEMP1		(0x5 << 3)
+#define TSC200X_REG_TEMP2		(0x6 << 3)
+#define TSC200X_REG_STATUS		(0x7 << 3)
+#define TSC200X_REG_AUX_HIGH		(0x8 << 3)
+#define TSC200X_REG_AUX_LOW		(0x9 << 3)
+#define TSC200X_REG_TEMP_HIGH		(0xA << 3)
+#define TSC200X_REG_TEMP_LOW		(0xB << 3)
+#define TSC200X_REG_CFR0		(0xC << 3)
+#define TSC200X_REG_CFR1		(0xD << 3)
+#define TSC200X_REG_CFR2		(0xE << 3)
+#define TSC200X_REG_CONV_FUNC		(0xF << 3)
 
 /* configuration register 0 */
-#define TSC2005_CFR0_PRECHARGE_276US	0x0040
-#define TSC2005_CFR0_STABTIME_1MS	0x0300
-#define TSC2005_CFR0_CLOCK_1MHZ		0x1000
-#define TSC2005_CFR0_RESOLUTION12	0x2000
-#define TSC2005_CFR0_PENMODE		0x8000
-#define TSC2005_CFR0_INITVALUE		(TSC2005_CFR0_STABTIME_1MS    | \
-					 TSC2005_CFR0_CLOCK_1MHZ      | \
-					 TSC2005_CFR0_RESOLUTION12    | \
-					 TSC2005_CFR0_PRECHARGE_276US | \
-					 TSC2005_CFR0_PENMODE)
+#define TSC200X_CFR0_PRECHARGE_276US	0x0040
+#define TSC200X_CFR0_STABTIME_1MS	0x0300
+#define TSC200X_CFR0_CLOCK_1MHZ		0x1000
+#define TSC200X_CFR0_RESOLUTION12	0x2000
+#define TSC200X_CFR0_PENMODE		0x8000
+#define TSC200X_CFR0_INITVALUE		(TSC200X_CFR0_STABTIME_1MS    | \
+					 TSC200X_CFR0_CLOCK_1MHZ      | \
+					 TSC200X_CFR0_RESOLUTION12    | \
+					 TSC200X_CFR0_PRECHARGE_276US | \
+					 TSC200X_CFR0_PENMODE)
 
 /* bits common to both read and write of configuration register 0 */
-#define	TSC2005_CFR0_RW_MASK		0x3fff
+#define	TSC200X_CFR0_RW_MASK		0x3fff
 
 /* configuration register 1 */
-#define TSC2005_CFR1_BATCHDELAY_4MS	0x0003
-#define TSC2005_CFR1_INITVALUE		TSC2005_CFR1_BATCHDELAY_4MS
+#define TSC200X_CFR1_BATCHDELAY_4MS	0x0003
+#define TSC200X_CFR1_INITVALUE		TSC200X_CFR1_BATCHDELAY_4MS
 
 /* configuration register 2 */
-#define TSC2005_CFR2_MAVE_Z		0x0004
-#define TSC2005_CFR2_MAVE_Y		0x0008
-#define TSC2005_CFR2_MAVE_X		0x0010
-#define TSC2005_CFR2_AVG_7		0x0800
-#define TSC2005_CFR2_MEDIUM_15		0x3000
-#define TSC2005_CFR2_INITVALUE		(TSC2005_CFR2_MAVE_X	| \
-					 TSC2005_CFR2_MAVE_Y	| \
-					 TSC2005_CFR2_MAVE_Z	| \
-					 TSC2005_CFR2_MEDIUM_15	| \
-					 TSC2005_CFR2_AVG_7)
+#define TSC200X_CFR2_MAVE_Z		0x0004
+#define TSC200X_CFR2_MAVE_Y		0x0008
+#define TSC200X_CFR2_MAVE_X		0x0010
+#define TSC200X_CFR2_AVG_7		0x0800
+#define TSC200X_CFR2_MEDIUM_15		0x3000
+#define TSC200X_CFR2_INITVALUE		(TSC200X_CFR2_MAVE_X	| \
+					 TSC200X_CFR2_MAVE_Y	| \
+					 TSC200X_CFR2_MAVE_Z	| \
+					 TSC200X_CFR2_MEDIUM_15	| \
+					 TSC200X_CFR2_AVG_7)
 
 #define MAX_12BIT			0xfff
-#define TSC2005_DEF_X_FUZZ		4
-#define TSC2005_DEF_Y_FUZZ		8
-#define TSC2005_DEF_P_FUZZ		2
-#define TSC2005_DEF_RESISTOR		280
+#define TSC200X_DEF_X_FUZZ		4
+#define TSC200X_DEF_Y_FUZZ		8
+#define TSC200X_DEF_P_FUZZ		2
+#define TSC200X_DEF_RESISTOR		280
 
-#define TSC2005_SPI_MAX_SPEED_HZ       10000000
-#define TSC2005_PENUP_TIME_MS		40
+#define TSC2005_SPI_MAX_SPEED_HZ	10000000
+#define TSC200X_PENUP_TIME_MS		40
 
 extern const struct regmap_config tsc200x_regmap_config;
 extern const struct dev_pm_ops tsc200x_pm_ops;
-- 
2.1.4
