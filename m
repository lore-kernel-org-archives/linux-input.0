From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fromy: Hong Liu <hong.liu@intel.com>
Date: Tue, 25 Jan 2011 14:32:12 +0000
Message-ID: <20110125143139.10249.33984.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49634 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1AYO6x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 09:58:53 -0500
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p0PEvq3S008197
	for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 14:57:57 GMT
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

intel_mid_powerbtn: add power button driver for Medfield platform

The power button is connected to MSIC on Medfield, we will get two
interrupts from IOAPIC when pressing or releasing the power button.

Signed-off-by: Hong Liu <hong.liu@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/platform/x86/Kconfig              |    9 ++
 drivers/platform/x86/Makefile             |    2 
 drivers/platform/x86/intel_mid_powerbtn.c |  143 +++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 drivers/platform/x86/intel_mid_powerbtn.c


diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index d163bc2..8ceea88 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -654,4 +654,13 @@ config XO1_RFKILL
 	  Support for enabling/disabling the WLAN interface on the OLPC XO-1
 	  laptop.
 
+config INTEL_MID_POWER_BUTTON
+	tristate "power button driver for Intel MID platforms"
+	depends on INTEL_SCU_IPC
+	default y
+	help
+	  This driver handles the power button on the Intel MID platforms.
+
+	  If unsure, say N.
+
 endif # X86_PLATFORM_DEVICES
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4ec4ff8..a24cd62 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -34,3 +34,5 @@ obj-$(CONFIG_INTEL_IPS)		+= intel_ips.o
 obj-$(CONFIG_GPIO_INTEL_PMIC)	+= intel_pmic_gpio.o
 obj-$(CONFIG_XO1_RFKILL)	+= xo1-rfkill.o
 obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
+obj-$(CONFIG_INTEL_MID_POWER_BUTTON)	+= intel_mid_powerbtn.o
+
diff --git a/drivers/platform/x86/intel_mid_powerbtn.c b/drivers/platform/x86/intel_mid_powerbtn.c
new file mode 100644
index 0000000..4f68f1d
--- /dev/null
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@ -0,0 +1,143 @@
+/*
+ * Power button driver for Medfield.
+ *
+ * Copyright (C) 2010 Intel Corp
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <asm/intel_scu_ipc.h>
+
+#define DRIVER_NAME "msic_power_btn"
+
+#define MSIC_IRQ_STAT	0x02
+  #define MSIC_IRQ_PB	(1 << 0)
+#define MSIC_PB_CONFIG	0x3e
+#define MSIC_PB_STATUS	0x3f
+  #define MSIC_PB_LEVEL (1 << 3) /* 1 - release, 0 - press */
+
+struct mfld_pb_priv {
+	struct input_dev *input;
+	int irq;
+};
+
+static irqreturn_t mfld_pb_isr(int irq, void *dev_id)
+{
+	struct mfld_pb_priv *priv = dev_id;
+	int ret;
+	u8 pbstat;
+
+	ret = intel_scu_ipc_ioread8(MSIC_PB_STATUS, &pbstat);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	input_event(priv->input, EV_KEY, KEY_POWER, !(pbstat & MSIC_PB_LEVEL));
+	input_sync(priv->input);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit mfld_pb_probe(struct platform_device *pdev)
+{
+	struct mfld_pb_priv *priv;
+	struct input_dev *input;
+	int ret;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(struct mfld_pb_priv), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!priv || !input) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	priv->input = input;
+	priv->irq = irq;
+	platform_set_drvdata(pdev, priv);
+
+	input->name = pdev->name;
+	input->phys = "power-button/input0";
+	input->dev.parent = &pdev->dev;
+
+	input_set_capability(input, EV_KEY, KEY_POWER);
+
+	ret = request_threaded_irq(priv->irq, NULL, mfld_pb_isr,
+				   0, DRIVER_NAME, priv);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to request irq %d for mfld power button\n",irq);
+		goto fail;
+	}
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to register input dev, error %d\n", ret);
+		goto fail;
+	}
+	return 0;
+
+fail:
+	platform_set_drvdata(pdev, NULL);
+	input_free_device(input);
+	kfree(priv);
+	return ret;
+}
+
+static int __devexit mfld_pb_remove(struct platform_device *pdev)
+{
+	struct mfld_pb_priv *priv = platform_get_drvdata(pdev);
+
+	free_irq(priv->irq, priv);
+	input_unregister_device(priv->input);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct platform_driver mfld_pb_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe	= mfld_pb_probe,
+	.remove	= __devexit_p(mfld_pb_remove),
+};
+
+static int __init mfld_pb_init(void)
+{
+	return platform_driver_register(&mfld_pb_driver);
+}
+
+static void __exit mfld_pb_exit(void)
+{
+	platform_driver_unregister(&mfld_pb_driver);
+}
+
+module_init(mfld_pb_init);
+module_exit(mfld_pb_exit);
+
+MODULE_AUTHOR("Hong Liu <hong.liu@intel.com>");
+MODULE_DESCRIPTION("Intel Medfield Power Button Driver");
+MODULE_LICENSE("GPL v2");

