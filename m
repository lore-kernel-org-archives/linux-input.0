From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v7 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Date: Tue, 19 Jun 2018 13:57:09 +0300
Message-ID: <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

ROHM BD71837 PMIC power button driver providing power-key press
information to user-space.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/input/misc/Kconfig          | 10 +++++
 drivers/input/misc/Makefile         |  1 +
 drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/input/misc/bd718xx-pwrkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 572b15fa18c2..694c05d3f9fb 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -96,6 +96,16 @@ config INPUT_ATMEL_CAPTOUCH
 	  To compile this driver as a module, choose M here: the
 	  module will be called atmel_captouch.
 
+config INPUT_BD718XX_PWRKEY
+	tristate "ROHM BD71837/BD71847 power key support"
+	depends on MFD_BD71837
+	help
+	  Say Y here if you want support for the power key usually found
+	  on boards using a ROHM BD71837/BD71847 compatible PMIC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bd718xx-pwrkey.
+
 config INPUT_BMA150
 	tristate "BMA150/SMB380 acceleration sensor support"
 	depends on I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 72cde28649e2..ea5b81cbf2bf 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
 obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
+obj-$(CONFIG_INPUT_BD718XX_PWRKEY)	+= bd718xx-pwrkey.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
diff --git a/drivers/input/misc/bd718xx-pwrkey.c b/drivers/input/misc/bd718xx-pwrkey.c
new file mode 100644
index 000000000000..e8ac9475c3cf
--- /dev/null
+++ b/drivers/input/misc/bd718xx-pwrkey.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd718xx-pwrkey.c -- ROHM BD71837MWV and BD71847 power button driver
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/mfd/bd71837.h>
+
+struct bd718xx_pwrkey {
+	struct input_dev *idev;
+	struct bd71837 *mfd;
+	int irq;
+};
+
+static irqreturn_t button_irq(int irq, void *_priv)
+{
+	struct input_dev *idev = (struct input_dev *)_priv;
+
+	input_report_key(idev, KEY_POWER, 1);
+	input_sync(idev);
+	input_report_key(idev, KEY_POWER, 0);
+	input_sync(idev);
+
+	return IRQ_HANDLED;
+}
+
+static int bd718xx_pwr_btn_probe(struct platform_device *pdev)
+{
+	int err = -ENOMEM;
+	struct bd718xx_pwrkey *pk;
+
+	pk = devm_kzalloc(&pdev->dev, sizeof(*pk), GFP_KERNEL);
+	if (!pk)
+		goto err_out;
+
+	pk->mfd = dev_get_drvdata(pdev->dev.parent);
+
+	pk->idev = devm_input_allocate_device(&pdev->dev);
+	if (!pk->idev)
+		goto err_out;
+
+	pk->idev->name = "bd718xx-pwrkey";
+	pk->idev->phys = "bd718xx-pwrkey/input0";
+	pk->idev->dev.parent = &pdev->dev;
+
+	input_set_capability(pk->idev, EV_KEY, KEY_POWER);
+
+	err = platform_get_irq_byname(pdev, "pwr-btn-s");
+	if (err < 0) {
+		dev_err(&pdev->dev, "could not get power key interrupt\n");
+		goto err_out;
+	}
+
+	pk->irq = err;
+	err = devm_request_threaded_irq(&pdev->dev, pk->irq, NULL, &button_irq,
+					0, "bd718xx-pwrkey", pk);
+	if (err)
+		goto err_out;
+
+	platform_set_drvdata(pdev, pk);
+	err = regmap_update_bits(pk->mfd->regmap,
+				 BD71837_REG_PWRONCONFIG0,
+				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
+				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
+	if (err)
+		goto err_out;
+
+	err = input_register_device(pk->idev);
+
+err_out:
+
+	return err;
+}
+
+static struct platform_driver bd718xx_pwr_btn_driver = {
+	.probe	= bd718xx_pwr_btn_probe,
+	.driver = {
+		.name	= "bd718xx-pwrkey",
+	},
+};
+module_platform_driver(bd718xx_pwr_btn_driver);
+MODULE_DESCRIPTION("Power button driver for buttons connected to ROHM bd71837/bd71847 PMIC");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+
-- 
2.14.3
