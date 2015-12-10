From: Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH 2/2] Input: add touchscreen support for TS-4800
Date: Thu, 10 Dec 2015 11:11:12 -0500
Message-ID: <1449763872-572-2-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1449763872-572-1-git-send-email-damien.riegel@savoirfairelinux.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449763872-572-1-git-send-email-damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org, Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On this board, the touchscreen, an ads7843, is not handled directly by
Linux but by a companion FPGA. This FPGA is memory-mapped and the IP
design is very similar to the mk712.

This commit adds the support for this IP.

Signed-off-by: Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
---
 drivers/input/touchscreen/Kconfig     |  15 +++
 drivers/input/touchscreen/Makefile    |   1 +
 drivers/input/touchscreen/ts4800-ts.c | 238 ++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 drivers/input/touchscreen/ts4800-ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index deb14c1..2d3b2f2 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -914,6 +914,21 @@ config TOUCHSCREEN_TOUCHIT213
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchit213.
 
+config TOUCHSCREEN_TS4800
+	tristate "TS-4800 touchscreen"
+	depends on HAS_IOMEM && OF
+	select MFD_SYSCON
+	help
+	  Say Y here if you have a touchscreen on a TS-4800 board.
+
+	  On TS-4800, the touchscreen is not handled directly by Linux but by
+	  a companion FPGA.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ts4800_ts.
+
 config TOUCHSCREEN_TSC_SERIO
 	tristate "TSC-10/25/40 serial touchscreen support"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 1b79cc0..5d81ba8c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
+obj-$(CONFIG_TOUCHSCREEN_TS4800)	+= ts4800-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
diff --git a/drivers/input/touchscreen/ts4800-ts.c b/drivers/input/touchscreen/ts4800-ts.c
new file mode 100644
index 0000000..1e81b17
--- /dev/null
+++ b/drivers/input/touchscreen/ts4800-ts.c
@@ -0,0 +1,238 @@
+/*
+ * Touchscreen driver for the TS-4800 board
+ *
+ * Copyright (c) 2015 - Savoir-faire Linux
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* polling interval in ms*/
+#define POLL_INTERVAL           3
+
+/* sensor values are 12-bit wide */
+#define MAX_12BIT               ((1 << 12) - 1)
+
+#define PENDOWN_MASK            0x1
+
+#define X_OFFSET                0x0
+#define Y_OFFSET                0x2
+
+struct ts4800_ts {
+	struct input_polled_dev *poll_dev;
+	struct device           *dev;
+	char                    phys[32];
+
+	void __iomem            *base;
+	struct regmap           *regmap;
+	unsigned int            reg;
+	unsigned int            bit;
+
+	bool                    pendown;
+	int                     debounce;
+};
+
+static void ts4800_ts_open(struct input_polled_dev *dev)
+{
+	struct ts4800_ts *ts = dev->private;
+	int ret;
+
+	ret = regmap_update_bits(ts->regmap, ts->reg,
+				 1 << ts->bit, 1  << ts->bit);
+	if (ret)
+		dev_warn(ts->dev, "Failed to enable touchscreen\n");
+}
+
+static void ts4800_ts_close(struct input_polled_dev *dev)
+{
+	struct ts4800_ts *ts = dev->private;
+	int ret;
+
+	ret = regmap_update_bits(ts->regmap, ts->reg,
+				 1 << ts->bit, 0);
+	if (ret)
+		dev_warn(ts->dev, "Failed to disable touchscreen\n");
+
+}
+
+static void ts4800_ts_poll(struct input_polled_dev *dev)
+{
+	struct input_dev *input_dev = dev->input;
+	struct ts4800_ts *ts = dev->private;
+	u16 last_x = readw(ts->base + X_OFFSET);
+	u16 last_y = readw(ts->base + Y_OFFSET);
+	bool pendown = last_x & PENDOWN_MASK;
+
+	if (!pendown && ts->pendown) {
+		ts->pendown = false;
+		ts->debounce = 1;
+		input_report_key(input_dev, BTN_TOUCH, 0);
+		input_sync(input_dev);
+	}
+
+	if (pendown) {
+		if (ts->debounce) {
+			ts->debounce = 0;
+			return;
+		}
+
+		if (!ts->pendown) {
+			input_report_key(input_dev, BTN_TOUCH, 1);
+			ts->pendown = true;
+		}
+
+		last_x = ((~last_x) >> 4) & MAX_12BIT;
+		last_y = ((~last_y) >> 4) & MAX_12BIT;
+
+		input_report_abs(input_dev, ABS_X, last_x);
+		input_report_abs(input_dev, ABS_Y, last_y);
+		input_sync(input_dev);
+	}
+}
+
+static void ts4800_input_setup(struct input_dev *input_dev)
+{
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
+}
+
+static int ts4800_parse_dt(struct platform_device *pdev,
+			   struct ts4800_ts *ts)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *syscon_np;
+	struct resource *res;
+	u32 reg, bit;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ts->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ts->base))
+		return PTR_ERR(ts->base);
+
+	syscon_np = of_parse_phandle(np, "syscon", 0);
+	if (!syscon_np) {
+		dev_err(dev, "no syscon property\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32_index(np, "syscon", 1, &reg);
+	if (ret < 0) {
+		dev_err(dev, "no offset in syscon\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32_index(np, "syscon", 2, &bit);
+	if (ret < 0) {
+		dev_err(dev, "no bit in syscon\n");
+		return ret;
+	}
+
+	ts->reg = reg;
+	ts->bit = bit;
+	ts->regmap = syscon_node_to_regmap(syscon_np);
+
+	if (IS_ERR(ts->regmap)) {
+		dev_err(dev, "cannot get parent's regmap\n");
+		return PTR_ERR(ts->regmap);
+	}
+
+	return 0;
+}
+
+static int ts4800_ts_probe(struct platform_device *pdev)
+{
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input_dev;
+	struct ts4800_ts *ts;
+	int ret;
+
+	ts = devm_kzalloc(&pdev->dev, sizeof(struct ts4800_ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ret = ts4800_parse_dt(pdev, ts);
+	if (ret)
+		return ret;
+
+	poll_dev = devm_input_allocate_polled_device(&pdev->dev);
+	if (!poll_dev)
+		return -ENOMEM;
+
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&pdev->dev));
+	ts->poll_dev = poll_dev;
+	ts->dev = &pdev->dev;
+	ts->pendown = false;
+	ts->debounce = 1;
+
+	poll_dev->private = ts;
+	poll_dev->poll_interval = POLL_INTERVAL;
+	poll_dev->open = ts4800_ts_open;
+	poll_dev->close = ts4800_ts_close;
+	poll_dev->poll = ts4800_ts_poll;
+
+	ts4800_input_setup(poll_dev->input);
+
+	input_dev = poll_dev->input;
+	input_dev->name = "TS-4800 Touchscreen";
+	input_dev->phys = ts->phys;
+	input_dev->dev.parent = pdev->dev.parent;
+
+	ret = input_register_polled_device(poll_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Unabled to register polled input device (%d)\n",
+			ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ts);
+
+	return 0;
+}
+
+static int ts4800_ts_remove(struct platform_device *pdev)
+{
+	struct ts4800_ts *ts = platform_get_drvdata(pdev);
+	struct input_polled_dev *poll_dev = ts->poll_dev;
+
+	input_unregister_polled_device(poll_dev);
+
+	return 0;
+}
+
+static const struct of_device_id ts4800_ts_of_match[] = {
+	{ .compatible = "technologic,ts4800-ts", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ts4800_ts_of_match);
+
+static struct platform_driver ts4800_ts_driver = {
+	.driver = {
+		.name = "ts4800-ts",
+		.of_match_table = ts4800_ts_of_match,
+	},
+	.probe = ts4800_ts_probe,
+	.remove = ts4800_ts_remove,
+};
+module_platform_driver(ts4800_ts_driver);
+
+MODULE_AUTHOR("Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>");
+MODULE_DESCRIPTION("TS-4800 Touchscreen Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ts4800_ts");
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
