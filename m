From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 2/2] input: touchscreen: atmel_mxt_ts: Add support for Device
 Tree
Date: Thu, 04 Apr 2013 18:14:26 +0200
Message-ID: <1365092066-31753-3-git-send-email-t.figa@samsung.com>
References: <1365092066-31753-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1365092066-31753-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, kyungmin.park@samsung.com, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch adds support for Device Tree-based instantation to the
atmel_mxt_ts driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/input/touchscreen/atmel_mxt_ts.txt    | 51 +++++++++++++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 72 ++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/atmel_mxt_ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/atmel_mxt_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/atmel_mxt_ts.txt
new file mode 100644
index 0000000..d3149e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/atmel_mxt_ts.txt
@@ -0,0 +1,51 @@
+* Atmel maXtouch touchscreen controller
+
+Required properties:
+- compatible: must be "atmel,maxtouch"
+- reg: I2C address of the chip
+- interrupt-parent: interrupt controller which provides the interrupt
+- interrupts: interrupt signal to which the chip is connected
+- atmel,x-line: horizonal line
+- atmel,y-line: vertical line
+- atmel,x-size: horizontal resolution of touchscreen
+- atmel,y-size: vertical resolution of touchscreen
+- atmel,burst-length: burst length
+- atmel,threshold: threshold
+- atmel,orientation: touchscreen orientation, must be one of following:
+    - 0: normal
+    - 1: diagonal
+    - 2: horizonally flipped
+    - 3: rotated by 90 degrees counter-clockwise
+    - 4: vertically flipped
+    - 5: rotated by 90 degress clockwise
+    - 6: rotated by 180 degrees
+    - 7: diagonal counter
+
+Optional properties:
+- vdd-supply: voltage regulator used for power control and reading
+  operating voltage
+
+Example:
+
+	i2c@00000000 {
+		/* ... */
+
+		tsp@4a {
+			compatible = "atmel,maxtouch";
+			reg = <0x4a>;
+			interrupt-parent = <&gpe1>;
+			interrupts = <7 2>;
+
+			atmel,x-line = <19>;
+			atmel,y-line = <11>;
+			atmel,x-size = <800>;
+			atmel,y-size = <480>;
+			atmel,burst-length = <0x11>;
+			atmel,threshold = <0x28>;
+			atmel,orientation = <1>;
+
+			vdd-supply = <&tsp_reg>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index de708ff..611ac6f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1130,6 +1130,74 @@ static void mxt_input_close(struct input_dev *dev)
 	mxt_stop(data);
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mxt_dt_match[] = {
+	{ .compatible = "atmel,maxtouch" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mxt_dt_match);
+
+static struct mxt_platform_data *mxt_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct mxt_platform_data *pd;
+	u32 val;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "Failed to allocate platform data\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,x-line", &pd->x_line)) {
+		dev_err(dev, "failed to get atmel,x-line property\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,y-line", &pd->y_line)) {
+		dev_err(dev, "failed to get atmel,y-line property\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,x-size", &pd->x_size)) {
+		dev_err(dev, "failed to get atmel,x-size property\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,y-size", &pd->y_size)) {
+		dev_err(dev, "failed to get atmel,y-size property\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,burst-length", &pd->blen)) {
+		dev_err(dev, "failed to get atmel,burst-length property\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,threshold", &pd->threshold)) {
+		dev_err(dev, "failed to get atmel,threshold property\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "atmel,orientation", &val)) {
+		dev_err(dev, "failed to get atmel,orientation property\n");
+		return NULL;
+	}
+	if (val > MXT_DIAGONAL_COUNTER) {
+		dev_err(dev, "invalid value for atmel-orientation property\n");
+		return NULL;
+	}
+	pd->orient = val;
+
+	return pd;
+}
+#else
+static struct mxt_platform_data *mxt_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int mxt_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -1139,6 +1207,9 @@ static int mxt_probe(struct i2c_client *client,
 	int error;
 	unsigned int num_mt_slots;
 
+	if (!pdata && client->dev.of_node)
+		pdata = mxt_parse_dt(&client->dev);
+
 	if (!pdata)
 		return -EINVAL;
 
@@ -1343,6 +1414,7 @@ static struct i2c_driver mxt_driver = {
 		.name	= "atmel_mxt_ts",
 		.owner	= THIS_MODULE,
 		.pm	= &mxt_pm_ops,
+		.of_match_table = of_match_ptr(mxt_dt_match),
 	},
 	.probe		= mxt_probe,
 	.remove		= mxt_remove,
-- 
1.8.1.5
