From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH V10] input: add onkey support to 88PM80X PMIC
Date: Tue, 17 Jul 2012 15:17:39 +0800
Message-ID: <1342509459-16976-2-git-send-email-zhouqiao@marvell.com>
References: <1342509459-16976-1-git-send-email-zhouqiao@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44655 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750847Ab2GQHZJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jul 2012 03:25:09 -0400
In-Reply-To: <1342509459-16976-1-git-send-email-zhouqiao@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org
Cc: Qiao Zhou <zhouqiao@marvell.com>

add onkey support to MARVELL 88PM80X PMIC.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/88pm80x_onkey.c |  168 ++++++++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |   10 ++
 drivers/input/misc/Makefile        |    1 +
 3 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c

diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
new file mode 100644
index 0000000..7f26e7b
--- /dev/null
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -0,0 +1,168 @@
+/*
+ * Marvell 88PM80x ONKEY driver
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define PM800_LONG_ONKEY_EN		(1 << 0)
+#define PM800_LONG_KEY_DELAY		(8)	/* 1 .. 16 seconds */
+#define PM800_LONKEY_PRESS_TIME		((PM800_LONG_KEY_DELAY-1) << 4)
+#define PM800_LONKEY_PRESS_TIME_MASK	(0xF0)
+#define PM800_SW_PDOWN			(1 << 5)
+
+struct pm80x_onkey_info {
+	struct input_dev *idev;
+	struct pm80x_chip *pm80x;
+	struct regmap *map;
+	int irq;
+};
+
+/* 88PM80x gives us an interrupt when ONKEY is held */
+static irqreturn_t pm80x_onkey_handler(int irq, void *data)
+{
+	struct pm80x_onkey_info *info = data;
+	int ret = 0;
+	unsigned int val;
+
+	ret = regmap_read(info->map, PM800_STATUS_1, &val);
+	if (ret < 0) {
+		dev_err(info->idev->dev.parent, "failed to read status: %d\n", ret);
+		return IRQ_NONE;
+	}
+	val &= PM800_ONKEY_STS1;
+
+	input_report_key(info->idev, KEY_POWER, val);
+	input_sync(info->idev);
+
+	return IRQ_HANDLED;
+}
+
+static SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
+			 pm80x_dev_resume);
+
+static int __devinit pm80x_onkey_probe(struct platform_device *pdev)
+{
+
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm80x_onkey_info *info;
+	int err;
+
+	info = kzalloc(sizeof(struct pm80x_onkey_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->pm80x = chip;
+
+	info->irq = platform_get_irq(pdev, 0);
+	if (info->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	info->map = info->pm80x->regmap;
+	if (!info->map) {
+		dev_err(&pdev->dev, "no regmap!\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	info->idev = input_allocate_device();
+	if (!info->idev) {
+		dev_err(&pdev->dev, "Failed to allocate input dev\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	info->idev->name = "88pm80x_on";
+	info->idev->phys = "88pm80x_on/input0";
+	info->idev->id.bustype = BUS_I2C;
+	info->idev->dev.parent = &pdev->dev;
+	info->idev->evbit[0] = BIT_MASK(EV_KEY);
+	__set_bit(KEY_POWER, info->idev->keybit);
+
+	err = pm80x_request_irq(info->pm80x, info->irq, pm80x_onkey_handler,
+					    IRQF_ONESHOT, "onkey", info);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq, err);
+		goto out_reg;
+	}
+
+	err = input_register_device(info->idev);
+	if (err) {
+		dev_err(&pdev->dev, "Can't register input device: %d\n", err);
+		goto out_irq;
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	/* Enable long onkey detection */
+	regmap_update_bits(info->map, PM800_RTC_MISC4, PM800_LONG_ONKEY_EN,
+			   PM800_LONG_ONKEY_EN);
+	/* Set 8-second interval */
+	regmap_update_bits(info->map, PM800_RTC_MISC3,
+			   PM800_LONKEY_PRESS_TIME_MASK,
+			   PM800_LONKEY_PRESS_TIME);
+
+	device_init_wakeup(&pdev->dev, 1);
+	return 0;
+
+out_irq:
+	pm80x_free_irq(info->pm80x, info->irq, info);
+out_reg:
+	input_free_device(info->idev);
+out:
+	kfree(info);
+	return err;
+}
+
+static int __devexit pm80x_onkey_remove(struct platform_device *pdev)
+{
+	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
+
+	device_init_wakeup(&pdev->dev, 0);
+	pm80x_free_irq(info->pm80x, info->irq, info);
+	input_unregister_device(info->idev);
+	kfree(info);
+	return 0;
+}
+
+static struct platform_driver pm80x_onkey_driver = {
+	.driver = {
+		   .name = "88pm80x-onkey",
+		   .owner = THIS_MODULE,
+		   .pm = &pm80x_onkey_pm_ops,
+		   },
+	.probe = pm80x_onkey_probe,
+	.remove = __devexit_p(pm80x_onkey_remove),
+};
+
+module_platform_driver(pm80x_onkey_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell 88PM80x ONKEY driver");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_ALIAS("platform:88pm80x-onkey");
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7faf4a7..7c0f1ec 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -22,6 +22,16 @@ config INPUT_88PM860X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm860x_onkey.
 
+config INPUT_88PM80X_ONKEY
+	tristate "88PM80x ONKEY support"
+	depends on MFD_88PM800
+	help
+	  Support the ONKEY of Marvell 88PM80x PMICs as an input device
+	  reporting power button status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 88pm80x_onkey.
+
 config INPUT_AB8500_PONKEY
 	tristate "AB8500 Pon (PowerOn) Key"
 	depends on AB8500_CORE
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index f55cdf4..83fe6f5 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
+obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
 obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
-- 
1.7.0.4

