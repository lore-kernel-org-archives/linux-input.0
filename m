From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v3 1/9] Input: sun4i-ts: Add thermal zone sensor support
Date: Mon, 12 Jan 2015 12:34:01 +0800
Message-ID: <1421037249-28461-2-git-send-email-wens@csie.org>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1421037249-28461-1-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The touchscreen controller has a temperature sensor embedded in the SoC,
which already has hwmon support in the driver.

Add DT thermal zone support so we can use it with cpufreq for thermal
throttling.

This also adds a comment stating that we do not know the actual formula
for calculating the temperature.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

changes since v2:

    - Use common function for temperature calculation

changes since v1:

    - clean up thermal zone sensor when input device register fails
    - unconditionally unregister thermal zone sensor on removal.
      the unregister function checks the pointers passed in.
    - add comment explaining the lack of documents for the temperature
      calculation formula

---
 .../bindings/input/touchscreen/sun4i.txt           |  2 +
 drivers/input/touchscreen/sun4i-ts.c               | 54 ++++++++++++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
index aef57791f40b..a8405bab6c00 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
@@ -5,6 +5,7 @@ Required properties:
  - compatible: "allwinner,sun4i-a10-ts"
  - reg: mmio address range of the chip
  - interrupts: interrupt to which the chip is connected
+ - #thermal-sensor-cells: shall be 0
 
 Optional properties:
  - allwinner,ts-attached: boolean indicating that an actual touchscreen is
@@ -17,4 +18,5 @@ Example:
 		reg = <0x01c25000 0x100>;
 		interrupts = <29>;
 		allwinner,ts-attached;
+		#thermal-sensor-cells = <0>;
 	};
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 28a06749ae42..5851aa0bd78b 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -34,6 +34,7 @@
 
 #include <linux/err.h>
 #include <linux/hwmon.h>
+#include <linux/thermal.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -107,6 +108,7 @@
 struct sun4i_ts_data {
 	struct device *dev;
 	struct input_dev *input;
+	struct thermal_zone_device *tz;
 	void __iomem *base;
 	unsigned int irq;
 	bool ignore_fifo_data;
@@ -180,16 +182,48 @@ static void sun4i_ts_close(struct input_dev *dev)
 	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
 }
 
+static int get_temp(const struct sun4i_ts_data *ts, long *temp)
+{
+	/* No temp_data until the first irq */
+	if (ts->temp_data == -1)
+		return -EAGAIN;
+
+	/*
+	 * The user manuals do not contain the formula for calculating
+	 * the temperature. The formula used here is from the AXP209,
+	 * which is designed by X-Powers, an affiliate of Allwinner:
+	 *
+	 *     temperature = -144.7 + (value * 0.1)
+	 *
+	 * This should be replaced with the correct one if such information
+	 * becomes available.
+	 */
+	*temp = (ts->temp_data - 1447) * 100;
+
+	return 0;
+}
+
+static int get_tz_temp(void *data, long *temp)
+{
+	return get_temp(data, temp);
+}
+
+static struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+	.get_temp = get_tz_temp,
+};
+
 static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sun4i_ts_data *ts = dev_get_drvdata(dev);
+	long temp;
+	int ret;
 
-	/* No temp_data until the first irq */
-	if (ts->temp_data == -1)
-		return -EAGAIN;
+	ret = get_temp(ts, &temp);
+	if (ret)
+		return ret;
 
-	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * 100);
+	return sprintf(buf, "%ld\n", temp);
 }
 
 static ssize_t show_temp_label(struct device *dev,
@@ -283,17 +317,27 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
 	       ts->base + TP_CTRL1);
 
+	/*
+	 * The thermal core does not register hwmon devices for DT-based
+	 * thermal zone sensors, such as this one.
+	 */
 	hwmon = devm_hwmon_device_register_with_groups(ts->dev, "sun4i_ts",
 						       ts, sun4i_ts_groups);
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
+	ts->tz = thermal_zone_of_sensor_register(ts->dev, 0, ts,
+						 &sun4i_ts_tz_ops);
+	if (IS_ERR(ts->tz))
+		ts->tz = NULL;
+
 	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
 
 	if (ts_attached) {
 		error = input_register_device(ts->input);
 		if (error) {
 			writel(0, ts->base + TP_INT_FIFOC);
+			thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
 			return error;
 		}
 	}
@@ -310,6 +354,8 @@ static int sun4i_ts_remove(struct platform_device *pdev)
 	if (ts->input)
 		input_unregister_device(ts->input);
 
+	thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
+
 	/* Deactivate all IRQs */
 	writel(0, ts->base + TP_INT_FIFOC);
 
-- 
2.1.4

