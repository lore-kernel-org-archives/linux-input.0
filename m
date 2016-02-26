From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH] Input: raspberrypi-ft5406: Add Raspberry Pi Touchscreen driver
Date: Fri, 26 Feb 2016 10:30:36 +0100
Message-ID: <1456479036-13174-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Gordon Hollingworth <gordon-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Raspberry Pi uses a FT5406 attached to the VideoCore's I2C bus. The
firmware runs a thread that periodicaly does a register dump to a shared
memory window.  The interrupt and wake signals seem disconnected.

This driver is based on the driver by Gordon Hollingworth. Notable changes:
 - Changed to use input polldev instead of a dedicated thread
 - Streamlined the probe routing with devm_*() functions
 - Get a memory window from the device tree instead of via firmware call

Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Gordon Hollingworth <gordon-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Signed-off-by: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
---
A few notes/questions; to the bcm2835 crowd:

- Tested on RPi2 (with some changes, see below) with the touchscreen connected
  only to the DSI connector (the cables to I2C1 not in place).

- This now uses the memory window that needs to be set up by the bootloader. 

  The necessary change to u-boot (not submitted yet) is here:
  https://github.com/lkundrak/u-boot/commit/860614e8.patch

  Is this okay? It makes the driver simpler as if we called firmware directly.

- It would probably be best if we could access the I2C directly.

  According to Gordon Hollingworth it's not possible, since the VideoCore
  uses the bus for its business too (power control).

  Could we perhaps convince Raspberry Pi to include a more generic I2C
  interface via firmware?

- The driver doesn't work now, since when the gpio driver sets the gpios 0 and 1 
  to alt0 the firmware stops updating the buffer.

  This might be a firmware bug? The firmware not being able to access I2C
  might not be a good thing in any case?

  No idea why this doesn't happen with the downstream kernel; their gpio driver
  is mostly the same and they set the 0 and 1 gpios to alt0 too.

  Nevertheless, with this in place it works:
  https://github.com/hackerspace/rpi-linux/commit/ee38eac2.patch

 .../input/touchscreen/raspberrypi-ft5406.txt       |  16 ++
 drivers/input/touchscreen/Kconfig                  |  13 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/raspberrypi-ft5406.c     | 189 +++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi-ft5406.txt
 create mode 100644 drivers/input/touchscreen/raspberrypi-ft5406.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi-ft5406.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi-ft5406.txt
new file mode 100644
index 0000000..81aaae6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi-ft5406.txt
@@ -0,0 +1,16 @@
+Raspberry Pi 7" Touch Screen Display
+
+Raspberry Pi uses a FT5406 attached to the VideoCore's I2C bus. The firmware
+runs a thread that periodicaly does a register dump to a shared memory window.
+The interrupt and wake signals seem disconnected.
+
+Required properties:
+ - compatible: "raspberrypi,raspberrypi-ft5406"
+ - reg: address range of the shared memory with register dump
+
+Example:
+
+        touchscreen: rpi-ft5406@3e40ea40 {
+                compatible = "raspberrypi,raspberrypi-ft5406";
+                reg = <0x3e40ea40 63>;
+        };
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 66c6264..5893c0d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -619,6 +619,19 @@ config TOUCHSCREEN_EDT_FT5X06
 	  To compile this driver as a module, choose M here: the
 	  module will be called edt-ft5x06.
 
+config TOUCHSCREEN_RASPBERRYPI_FT5406
+	tristate "Raspbery Pi 7\" Touchscreen support"
+	depends on RASPBERRYPI_FIRMWARE && OF
+	select INPUT_POLLDEV
+	help
+	  Say Y here if you have a Raspberry Pi 7" Touchscreen Display.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rapsberrypi-ft5406.
+
+
 config TOUCHSCREEN_MIGOR
 	tristate "Renesas MIGO-R touchscreen"
 	depends on SH_MIGOR && I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 968ff12..081e08d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
 obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+= edt-ft5x06.o
+obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FT5406)	+= raspberrypi-ft5406.o
 obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
diff --git a/drivers/input/touchscreen/raspberrypi-ft5406.c b/drivers/input/touchscreen/raspberrypi-ft5406.c
new file mode 100644
index 0000000..b6e3430
--- /dev/null
+++ b/drivers/input/touchscreen/raspberrypi-ft5406.c
@@ -0,0 +1,189 @@
+/*
+ * Driver for ft5406 touchscreen controller accessible via
+ * Raspberry Pi firmware
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2016 Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/input/mt.h>
+#include <linux/input-polldev.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define DEFAULT_POLL_PERIOD 17 /* 60 fps */
+
+#define MAXIMUM_SUPPORTED_POINTS 10
+struct ft5406_regs {
+	uint8_t device_mode;
+	uint8_t gesture_id;
+	uint8_t num_points;
+	struct {
+		uint8_t xh;
+		uint8_t xl;
+		uint8_t yh;
+		uint8_t yl;
+		uint8_t res1;
+		uint8_t res2;
+	} point[MAXIMUM_SUPPORTED_POINTS];
+} __packed;
+
+#define SCREEN_WIDTH  800
+#define SCREEN_HEIGHT 480
+
+struct rpi_ft5406 {
+	struct device           *dev;
+	struct input_polled_dev *poll_dev;
+	void __iomem            *base;
+	int known_ids;
+};
+
+/* This function polls the memory based register copy of the ft5406
+ * registers using the number of points register to know whether
+ * the copy has been updated (we write 99 to the memory copy, the
+ * GPU will write between 0 - 10 points)
+ */
+static void rpi_ft5406_poll(struct input_polled_dev *poll_dev)
+{
+	struct rpi_ft5406 *ts = poll_dev->private;
+	struct input_dev *input = poll_dev->input;
+	struct ft5406_regs regs;
+	int modified_ids = 0, released_ids;
+	int i;
+
+	memcpy_fromio(&regs, ts->base, sizeof(regs));
+	writel(99, ts->base + offsetof(struct ft5406_regs, num_points));
+
+	/* Check whether firmware updated the buffer since last check. */
+	if (regs.num_points == 99)
+		return;
+
+	/* Do nothing if there's no touch nor release. */
+	if (regs.num_points == 0 && ts->known_ids == 0)
+		return;
+
+	for (i = 0; i < regs.num_points; i++) {
+		int x, y, touchid;
+
+		x = (((int) regs.point[i].xh & 0xf) << 8) + regs.point[i].xl;
+		y = (((int) regs.point[i].yh & 0xf) << 8) + regs.point[i].yl;
+		touchid = (regs.point[i].yh >> 4) & 0xf;
+
+		modified_ids |= 1 << touchid;
+
+		if (!((1 << touchid) & ts->known_ids)) {
+			dev_dbg(ts->dev, "x = %d, y = %d, touchid = %d\n",
+							x, y, touchid);
+		}
+
+		input_mt_slot(input, touchid);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
+
+		input_report_abs(input, ABS_MT_POSITION_X, x);
+		input_report_abs(input, ABS_MT_POSITION_Y, y);
+
+	}
+
+	released_ids = ts->known_ids & ~modified_ids;
+	for (i = 0; released_ids && i < MAXIMUM_SUPPORTED_POINTS; i++) {
+		if (released_ids & (1<<i)) {
+			dev_dbg(ts->dev, "Released %d, known = %x modified = %x\n",
+						i, ts->known_ids, modified_ids);
+			input_mt_slot(input, i);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, 0);
+			modified_ids &= ~(1 << i);
+		}
+	}
+	ts->known_ids = modified_ids;
+
+	input_mt_report_pointer_emulation(input, true);
+	input_sync(input);
+}
+
+static int rpi_ft5406_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct input_dev *input;
+	struct rpi_ft5406 *ts;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ts->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ts->base))
+		return PTR_ERR(ts->base);
+
+	ts->poll_dev = devm_input_allocate_polled_device(dev);
+	if (!ts->poll_dev)
+		return -ENOMEM;
+
+	ts->dev = dev;
+	ts->poll_dev->private = ts;
+	ts->poll_dev->poll = rpi_ft5406_poll;
+	ts->poll_dev->poll_interval = DEFAULT_POLL_PERIOD;
+
+	platform_set_drvdata(pdev, ts);
+
+	input = ts->poll_dev->input;
+	input->name = "Raspberry Pi Touchscreen";
+
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_SYN, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, SCREEN_WIDTH, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, SCREEN_HEIGHT, 0, 0);
+
+	input_mt_init_slots(input, MAXIMUM_SUPPORTED_POINTS, INPUT_MT_DIRECT);
+
+	ret = input_register_polled_device(ts->poll_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rpi_ft5406_remove(struct platform_device *pdev)
+{
+	struct rpi_ft5406 *ts = platform_get_drvdata(pdev);
+
+	input_unregister_polled_device(ts->poll_dev);
+
+	return 0;
+}
+
+static const struct of_device_id rpi_ft5406_match[] = {
+	{ .compatible = "raspberrypi,raspberrypi-ft5406", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_ft5406_match);
+
+static struct platform_driver rpi_ft5406_driver = {
+	.driver = {
+		.name   = "raspberrypi-ft5406",
+		.owner  = THIS_MODULE,
+		.of_match_table = rpi_ft5406_match,
+	},
+	.probe          = rpi_ft5406_probe,
+	.remove         = rpi_ft5406_remove,
+};
+
+module_platform_driver(rpi_ft5406_driver);
+
+MODULE_AUTHOR("Gordon Hollingworth");
+MODULE_AUTHOR("Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>");
+MODULE_DESCRIPTION("Raspberry Pi FT5406 Touchscreen driver");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0
