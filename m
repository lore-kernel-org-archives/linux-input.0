From: Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v3] input,serio: support for GRLIB APBPS2 PS/2 Keyboard/Mouse
Date: Mon, 25 Feb 2013 11:12:26 +0100
Message-ID: <1361787146-21527-1-git-send-email-daniel@gaisler.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:30660 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753830Ab3BYKNp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 05:13:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, software@gaisler.com

APBPS2 is a PS/2 core part of GRLIB found in SPARC32/LEON
products.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 .../bindings/input/ps2keyb-mouse-apbps2.txt        |   16 ++
 drivers/input/serio/Kconfig                        |   10 +
 drivers/input/serio/Makefile                       |    1 +
 drivers/input/serio/apbps2.c                       |  232 ++++++++++++++++++++
 4 files changed, 259 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ps2keyb-mouse-apbps2.txt
 create mode 100644 drivers/input/serio/apbps2.c

diff --git a/Documentation/devicetree/bindings/input/ps2keyb-mouse-apbps2.txt b/Documentation/devicetree/bindings/input/ps2keyb-mouse-apbps2.txt
new file mode 100644
index 0000000..3029c56
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ps2keyb-mouse-apbps2.txt
@@ -0,0 +1,16 @@
+Aeroflex Gaisler APBPS2 PS/2 Core, supporting Keyboard or Mouse.
+
+The APBPS2 PS/2 core is available in the GRLIB VHDL IP core library.
+
+Note: In the ordinary environment for the APBPS2 core, a LEON SPARC system,
+these properties are built from information in the AMBA plug&play and from
+bootloader settings.
+
+Required properties:
+
+- name : Should be "GAISLER_APBPS2" or "01_060"
+- reg : Address and length of the register set for the device
+- interrupts : Interrupt numbers for this device
+
+For further information look in the documentation for the GLIB IP core library:
+http://www.gaisler.com/products/grlib/grip.pdf
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 560c243..4a6bb3d 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -244,4 +244,14 @@ config SERIO_ARC_PS2
 	  To compile this driver as a module, choose M here; the module
 	  will be called arc_ps2.
 
+config SERIO_APBPS2
+        tristate "GRLIB APBPS2 PS/2 keyboard/mouse controller"
+	depends on OF
+        help
+          Say Y here if you want support for GRLIB APBPS2 peripherals used
+          to connect to PS/2 keyboard and/or mouse.
+
+          To compile this driver as a module, choose M here: the module will
+          be called apbps2.
+
 endif
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 4b0c8f8..8edb36c 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_serio.o
 obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
 obj-$(CONFIG_SERIO_ALTERA_PS2)	+= altera_ps2.o
 obj-$(CONFIG_SERIO_ARC_PS2)	+= arc_ps2.o
+obj-$(CONFIG_SERIO_APBPS2)	+= apbps2.o
diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
new file mode 100644
index 0000000..611aac0
--- /dev/null
+++ b/drivers/input/serio/apbps2.c
@@ -0,0 +1,232 @@
+/*
+ * Copyright (C) 2013 Aeroflex Gaisler
+ *
+ * This driver supports the APBPS2 PS/2 core available in the GRLIB
+ * VHDL IP core library.
+ *
+ * Full documentation of the APBPS2 core can be found here:
+ * http://www.gaisler.com/products/grlib/grip.pdf
+ *
+ * See "Documentation/devicetree/bindings/input/ps2keyb-mouse-apbps2.txt" for
+ * information on open firmware properties.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Contributors: Daniel Hellstrom <daniel@gaisler.com>
+ */
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+struct apbps2_regs {
+	u32 __iomem data;	/* 0x00 */
+	u32 __iomem status;	/* 0x04 */
+	u32 __iomem ctrl;	/* 0x08 */
+	u32 __iomem reload;	/* 0x0c */
+};
+
+#define APBPS2_STATUS_DR	(1<<0)
+#define APBPS2_STATUS_PE	(1<<1)
+#define APBPS2_STATUS_FE	(1<<2)
+#define APBPS2_STATUS_KI	(1<<3)
+#define APBPS2_STATUS_RF	(1<<4)
+#define APBPS2_STATUS_TF	(1<<5)
+#define APBPS2_STATUS_TCNT	(0x1f<<22)
+#define APBPS2_STATUS_RCNT	(0x1f<<27)
+
+#define APBPS2_CTRL_RE		(1<<0)
+#define APBPS2_CTRL_TE		(1<<1)
+#define APBPS2_CTRL_RI		(1<<2)
+#define APBPS2_CTRL_TI		(1<<3)
+
+struct apbps2_priv {
+	struct serio		*io;
+	struct apbps2_regs	*regs;
+};
+
+static int apbps2_idx;
+
+static irqreturn_t apbps2_isr(int irq, void *dev_id)
+{
+	struct apbps2_priv *priv = dev_id;
+	unsigned long status, data, rxflags;
+	irqreturn_t ret = IRQ_NONE;
+
+	while ((status = ioread32be(&priv->regs->status)) & APBPS2_STATUS_DR) {
+		data = ioread32be(&priv->regs->data);
+		rxflags = (status & APBPS2_STATUS_PE) ? SERIO_PARITY : 0;
+		rxflags |= (status & APBPS2_STATUS_FE) ? SERIO_FRAME : 0;
+
+		/* clear error bits? */
+		if (rxflags)
+			iowrite32be(0, &priv->regs->status);
+
+		serio_interrupt(priv->io, data, rxflags);
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static int apbps2_write(struct serio *io, unsigned char val)
+{
+	struct apbps2_priv *priv = io->port_data;
+	unsigned int tleft = 10000; /* timeout in 100ms */
+
+	/* delay until PS/2 controller has room for more chars */
+	while ((ioread32be(&priv->regs->status) & APBPS2_STATUS_TF) && tleft--)
+		udelay(10);
+
+	if ((ioread32be(&priv->regs->status) & APBPS2_STATUS_TF) == 0) {
+		iowrite32be(val, &priv->regs->data);
+
+		iowrite32be(APBPS2_CTRL_RE | APBPS2_CTRL_RI | APBPS2_CTRL_TE,
+				&priv->regs->ctrl);
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int apbps2_open(struct serio *io)
+{
+	struct apbps2_priv *priv = io->port_data;
+	int limit;
+	unsigned long tmp;
+
+	/* clear error flags */
+	iowrite32be(0, &priv->regs->status);
+
+	/* Clear old data if available (unlikely) */
+	limit = 1024;
+	while ((ioread32be(&priv->regs->status) & APBPS2_STATUS_DR) && --limit)
+		tmp = ioread32be(&priv->regs->data);
+
+	/* Enable reciever and it's interrupt */
+	iowrite32be(APBPS2_CTRL_RE | APBPS2_CTRL_RI, &priv->regs->ctrl);
+
+	return 0;
+}
+
+static void apbps2_close(struct serio *io)
+{
+	struct apbps2_priv *priv = io->port_data;
+
+	/* stop interrupts at PS/2 HW level */
+	iowrite32be(0, &priv->regs->ctrl);
+}
+
+/* Initialize one APBPS2 PS/2 core */
+static int apbps2_of_probe(struct platform_device *ofdev)
+{
+	struct apbps2_priv *priv;
+	int irq, err;
+	u32 freq_hz;
+	struct resource *res;
+
+	priv = devm_kzalloc(&ofdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&ofdev->dev, "memory allocation failed\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(ofdev, priv);
+
+	/* Find Device Address */
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_request_and_ioremap(&ofdev->dev, res);
+	if (!priv->regs) {
+		dev_err(&ofdev->dev, "io-regs mapping failed\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	/* Reset hardware, disable interrupt */
+	iowrite32be(0, &priv->regs->ctrl);
+
+	/* IRQ */
+	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	err = devm_request_irq(&ofdev->dev, irq, apbps2_isr, IRQF_SHARED,
+							"apbps2", priv);
+	if (err) {
+		dev_err(&ofdev->dev, "request IRQ%d failed\n", irq);
+		return err;
+	}
+
+	/* Get core frequency */
+	if (of_property_read_u32(ofdev->dev.of_node, "freq", &freq_hz)) {
+		dev_err(&ofdev->dev, "unable to get core frequency\n");
+		return -EINVAL;
+	}
+
+	/* Set reload register to core freq in kHz/10 */
+	iowrite32be(freq_hz / 10000, &priv->regs->reload);
+
+	priv->io = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!priv->io)
+		return -ENOMEM;
+
+	priv->io->id.type = SERIO_8042;
+	priv->io->open = apbps2_open;
+	priv->io->close = apbps2_close;
+	priv->io->write = apbps2_write;
+	priv->io->port_data = priv;
+	strlcpy(priv->io->name, "APBPS2 PS/2", sizeof(priv->io->name));
+	snprintf(priv->io->phys, sizeof(priv->io->phys), "apbps2_%d",
+								apbps2_idx++);
+
+	dev_info(&ofdev->dev, "irq = %d, base = 0x%p\n", irq, priv->regs);
+
+	serio_register_port(priv->io);
+
+	return 0;
+}
+
+static int apbps2_of_remove(struct platform_device *of_dev)
+{
+	struct apbps2_priv *priv = platform_get_drvdata(of_dev);
+
+	serio_unregister_port(priv->io);
+
+	return 0;
+}
+
+static struct of_device_id apbps2_of_match[] = {
+	{
+	 .name = "GAISLER_APBPS2",
+	 },
+	{
+	 .name = "01_060",
+	 },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, apbps2_of_match);
+
+static struct platform_driver apbps2_of_driver = {
+	.driver = {
+		.name = "grlib-apbps2",
+		.owner = THIS_MODULE,
+		.of_match_table = apbps2_of_match,
+	},
+	.probe = apbps2_of_probe,
+	.remove = apbps2_of_remove,
+};
+
+module_platform_driver(apbps2_of_driver);
+
+MODULE_AUTHOR("Aeroflex Gaisler AB.");
+MODULE_DESCRIPTION("GRLIB APBPS2 PS/2 serial I/O");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

