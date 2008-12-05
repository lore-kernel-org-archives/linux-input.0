From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/3] input: add support for trackball on pxa930 and pxa935
Date: Fri, 5 Dec 2008 10:12:24 +0800
Message-ID: <f17812d70812041812t4d7eb8cs3f4d7f51139d252a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_17785_4873579.1228443144543"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:52284 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbYLECM0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2008 21:12:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4264674rvb.1
        for <linux-input@vger.kernel.org>; Thu, 04 Dec 2008 18:12:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, yaoyong@marvell.com

------=_Part_17785_4873579.1228443144543
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>From d8cf75a5bf259404b0e51d5da153e42cb9aaf2d0 Mon Sep 17 00:00:00 2001
From: Yong Yao <yaoyong@marvell.com>
Date: Thu, 4 Dec 2008 14:50:02 +0800
Subject: [PATCH] input: add support for trackball on pxa930 and pxa935

Signed-off-by: Yong Yao <yaoyong@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/pxa930_trkball.h |   10 +
 drivers/input/mouse/Kconfig                     |    6 +
 drivers/input/mouse/Makefile                    |    2 +
 drivers/input/mouse/pxa930_trkball.c            |  276 +++++++++++++++++++++++
 4 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa930_trkball.h
 create mode 100644 drivers/input/mouse/pxa930_trkball.c

diff --git a/arch/arm/mach-pxa/include/mach/pxa930_trkball.h
b/arch/arm/mach-pxa/include/mach/pxa930_trkball.h
new file mode 100644
index 0000000..5e0789b
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/pxa930_trkball.h
@@ -0,0 +1,10 @@
+#ifndef __ASM_ARCH_PXA930_TRKBALL_H
+#define __ASM_ARCH_PXA930_TRKBALL_H
+
+struct pxa930_trkball_platform_data {
+	int x_filter;
+	int y_filter;
+};
+
+#endif /* __ASM_ARCH_PXA930_TRKBALL_H */
+
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 4e99342..093c8c1 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -286,4 +286,10 @@ config MOUSE_GPIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio_mouse.

+config MOUSE_PXA930_TRKBALL
+	tristate "PXA930 Trackball mouse"
+	depends on CPU_PXA930 || CPU_PXA935
+	help
+	  Say Y here to support PXA930 Trackball mouse.
+
 endif
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 96f1dd8..da6998c 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 obj-$(CONFIG_MOUSE_GPIO)	+= gpio_mouse.o

+obj-$(CONFIG_MOUSE_PXA930_TRKBALL)	+= pxa930_trkball.o
+
 psmouse-objs := psmouse-base.o synaptics.o

 psmouse-$(CONFIG_MOUSE_PS2_ALPS)	+= alps.o
diff --git a/drivers/input/mouse/pxa930_trkball.c
b/drivers/input/mouse/pxa930_trkball.c
new file mode 100644
index 0000000..9d6e799
--- /dev/null
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -0,0 +1,276 @@
+/*
+ * linux/driver/input/mouse/pxa930_trkball.c
+ *
+ * PXA930 track ball mouse driver
+ *
+ * Copyright (C) 2007 Marvell International Ltd.
+ * 2008-02-28: Yong Yao <yaoyong@marvell.com>
+ *             initial version
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/version.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/pxa930_trkball.h>
+
+/* Trackball Controller Register Definitions */
+#define TBCR		(0x000C)
+#define TBCNTR		(0x0010)
+#define TBSBC		(0x0014)
+
+#define TBCR_TBRST	(1 << 1)
+#define TBCR_TBSB	(1 << 10)
+
+#define TBCR_Y_FLT(n)	(((n) & 0xf) << 6)
+#define TBCR_X_FLT(n)	(((n) & 0xf) << 2)
+
+#define TBCNTR_YM(n)	(((n) >> 24) & 0xff)
+#define TBCNTR_YP(n)	(((n) >> 16) & 0xff)
+#define TBCNTR_XM(n)	(((n) >> 8) & 0xff)
+#define TBCNTR_XP(n)	((n) & 0xff)
+
+#define TBSBC_TBSBC	(0x1)
+
+struct pxa930_trkball {
+	struct pxa930_trkball_platform_data *pdata;
+
+	/* Memory Mapped Register */
+	struct resource *mem;
+	void __iomem *mmio_base;
+
+	struct input_dev *input;
+};
+
+static irqreturn_t pxa930_trkball_interrupt(int irq, void *dev_id)
+{
+	struct pxa930_trkball *trkball = dev_id;
+	struct input_dev *input = trkball->input;
+	int tbcntr, x, y;
+
+	/* According to the spec software must read TBCNTR twice:
+	 * if the read value is the same, the reading is valid
+	 */
+	tbcntr = __raw_readl(trkball->mmio_base + TBCNTR);
+
+	if (tbcntr == __raw_readl(trkball->mmio_base + TBCNTR)) {
+		x = (TBCNTR_XP(tbcntr) - TBCNTR_XM(tbcntr)) / 2;
+		y = (TBCNTR_YP(tbcntr) - TBCNTR_YM(tbcntr)) / 2;
+
+		input_report_rel(input, REL_X, x);
+		input_report_rel(input, REL_Y, y);
+		input_sync(input);
+	}
+
+	__raw_writel(TBSBC_TBSBC, trkball->mmio_base + TBSBC);
+	__raw_writel(0, trkball->mmio_base + TBSBC);
+
+	return IRQ_HANDLED;
+}
+
+/* For TBCR, we need to wait for a while to make sure it has been modified. */
+static int write_tbcr(struct pxa930_trkball *trkball, int v)
+{
+	int i = 100;
+
+	__raw_writel(v, trkball->mmio_base + TBCR);
+
+	while (i--) {
+		if (__raw_readl(trkball->mmio_base + TBCR) == v)
+			break;
+		msleep(1);
+	}
+
+	if (i == 0) {
+		pr_err("%s: timed out writing TBCR(%x)!\n", __func__, v);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static void pxa930_trkball_config(struct pxa930_trkball *trkball)
+{
+	uint32_t tbcr;
+
+	/* According to spec, need to write the filters of x,y to 0xf first! */
+	tbcr = __raw_readl(trkball->mmio_base + TBCR);
+	write_tbcr(trkball, tbcr | TBCR_X_FLT(0xf) | TBCR_Y_FLT(0xf));
+	write_tbcr(trkball, TBCR_X_FLT(trkball->pdata->x_filter) |
+			    TBCR_Y_FLT(trkball->pdata->y_filter));
+
+	/* According to spec, set TBCR_TBRST first, before clearing it! */
+	tbcr = __raw_readl(trkball->mmio_base + TBCR);
+	write_tbcr(trkball, tbcr | TBCR_TBRST);
+	write_tbcr(trkball, tbcr & ~TBCR_TBRST);
+
+	__raw_writel(TBSBC_TBSBC, trkball->mmio_base + TBSBC);
+	__raw_writel(0, trkball->mmio_base + TBSBC);
+
+	pr_debug("%s: final TBCR=%x!\n", __func__,
+		 __raw_readl(trkball->mmio_base + TBCR));
+}
+
+static int pxa930_trkball_open(struct input_dev *dev)
+{
+	struct pxa930_trkball *trkball = input_get_drvdata(dev);
+	pxa930_trkball_config(trkball);
+	return 0;
+}
+
+static void pxa930_trkball_disable(struct pxa930_trkball *trkball)
+{
+	uint32_t tbcr = __raw_readl(trkball->mmio_base + TBCR);
+
+	/* Held in reset, gate the 32-KHz input clock off */
+	write_tbcr(trkball, tbcr | TBCR_TBRST);
+}
+
+static void pxa930_trkball_close(struct input_dev *dev)
+{
+	struct pxa930_trkball *trkball = input_get_drvdata(dev);
+	pxa930_trkball_disable(trkball);
+}
+
+static int __init pxa930_trkball_probe(struct platform_device *pdev)
+{
+	struct pxa930_trkball *trkball;
+	struct input_dev *input;
+	struct resource *res;
+	int irq, ret = -EINVAL;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get trkball irq\n");
+		return -ENXIO;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to get register memory\n");
+		return -ENXIO;
+	}
+
+	trkball = kzalloc(sizeof(struct pxa930_trkball), GFP_KERNEL);
+	if (!trkball)
+		return -ENOMEM;
+
+	trkball->pdata = pdev->dev.platform_data;
+	if (trkball->pdata == NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	trkball->mmio_base = ioremap_nocache(res->start, resource_size(res));
+	if (trkball->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to ioremap registers\n");
+		ret = -ENXIO;
+		goto failed;
+	}
+
+	/* held the module in reset, will be enabled in open() */
+	pxa930_trkball_disable(trkball);
+
+	ret = request_irq(irq, pxa930_trkball_interrupt, IRQF_DISABLED,
+			pdev->name, trkball);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
+		goto failed_free_io;
+	}
+
+	platform_set_drvdata(pdev, trkball);
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		ret = -ENOMEM;
+		goto failed_free_irq;
+	}
+
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->open = pxa930_trkball_open;
+	input->close = pxa930_trkball_close;
+	input->dev.parent = &pdev->dev;
+	input_set_drvdata(input, trkball);
+
+	trkball->input = input;
+
+	input_set_capability(input, EV_REL, REL_X);
+	input_set_capability(input, EV_REL, REL_Y);
+
+	set_bit(REL_X, input->relbit);
+	set_bit(REL_Y, input->relbit);
+	set_bit(BTN_MOUSE, input->keybit);
+	set_bit(EV_SYN, input->evbit);
+	set_bit(EV_REL, input->evbit);
+
+	ret = input_register_device(input);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to register input device\n");
+		input_free_device(input);
+		goto failed_free_input;
+	}
+
+	return 0;
+
+failed_free_input:
+	input_free_device(input);
+failed_free_irq:
+	free_irq(irq, trkball);
+failed_free_io:
+	iounmap(trkball->mmio_base);
+failed:
+	kfree(trkball);
+	return ret;
+}
+
+static int __devexit pxa930_trkball_remove(struct platform_device *pdev)
+{
+	struct pxa930_trkball *trkball = platform_get_drvdata(pdev);
+	int irq;
+
+	input_unregister_device(trkball->input);
+
+	irq = platform_get_irq(pdev, 0);
+	free_irq(irq, trkball);
+
+	iounmap(trkball->mmio_base);
+	kfree(trkball);
+	return 0;
+}
+
+static struct platform_driver pxa930_trkball_driver = {
+	.driver		= {
+		.name	= "pxa930-trkball",
+	},
+	.probe		= pxa930_trkball_probe,
+	.remove		= __devexit_p(pxa930_trkball_remove),
+};
+
+static int __init pxa930_trkball_init(void)
+{
+	return platform_driver_register(&pxa930_trkball_driver);
+}
+
+static void __exit pxa930_trkball_exit(void)
+{
+	platform_driver_unregister(&pxa930_trkball_driver);
+}
+
+module_init(pxa930_trkball_init);
+module_exit(pxa930_trkball_exit);
+
+MODULE_AUTHOR("Yong Yao <yaoyong@marvell.com>");
+MODULE_DESCRIPTION("PXA930 Trackball Mouse Driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.4

------=_Part_17785_4873579.1228443144543
Content-Type: text/x-diff;
 name=0002-input-add-support-for-trackball-on-pxa930-and-pxa93.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_foc7ay400
Content-Disposition: attachment;
 filename=0002-input-add-support-for-trackball-on-pxa930-and-pxa93.patch

RnJvbSBkOGNmNzVhNWJmMjU5NDA0YjBlNTFkNWRhMTUzZTQyY2I5YWFmMmQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nIFlhbyA8eWFveW9uZ0BtYXJ2ZWxsLmNvbT4KRGF0ZTog
VGh1LCA0IERlYyAyMDA4IDE0OjUwOjAyICswODAwClN1YmplY3Q6IFtQQVRDSF0gaW5wdXQ6IGFk
ZCBzdXBwb3J0IGZvciB0cmFja2JhbGwgb24gcHhhOTMwIGFuZCBweGE5MzUKClNpZ25lZC1vZmYt
Ynk6IFlvbmcgWWFvIDx5YW95b25nQG1hcnZlbGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBFcmljIE1p
YW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRl
L21hY2gvcHhhOTMwX3Rya2JhbGwuaCB8ICAgMTAgKwogZHJpdmVycy9pbnB1dC9tb3VzZS9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsKIGRyaXZlcnMvaW5wdXQvbW91c2UvTWFr
ZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAgMiArCiBkcml2ZXJzL2lucHV0L21vdXNlL3B4
YTkzMF90cmtiYWxsLmMgICAgICAgICAgICB8ICAyNzYgKysrKysrKysrKysrKysrKysrKysrKysK
IDQgZmlsZXMgY2hhbmdlZCwgMjk0IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3B4YTkzMF90cmti
YWxsLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L21vdXNlL3B4YTkzMF90cmti
YWxsLmMKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvcHhhOTMw
X3Rya2JhbGwuaCBiL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9weGE5MzBfdHJrYmFs
bC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjVlMDc4OWIKLS0tIC9kZXYv
bnVsbAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvcHhhOTMwX3Rya2JhbGwu
aApAQCAtMCwwICsxLDEwIEBACisjaWZuZGVmIF9fQVNNX0FSQ0hfUFhBOTMwX1RSS0JBTExfSAor
I2RlZmluZSBfX0FTTV9BUkNIX1BYQTkzMF9UUktCQUxMX0gKKworc3RydWN0IHB4YTkzMF90cmti
YWxsX3BsYXRmb3JtX2RhdGEgeworCWludCB4X2ZpbHRlcjsKKwlpbnQgeV9maWx0ZXI7Cit9Owor
CisjZW5kaWYgLyogX19BU01fQVJDSF9QWEE5MzBfVFJLQkFMTF9IICovCisKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQvbW91c2UvS2NvbmZpZyBiL2RyaXZlcnMvaW5wdXQvbW91c2UvS2NvbmZp
ZwppbmRleCA0ZTk5MzQyLi4wOTNjOGMxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L21vdXNl
L0tjb25maWcKKysrIGIvZHJpdmVycy9pbnB1dC9tb3VzZS9LY29uZmlnCkBAIC0yODYsNCArMjg2
LDEwIEBAIGNvbmZpZyBNT1VTRV9HUElPCiAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEg
bW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUKIAkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBncGlv
X21vdXNlLgogCitjb25maWcgTU9VU0VfUFhBOTMwX1RSS0JBTEwKKwl0cmlzdGF0ZSAiUFhBOTMw
IFRyYWNrYmFsbCBtb3VzZSIKKwlkZXBlbmRzIG9uIENQVV9QWEE5MzAgfHwgQ1BVX1BYQTkzNQor
CWhlbHAKKwkgIFNheSBZIGhlcmUgdG8gc3VwcG9ydCBQWEE5MzAgVHJhY2tiYWxsIG1vdXNlLgor
CiBlbmRpZgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9tb3VzZS9NYWtlZmlsZSBiL2RyaXZl
cnMvaW5wdXQvbW91c2UvTWFrZWZpbGUKaW5kZXggOTZmMWRkOC4uZGE2OTk4YyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9pbnB1dC9tb3VzZS9NYWtlZmlsZQorKysgYi9kcml2ZXJzL2lucHV0L21vdXNl
L01ha2VmaWxlCkBAIC0xOCw2ICsxOCw4IEBAIG9iai0kKENPTkZJR19NT1VTRV9ISUwpCQkrPSBo
aWxfcHRyLm8KIG9iai0kKENPTkZJR19NT1VTRV9WU1hYWEFBKQkrPSB2c3h4eGFhLm8KIG9iai0k
KENPTkZJR19NT1VTRV9HUElPKQkrPSBncGlvX21vdXNlLm8KIAorb2JqLSQoQ09ORklHX01PVVNF
X1BYQTkzMF9UUktCQUxMKQkrPSBweGE5MzBfdHJrYmFsbC5vCisKIHBzbW91c2Utb2JqcyA6PSBw
c21vdXNlLWJhc2UubyBzeW5hcHRpY3MubwogCiBwc21vdXNlLSQoQ09ORklHX01PVVNFX1BTMl9B
TFBTKQkrPSBhbHBzLm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbW91c2UvcHhhOTMwX3Ry
a2JhbGwuYyBiL2RyaXZlcnMvaW5wdXQvbW91c2UvcHhhOTMwX3Rya2JhbGwuYwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi45ZDZlNzk5Ci0tLSAvZGV2L251bGwKKysrIGIvZHJp
dmVycy9pbnB1dC9tb3VzZS9weGE5MzBfdHJrYmFsbC5jCkBAIC0wLDAgKzEsMjc2IEBACisvKgor
ICogbGludXgvZHJpdmVyL2lucHV0L21vdXNlL3B4YTkzMF90cmtiYWxsLmMKKyAqCisgKiBQWEE5
MzAgdHJhY2sgYmFsbCBtb3VzZSBkcml2ZXIKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDcgTWFy
dmVsbCBJbnRlcm5hdGlvbmFsIEx0ZC4KKyAqIDIwMDgtMDItMjg6IFlvbmcgWWFvIDx5YW95b25n
QG1hcnZlbGwuY29tPgorICogICAgICAgICAgICAgaW5pdGlhbCB2ZXJzaW9uCisgKgorICogIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqICBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbi4KKyAqLworCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUg
PGxpbnV4L2lucHV0Lmg+CisjaW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPgorI2luY2x1ZGUgPGxp
bnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVk
ZSA8bGludXgvaW8uaD4KKworI2luY2x1ZGUgPG1hY2gvaGFyZHdhcmUuaD4KKyNpbmNsdWRlIDxt
YWNoL3B4YTkzMF90cmtiYWxsLmg+CisKKy8qIFRyYWNrYmFsbCBDb250cm9sbGVyIFJlZ2lzdGVy
IERlZmluaXRpb25zICovCisjZGVmaW5lIFRCQ1IJCSgweDAwMEMpCisjZGVmaW5lIFRCQ05UUgkJ
KDB4MDAxMCkKKyNkZWZpbmUgVEJTQkMJCSgweDAwMTQpCisKKyNkZWZpbmUgVEJDUl9UQlJTVAko
MSA8PCAxKQorI2RlZmluZSBUQkNSX1RCU0IJKDEgPDwgMTApCisKKyNkZWZpbmUgVEJDUl9ZX0ZM
VChuKQkoKChuKSAmIDB4ZikgPDwgNikKKyNkZWZpbmUgVEJDUl9YX0ZMVChuKQkoKChuKSAmIDB4
ZikgPDwgMikKKworI2RlZmluZSBUQkNOVFJfWU0obikJKCgobikgPj4gMjQpICYgMHhmZikKKyNk
ZWZpbmUgVEJDTlRSX1lQKG4pCSgoKG4pID4+IDE2KSAmIDB4ZmYpCisjZGVmaW5lIFRCQ05UUl9Y
TShuKQkoKChuKSA+PiA4KSAmIDB4ZmYpCisjZGVmaW5lIFRCQ05UUl9YUChuKQkoKG4pICYgMHhm
ZikKKworI2RlZmluZSBUQlNCQ19UQlNCQwkoMHgxKQorCitzdHJ1Y3QgcHhhOTMwX3Rya2JhbGwg
eworCXN0cnVjdCBweGE5MzBfdHJrYmFsbF9wbGF0Zm9ybV9kYXRhICpwZGF0YTsKKworCS8qIE1l
bW9yeSBNYXBwZWQgUmVnaXN0ZXIgKi8KKwlzdHJ1Y3QgcmVzb3VyY2UgKm1lbTsKKwl2b2lkIF9f
aW9tZW0gKm1taW9fYmFzZTsKKworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0OworfTsKKworc3Rh
dGljIGlycXJldHVybl90IHB4YTkzMF90cmtiYWxsX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpk
ZXZfaWQpCit7CisJc3RydWN0IHB4YTkzMF90cmtiYWxsICp0cmtiYWxsID0gZGV2X2lkOworCXN0
cnVjdCBpbnB1dF9kZXYgKmlucHV0ID0gdHJrYmFsbC0+aW5wdXQ7CisJaW50IHRiY250ciwgeCwg
eTsKKworCS8qIEFjY29yZGluZyB0byB0aGUgc3BlYyBzb2Z0d2FyZSBtdXN0IHJlYWQgVEJDTlRS
IHR3aWNlOgorCSAqIGlmIHRoZSByZWFkIHZhbHVlIGlzIHRoZSBzYW1lLCB0aGUgcmVhZGluZyBp
cyB2YWxpZAorCSAqLworCXRiY250ciA9IF9fcmF3X3JlYWRsKHRya2JhbGwtPm1taW9fYmFzZSAr
IFRCQ05UUik7CisKKwlpZiAodGJjbnRyID09IF9fcmF3X3JlYWRsKHRya2JhbGwtPm1taW9fYmFz
ZSArIFRCQ05UUikpIHsKKwkJeCA9IChUQkNOVFJfWFAodGJjbnRyKSAtIFRCQ05UUl9YTSh0YmNu
dHIpKSAvIDI7CisJCXkgPSAoVEJDTlRSX1lQKHRiY250cikgLSBUQkNOVFJfWU0odGJjbnRyKSkg
LyAyOworCisJCWlucHV0X3JlcG9ydF9yZWwoaW5wdXQsIFJFTF9YLCB4KTsKKwkJaW5wdXRfcmVw
b3J0X3JlbChpbnB1dCwgUkVMX1ksIHkpOworCQlpbnB1dF9zeW5jKGlucHV0KTsKKwl9CisKKwlf
X3Jhd193cml0ZWwoVEJTQkNfVEJTQkMsIHRya2JhbGwtPm1taW9fYmFzZSArIFRCU0JDKTsKKwlf
X3Jhd193cml0ZWwoMCwgdHJrYmFsbC0+bW1pb19iYXNlICsgVEJTQkMpOworCisJcmV0dXJuIElS
UV9IQU5ETEVEOworfQorCisvKiBGb3IgVEJDUiwgd2UgbmVlZCB0byB3YWl0IGZvciBhIHdoaWxl
IHRvIG1ha2Ugc3VyZSBpdCBoYXMgYmVlbiBtb2RpZmllZC4gKi8KK3N0YXRpYyBpbnQgd3JpdGVf
dGJjcihzdHJ1Y3QgcHhhOTMwX3Rya2JhbGwgKnRya2JhbGwsIGludCB2KQoreworCWludCBpID0g
MTAwOworCisJX19yYXdfd3JpdGVsKHYsIHRya2JhbGwtPm1taW9fYmFzZSArIFRCQ1IpOworCisJ
d2hpbGUgKGktLSkgeworCQlpZiAoX19yYXdfcmVhZGwodHJrYmFsbC0+bW1pb19iYXNlICsgVEJD
UikgPT0gdikKKwkJCWJyZWFrOworCQltc2xlZXAoMSk7CisJfQorCisJaWYgKGkgPT0gMCkgewor
CQlwcl9lcnIoIiVzOiB0aW1lZCBvdXQgd3JpdGluZyBUQkNSKCV4KSFcbiIsIF9fZnVuY19fLCB2
KTsKKwkJcmV0dXJuIC1FVElNRURPVVQ7CisJfQorCXJldHVybiAwOworfQorCitzdGF0aWMgdm9p
ZCBweGE5MzBfdHJrYmFsbF9jb25maWcoc3RydWN0IHB4YTkzMF90cmtiYWxsICp0cmtiYWxsKQor
eworCXVpbnQzMl90IHRiY3I7CisKKwkvKiBBY2NvcmRpbmcgdG8gc3BlYywgbmVlZCB0byB3cml0
ZSB0aGUgZmlsdGVycyBvZiB4LHkgdG8gMHhmIGZpcnN0ISAqLworCXRiY3IgPSBfX3Jhd19yZWFk
bCh0cmtiYWxsLT5tbWlvX2Jhc2UgKyBUQkNSKTsKKwl3cml0ZV90YmNyKHRya2JhbGwsIHRiY3Ig
fCBUQkNSX1hfRkxUKDB4ZikgfCBUQkNSX1lfRkxUKDB4ZikpOworCXdyaXRlX3RiY3IodHJrYmFs
bCwgVEJDUl9YX0ZMVCh0cmtiYWxsLT5wZGF0YS0+eF9maWx0ZXIpIHwKKwkJCSAgICBUQkNSX1lf
RkxUKHRya2JhbGwtPnBkYXRhLT55X2ZpbHRlcikpOworCisJLyogQWNjb3JkaW5nIHRvIHNwZWMs
IHNldCBUQkNSX1RCUlNUIGZpcnN0LCBiZWZvcmUgY2xlYXJpbmcgaXQhICovCisJdGJjciA9IF9f
cmF3X3JlYWRsKHRya2JhbGwtPm1taW9fYmFzZSArIFRCQ1IpOworCXdyaXRlX3RiY3IodHJrYmFs
bCwgdGJjciB8IFRCQ1JfVEJSU1QpOworCXdyaXRlX3RiY3IodHJrYmFsbCwgdGJjciAmIH5UQkNS
X1RCUlNUKTsKKworCV9fcmF3X3dyaXRlbChUQlNCQ19UQlNCQywgdHJrYmFsbC0+bW1pb19iYXNl
ICsgVEJTQkMpOworCV9fcmF3X3dyaXRlbCgwLCB0cmtiYWxsLT5tbWlvX2Jhc2UgKyBUQlNCQyk7
CisKKwlwcl9kZWJ1ZygiJXM6IGZpbmFsIFRCQ1I9JXghXG4iLCBfX2Z1bmNfXywKKwkJIF9fcmF3
X3JlYWRsKHRya2JhbGwtPm1taW9fYmFzZSArIFRCQ1IpKTsKK30KKworc3RhdGljIGludCBweGE5
MzBfdHJrYmFsbF9vcGVuKHN0cnVjdCBpbnB1dF9kZXYgKmRldikKK3sKKwlzdHJ1Y3QgcHhhOTMw
X3Rya2JhbGwgKnRya2JhbGwgPSBpbnB1dF9nZXRfZHJ2ZGF0YShkZXYpOworCXB4YTkzMF90cmti
YWxsX2NvbmZpZyh0cmtiYWxsKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgcHhhOTMw
X3Rya2JhbGxfZGlzYWJsZShzdHJ1Y3QgcHhhOTMwX3Rya2JhbGwgKnRya2JhbGwpCit7CisJdWlu
dDMyX3QgdGJjciA9IF9fcmF3X3JlYWRsKHRya2JhbGwtPm1taW9fYmFzZSArIFRCQ1IpOworCisJ
LyogSGVsZCBpbiByZXNldCwgZ2F0ZSB0aGUgMzItS0h6IGlucHV0IGNsb2NrIG9mZiAqLworCXdy
aXRlX3RiY3IodHJrYmFsbCwgdGJjciB8IFRCQ1JfVEJSU1QpOworfQorCitzdGF0aWMgdm9pZCBw
eGE5MzBfdHJrYmFsbF9jbG9zZShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpCit7CisJc3RydWN0IHB4
YTkzMF90cmtiYWxsICp0cmtiYWxsID0gaW5wdXRfZ2V0X2RydmRhdGEoZGV2KTsKKwlweGE5MzBf
dHJrYmFsbF9kaXNhYmxlKHRya2JhbGwpOworfQorCitzdGF0aWMgaW50IF9faW5pdCBweGE5MzBf
dHJrYmFsbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBw
eGE5MzBfdHJrYmFsbCAqdHJrYmFsbDsKKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dDsKKwlzdHJ1
Y3QgcmVzb3VyY2UgKnJlczsKKwlpbnQgaXJxLCByZXQgPSAtRUlOVkFMOworCisJaXJxID0gcGxh
dGZvcm1fZ2V0X2lycShwZGV2LCAwKTsKKwlpZiAoaXJxIDwgMCkgeworCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJmYWlsZWQgdG8gZ2V0IHRya2JhbGwgaXJxXG4iKTsKKwkJcmV0dXJuIC1FTlhJTzsK
Kwl9CisKKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOworCWlmIChyZXMgPT0gTlVMTCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQg
dG8gZ2V0IHJlZ2lzdGVyIG1lbW9yeVxuIik7CisJCXJldHVybiAtRU5YSU87CisJfQorCisJdHJr
YmFsbCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBweGE5MzBfdHJrYmFsbCksIEdGUF9LRVJORUwp
OworCWlmICghdHJrYmFsbCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwl0cmtiYWxsLT5wZGF0YSA9
IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOworCWlmICh0cmtiYWxsLT5wZGF0YSA9PSBOVUxMKSB7
CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIHBsYXRmb3JtIGRhdGEgZGVmaW5lZFxuIik7CisJ
CXJldCA9IC1FSU5WQUw7CisJCWdvdG8gZmFpbGVkOworCX0KKworCXRya2JhbGwtPm1taW9fYmFz
ZSA9IGlvcmVtYXBfbm9jYWNoZShyZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcykpOworCWlm
ICh0cmtiYWxsLT5tbWlvX2Jhc2UgPT0gTlVMTCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gaW9yZW1hcCByZWdpc3RlcnNcbiIpOworCQlyZXQgPSAtRU5YSU87CisJCWdvdG8g
ZmFpbGVkOworCX0KKworCS8qIGhlbGQgdGhlIG1vZHVsZSBpbiByZXNldCwgd2lsbCBiZSBlbmFi
bGVkIGluIG9wZW4oKSAqLworCXB4YTkzMF90cmtiYWxsX2Rpc2FibGUodHJrYmFsbCk7CisKKwly
ZXQgPSByZXF1ZXN0X2lycShpcnEsIHB4YTkzMF90cmtiYWxsX2ludGVycnVwdCwgSVJRRl9ESVNB
QkxFRCwKKwkJCXBkZXYtPm5hbWUsIHRya2JhbGwpOworCWlmIChyZXQpIHsKKwkJZGV2X2Vycigm
cGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgaXJxOiAlZFxuIiwgcmV0KTsKKwkJZ290byBm
YWlsZWRfZnJlZV9pbzsKKwl9CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCB0cmtiYWxs
KTsKKworCWlucHV0ID0gaW5wdXRfYWxsb2NhdGVfZGV2aWNlKCk7CisJaWYgKCFpbnB1dCkgewor
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gYWxsb2NhdGUgaW5wdXQgZGV2aWNlXG4i
KTsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBmYWlsZWRfZnJlZV9pcnE7CisJfQorCisJaW5w
dXQtPm5hbWUgPSBwZGV2LT5uYW1lOworCWlucHV0LT5pZC5idXN0eXBlID0gQlVTX0hPU1Q7CisJ
aW5wdXQtPm9wZW4gPSBweGE5MzBfdHJrYmFsbF9vcGVuOworCWlucHV0LT5jbG9zZSA9IHB4YTkz
MF90cmtiYWxsX2Nsb3NlOworCWlucHV0LT5kZXYucGFyZW50ID0gJnBkZXYtPmRldjsKKwlpbnB1
dF9zZXRfZHJ2ZGF0YShpbnB1dCwgdHJrYmFsbCk7CisKKwl0cmtiYWxsLT5pbnB1dCA9IGlucHV0
OworCisJaW5wdXRfc2V0X2NhcGFiaWxpdHkoaW5wdXQsIEVWX1JFTCwgUkVMX1gpOworCWlucHV0
X3NldF9jYXBhYmlsaXR5KGlucHV0LCBFVl9SRUwsIFJFTF9ZKTsKKworCXNldF9iaXQoUkVMX1gs
IGlucHV0LT5yZWxiaXQpOworCXNldF9iaXQoUkVMX1ksIGlucHV0LT5yZWxiaXQpOworCXNldF9i
aXQoQlROX01PVVNFLCBpbnB1dC0+a2V5Yml0KTsKKwlzZXRfYml0KEVWX1NZTiwgaW5wdXQtPmV2
Yml0KTsKKwlzZXRfYml0KEVWX1JFTCwgaW5wdXQtPmV2Yml0KTsKKworCXJldCA9IGlucHV0X3Jl
Z2lzdGVyX2RldmljZShpbnB1dCk7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2VycigmcGRldi0+
ZGV2LCAidW5hYmxlIHRvIHJlZ2lzdGVyIGlucHV0IGRldmljZVxuIik7CisJCWlucHV0X2ZyZWVf
ZGV2aWNlKGlucHV0KTsKKwkJZ290byBmYWlsZWRfZnJlZV9pbnB1dDsKKwl9CisKKwlyZXR1cm4g
MDsKKworZmFpbGVkX2ZyZWVfaW5wdXQ6CisJaW5wdXRfZnJlZV9kZXZpY2UoaW5wdXQpOworZmFp
bGVkX2ZyZWVfaXJxOgorCWZyZWVfaXJxKGlycSwgdHJrYmFsbCk7CitmYWlsZWRfZnJlZV9pbzoK
Kwlpb3VubWFwKHRya2JhbGwtPm1taW9fYmFzZSk7CitmYWlsZWQ6CisJa2ZyZWUodHJrYmFsbCk7
CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBfX2RldmV4aXQgcHhhOTMwX3Rya2JhbGxf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IHB4YTkzMF90
cmtiYWxsICp0cmtiYWxsID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisJaW50IGlycTsK
KworCWlucHV0X3VucmVnaXN0ZXJfZGV2aWNlKHRya2JhbGwtPmlucHV0KTsKKworCWlycSA9IHBs
YXRmb3JtX2dldF9pcnEocGRldiwgMCk7CisJZnJlZV9pcnEoaXJxLCB0cmtiYWxsKTsKKworCWlv
dW5tYXAodHJrYmFsbC0+bW1pb19iYXNlKTsKKwlrZnJlZSh0cmtiYWxsKTsKKwlyZXR1cm4gMDsK
K30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgcHhhOTMwX3Rya2JhbGxfZHJpdmVy
ID0geworCS5kcml2ZXIJCT0geworCQkubmFtZQk9ICJweGE5MzAtdHJrYmFsbCIsCisJfSwKKwku
cHJvYmUJCT0gcHhhOTMwX3Rya2JhbGxfcHJvYmUsCisJLnJlbW92ZQkJPSBfX2RldmV4aXRfcChw
eGE5MzBfdHJrYmFsbF9yZW1vdmUpLAorfTsKKworc3RhdGljIGludCBfX2luaXQgcHhhOTMwX3Ry
a2JhbGxfaW5pdCh2b2lkKQoreworCXJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnB4
YTkzMF90cmtiYWxsX2RyaXZlcik7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBweGE5MzBfdHJr
YmFsbF9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJnB4YTkzMF90
cmtiYWxsX2RyaXZlcik7Cit9CisKK21vZHVsZV9pbml0KHB4YTkzMF90cmtiYWxsX2luaXQpOwor
bW9kdWxlX2V4aXQocHhhOTMwX3Rya2JhbGxfZXhpdCk7CisKK01PRFVMRV9BVVRIT1IoIllvbmcg
WWFvIDx5YW95b25nQG1hcnZlbGwuY29tPiIpOworTU9EVUxFX0RFU0NSSVBUSU9OKCJQWEE5MzAg
VHJhY2tiYWxsIE1vdXNlIERyaXZlciIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwotLSAKMS42
LjAuNAoK
------=_Part_17785_4873579.1228443144543--
