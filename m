From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 3/3] input: add support for enhanced rotary controller on pxa930 and pxa935
Date: Fri, 5 Dec 2008 10:15:03 +0800
Message-ID: <f17812d70812041815t670a9f37w7fc4b6c12b303d1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_17833_4789889.1228443303636"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:57771 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbYLECPF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2008 21:15:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4265561rvb.1
        for <linux-input@vger.kernel.org>; Thu, 04 Dec 2008 18:15:03 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, yaoyong@marvell.com

------=_Part_17833_4789889.1228443303636
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>From 5f6693ed8d23a3ac37404358a6b1e0ba0889256a Mon Sep 17 00:00:00 2001
From: Yong Yao <yaoyong@marvell.com>
Date: Wed, 3 Dec 2008 13:40:08 +0800
Subject: [PATCH] input: add support for enhanced rotary controller on
pxa930 and pxa935

Signed-off-by: Yong Yao <yaoyong@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/pxa930_rotary.h |   21 +++
 drivers/input/keyboard/Kconfig                 |    9 +
 drivers/input/keyboard/Makefile                |    1 +
 drivers/input/keyboard/pxa930_rotary.c         |  212 ++++++++++++++++++++++++
 4 files changed, 243 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa930_rotary.h
 create mode 100644 drivers/input/keyboard/pxa930_rotary.c

diff --git a/arch/arm/mach-pxa/include/mach/pxa930_rotary.h
b/arch/arm/mach-pxa/include/mach/pxa930_rotary.h
new file mode 100644
index 0000000..cf92ac3
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/pxa930_rotary.h
@@ -0,0 +1,21 @@
+#ifndef __ASM_ARCH_PXA930_ROTARY_H
+#define __ASM_ARCH_PXA930_ROTARY_H
+
+#include <linux/input.h>
+
+/* NOTE:
+ *
+ * rotary can be either interpreted as a ralative input event (e.g.
+ * REL_WHEEL or REL_HWHEEL) or a specific key event (e.g. UP/DOWN
+ * or LEFT/RIGHT), depending on if up_key & down_key are assigned
+ * or rel_code is assigned a non-zero value. When all are non-zero,
+ * up_key and down_key will be preferred.
+ */
+struct pxa930_rotary_platform_data {
+	int	up_key;
+	int	down_key;
+	int	rel_code;
+};
+
+void __init pxa930_set_rotarykey_info(struct
pxa930_rotary_platform_data *info);
+#endif /* __ASM_ARCH_PXA930_ROTARY_H */
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index efd70a9..3556168 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -268,6 +268,15 @@ config KEYBOARD_PXA27x
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa27x_keypad.

+config KEYBOARD_PXA930_ROTARY
+	tristate "PXA930/PXA935 Enhanced Rotary Controller Support"
+	depends on CPU_PXA930 || CPU_PXA935
+	help
+	  Enable support for PXA930/PXA935 Enhanced Rotary Controller.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pxa930_rotary.
+
 config KEYBOARD_AAED2000
 	tristate "AAED-2000 keyboard"
 	depends on MACH_AAED2000
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 0edc8f2..36351e1 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
+obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
diff --git a/drivers/input/keyboard/pxa930_rotary.c
b/drivers/input/keyboard/pxa930_rotary.c
new file mode 100644
index 0000000..4846436
--- /dev/null
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -0,0 +1,212 @@
+/*
+ * linux/drivers/input/keyboard/pxa930_rotary.c
+ *
+ * Driver for the enhanced rotary controller on pxa930 and pxa935
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <mach/pxa930_rotary.h>
+
+#define SBCR	(0x04)
+#define ERCR	(0x0c)
+
+#define SBCR_ERSB	(1 << 5)
+
+struct pxa930_rotary {
+	struct input_dev	*input_dev;
+	void __iomem		*mmio_base;
+	int			last_ercr;
+
+	struct pxa930_rotary_platform_data *pdata;
+};
+
+static void clear_sbcr(struct pxa930_rotary *r)
+{
+	uint32_t sbcr = __raw_readl(r->mmio_base + SBCR);
+
+	__raw_writel(sbcr | SBCR_ERSB, r->mmio_base + SBCR);
+	__raw_writel(sbcr & ~SBCR_ERSB, r->mmio_base + SBCR);
+}
+
+static irqreturn_t rotary_irq(int irq, void *dev_id)
+{
+	struct pxa930_rotary *r = dev_id;
+	struct pxa930_rotary_platform_data *pdata = r->pdata;
+	int ercr, delta, key;
+
+	ercr = __raw_readl(r->mmio_base + ERCR) & 0xf;
+	clear_sbcr(r);
+
+	delta = ercr - r->last_ercr;
+	if (delta == 0)
+		return IRQ_HANDLED;
+
+	if (pdata->up_key && pdata->down_key) {
+		key = (delta > 0) ? pdata->up_key : pdata->down_key;
+		input_report_key(r->input_dev, key, 1);
+		input_report_key(r->input_dev, key, 0);
+	} else
+		input_report_rel(r->input_dev, pdata->rel_code, delta);
+
+	input_sync(r->input_dev);
+	r->last_ercr = ercr;
+
+	return IRQ_HANDLED;
+}
+
+static int pxa930_rotary_open(struct input_dev *dev)
+{
+	struct pxa930_rotary *r = input_get_drvdata(dev);
+
+	clear_sbcr(r);
+	return 0;
+}
+
+static void pxa930_rotary_close(struct input_dev *dev)
+{
+	struct pxa930_rotary *r = input_get_drvdata(dev);
+
+	clear_sbcr(r);
+}
+
+static int __devinit pxa930_rotary_probe(struct platform_device *pdev)
+{
+	struct pxa930_rotary_platform_data *pdata = pdev->dev.platform_data;
+	struct pxa930_rotary *r;
+	struct input_dev *input_dev;
+	struct resource *res;
+	int irq;
+	int err = -EINVAL;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq for rotary controller\n");
+		return -ENXIO;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no I/O memory defined\n");
+		return -ENXIO;
+	}
+
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	r = kzalloc(sizeof(struct pxa930_rotary), GFP_KERNEL);
+	if (r == NULL)
+		return -ENOMEM;
+
+	r->mmio_base = ioremap_nocache(res->start, resource_size(res));
+	if (r->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to remap IO memory\n");
+		err = -ENXIO;
+		goto failed_free;
+	}
+
+	r->pdata = pdata;
+	platform_set_drvdata(pdev, r);
+
+	/* allocate and register the input device */
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		err = -ENOMEM;
+		goto failed_free_io;
+	}
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->open = pxa930_rotary_open;
+	input_dev->close = pxa930_rotary_close;
+	input_dev->dev.parent = &pdev->dev;
+
+	if (pdata->up_key && pdata->down_key) {
+		set_bit(pdata->up_key, input_dev->keybit);
+		set_bit(pdata->down_key, input_dev->keybit);
+		input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	} else {
+		set_bit(pdata->rel_code, input_dev->relbit);
+		input_dev->evbit[0] = BIT_MASK(EV_REL);
+	}
+
+	r->input_dev = input_dev;
+	input_set_drvdata(input_dev, r);
+
+	err = request_irq(irq, rotary_irq, IRQF_DISABLED,
+			"enhanced rotary", r);
+	if (err) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto failed_free_input;
+	}
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto failed_free_irq;
+	}
+
+	return 0;
+
+failed_free_irq:
+	free_irq(irq, r);
+failed_free_input:
+	input_free_device(input_dev);
+failed_free_io:
+	iounmap(r->mmio_base);
+failed_free:
+	kfree(r);
+	return err;
+}
+
+static int __devexit pxa930_rotary_remove(struct platform_device *pdev)
+{
+	struct pxa930_rotary *r = platform_get_drvdata(pdev);
+
+	free_irq(platform_get_irq(pdev, 0), r);
+
+	input_unregister_device(r->input_dev);
+
+	iounmap(r->mmio_base);
+	platform_set_drvdata(pdev, NULL);
+	kfree(r);
+	return 0;
+}
+
+static struct platform_driver pxa930_rotary_driver = {
+	.driver		= {
+		.name	= "pxa930-rotary",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pxa930_rotary_probe,
+	.remove		= __devexit_p(pxa930_rotary_remove),
+};
+
+static int __init pxa930_rotary_init(void)
+{
+	return platform_driver_register(&pxa930_rotary_driver);
+}
+module_init(pxa930_rotary_init);
+
+static void __exit pxa930_rotary_exit(void)
+{
+	platform_driver_unregister(&pxa930_rotary_driver);
+}
+module_exit(pxa930_rotary_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for PXA93x Enhanced Rotary Controller");
+MODULE_AUTHOR("Yao Yong <yaoyong@marvell.com>");
-- 
1.6.0.4

------=_Part_17833_4789889.1228443303636
Content-Type: text/x-diff;
 name=0003-input-add-support-for-enhanced-rotary-controller-on.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_foc7ex1v0
Content-Disposition: attachment;
 filename=0003-input-add-support-for-enhanced-rotary-controller-on.patch

RnJvbSA1ZjY2OTNlZDhkMjNhM2FjMzc0MDQzNThhNmIxZTBiYTA4ODkyNTZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nIFlhbyA8eWFveW9uZ0BtYXJ2ZWxsLmNvbT4KRGF0ZTog
V2VkLCAzIERlYyAyMDA4IDEzOjQwOjA4ICswODAwClN1YmplY3Q6IFtQQVRDSF0gaW5wdXQ6IGFk
ZCBzdXBwb3J0IGZvciBlbmhhbmNlZCByb3RhcnkgY29udHJvbGxlciBvbiBweGE5MzAgYW5kIHB4
YTkzNQoKU2lnbmVkLW9mZi1ieTogWW9uZyBZYW8gPHlhb3lvbmdAbWFydmVsbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEVyaWMgTWlhbyA8ZXJpYy5taWFvQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJt
L21hY2gtcHhhL2luY2x1ZGUvbWFjaC9weGE5MzBfcm90YXJ5LmggfCAgIDIxICsrKwogZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAgIDkgKwogZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgIDEgKwogZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9weGE5MzBfcm90YXJ5LmMgICAgICAgICB8ICAyMTIgKysrKysrKysr
KysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDI0MyBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUv
bWFjaC9weGE5MzBfcm90YXJ5LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L2tl
eWJvYXJkL3B4YTkzMF9yb3RhcnkuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL2lu
Y2x1ZGUvbWFjaC9weGE5MzBfcm90YXJ5LmggYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21h
Y2gvcHhhOTMwX3JvdGFyeS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmNm
OTJhYzMKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gv
cHhhOTMwX3JvdGFyeS5oCkBAIC0wLDAgKzEsMjEgQEAKKyNpZm5kZWYgX19BU01fQVJDSF9QWEE5
MzBfUk9UQVJZX0gKKyNkZWZpbmUgX19BU01fQVJDSF9QWEE5MzBfUk9UQVJZX0gKKworI2luY2x1
ZGUgPGxpbnV4L2lucHV0Lmg+CisKKy8qIE5PVEU6CisgKgorICogcm90YXJ5IGNhbiBiZSBlaXRo
ZXIgaW50ZXJwcmV0ZWQgYXMgYSByYWxhdGl2ZSBpbnB1dCBldmVudCAoZS5nLgorICogUkVMX1dI
RUVMIG9yIFJFTF9IV0hFRUwpIG9yIGEgc3BlY2lmaWMga2V5IGV2ZW50IChlLmcuIFVQL0RPV04K
KyAqIG9yIExFRlQvUklHSFQpLCBkZXBlbmRpbmcgb24gaWYgdXBfa2V5ICYgZG93bl9rZXkgYXJl
IGFzc2lnbmVkCisgKiBvciByZWxfY29kZSBpcyBhc3NpZ25lZCBhIG5vbi16ZXJvIHZhbHVlLiBX
aGVuIGFsbCBhcmUgbm9uLXplcm8sCisgKiB1cF9rZXkgYW5kIGRvd25fa2V5IHdpbGwgYmUgcHJl
ZmVycmVkLgorICovCitzdHJ1Y3QgcHhhOTMwX3JvdGFyeV9wbGF0Zm9ybV9kYXRhIHsKKwlpbnQJ
dXBfa2V5OworCWludAlkb3duX2tleTsKKwlpbnQJcmVsX2NvZGU7Cit9OworCit2b2lkIF9faW5p
dCBweGE5MzBfc2V0X3JvdGFyeWtleV9pbmZvKHN0cnVjdCBweGE5MzBfcm90YXJ5X3BsYXRmb3Jt
X2RhdGEgKmluZm8pOworI2VuZGlmIC8qIF9fQVNNX0FSQ0hfUFhBOTMwX1JPVEFSWV9IICovCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcgYi9kcml2ZXJzL2lucHV0
L2tleWJvYXJkL0tjb25maWcKaW5kZXggZWZkNzBhOS4uMzU1NjE2OCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnCisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
S2NvbmZpZwpAQCAtMjY4LDYgKzI2OCwxNSBAQCBjb25maWcgS0VZQk9BUkRfUFhBMjd4CiAJICBU
byBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUKIAkg
IG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBweGEyN3hfa2V5cGFkLgogCitjb25maWcgS0VZQk9BUkRf
UFhBOTMwX1JPVEFSWQorCXRyaXN0YXRlICJQWEE5MzAvUFhBOTM1IEVuaGFuY2VkIFJvdGFyeSBD
b250cm9sbGVyIFN1cHBvcnQiCisJZGVwZW5kcyBvbiBDUFVfUFhBOTMwIHx8IENQVV9QWEE5MzUK
KwloZWxwCisJICBFbmFibGUgc3VwcG9ydCBmb3IgUFhBOTMwL1BYQTkzNSBFbmhhbmNlZCBSb3Rh
cnkgQ29udHJvbGxlci4KKworCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwg
Y2hvb3NlIE0gaGVyZTogdGhlCisJICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgcHhhOTMwX3JvdGFy
eS4KKwogY29uZmlnIEtFWUJPQVJEX0FBRUQyMDAwCiAJdHJpc3RhdGUgIkFBRUQtMjAwMCBrZXli
b2FyZCIKIAlkZXBlbmRzIG9uIE1BQ0hfQUFFRDIwMDAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvTWFrZWZpbGUgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlCmlu
ZGV4IDBlZGM4ZjIuLjM2MzUxZTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
TWFrZWZpbGUKKysrIGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZQpAQCAtMjAsNiAr
MjAsNyBAQCBvYmotJChDT05GSUdfS0VZQk9BUkRfSElMKQkJKz0gaGlsX2tiZC5vCiBvYmotJChD
T05GSUdfS0VZQk9BUkRfSElMX09MRCkJCSs9IGhpbGtiZC5vCiBvYmotJChDT05GSUdfS0VZQk9B
UkRfT01BUCkJCSs9IG9tYXAta2V5cGFkLm8KIG9iai0kKENPTkZJR19LRVlCT0FSRF9QWEEyN3gp
CQkrPSBweGEyN3hfa2V5cGFkLm8KK29iai0kKENPTkZJR19LRVlCT0FSRF9QWEE5MzBfUk9UQVJZ
KQkrPSBweGE5MzBfcm90YXJ5Lm8KIG9iai0kKENPTkZJR19LRVlCT0FSRF9BQUVEMjAwMCkJCSs9
IGFhZWQyMDAwX2tiZC5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRfR1BJTykJCSs9IGdwaW9fa2V5
cy5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRfSFA2WFgpCQkrPSBqb3JuYWRhNjgwX2tiZC5vCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL3B4YTkzMF9yb3RhcnkuYyBiL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvcHhhOTMwX3JvdGFyeS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAuLjQ4NDY0MzYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2lucHV0L2tl
eWJvYXJkL3B4YTkzMF9yb3RhcnkuYwpAQCAtMCwwICsxLDIxMiBAQAorLyoKKyAqIGxpbnV4L2Ry
aXZlcnMvaW5wdXQva2V5Ym9hcmQvcHhhOTMwX3JvdGFyeS5jCisgKgorICogRHJpdmVyIGZvciB0
aGUgZW5oYW5jZWQgcm90YXJ5IGNvbnRyb2xsZXIgb24gcHhhOTMwIGFuZCBweGE5MzUKKyAqCisg
KiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQg
YW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8
bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4KKyNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorCisjaW5jbHVk
ZSA8bWFjaC9weGE5MzBfcm90YXJ5Lmg+CisKKyNkZWZpbmUgU0JDUgkoMHgwNCkKKyNkZWZpbmUg
RVJDUgkoMHgwYykKKworI2RlZmluZSBTQkNSX0VSU0IJKDEgPDwgNSkKKworc3RydWN0IHB4YTkz
MF9yb3RhcnkgeworCXN0cnVjdCBpbnB1dF9kZXYJKmlucHV0X2RldjsKKwl2b2lkIF9faW9tZW0J
CSptbWlvX2Jhc2U7CisJaW50CQkJbGFzdF9lcmNyOworCisJc3RydWN0IHB4YTkzMF9yb3Rhcnlf
cGxhdGZvcm1fZGF0YSAqcGRhdGE7Cit9OworCitzdGF0aWMgdm9pZCBjbGVhcl9zYmNyKHN0cnVj
dCBweGE5MzBfcm90YXJ5ICpyKQoreworCXVpbnQzMl90IHNiY3IgPSBfX3Jhd19yZWFkbChyLT5t
bWlvX2Jhc2UgKyBTQkNSKTsKKworCV9fcmF3X3dyaXRlbChzYmNyIHwgU0JDUl9FUlNCLCByLT5t
bWlvX2Jhc2UgKyBTQkNSKTsKKwlfX3Jhd193cml0ZWwoc2JjciAmIH5TQkNSX0VSU0IsIHItPm1t
aW9fYmFzZSArIFNCQ1IpOworfQorCitzdGF0aWMgaXJxcmV0dXJuX3Qgcm90YXJ5X2lycShpbnQg
aXJxLCB2b2lkICpkZXZfaWQpCit7CisJc3RydWN0IHB4YTkzMF9yb3RhcnkgKnIgPSBkZXZfaWQ7
CisJc3RydWN0IHB4YTkzMF9yb3RhcnlfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSByLT5wZGF0YTsK
KwlpbnQgZXJjciwgZGVsdGEsIGtleTsKKworCWVyY3IgPSBfX3Jhd19yZWFkbChyLT5tbWlvX2Jh
c2UgKyBFUkNSKSAmIDB4ZjsKKwljbGVhcl9zYmNyKHIpOworCisJZGVsdGEgPSBlcmNyIC0gci0+
bGFzdF9lcmNyOworCWlmIChkZWx0YSA9PSAwKQorCQlyZXR1cm4gSVJRX0hBTkRMRUQ7CisKKwlp
ZiAocGRhdGEtPnVwX2tleSAmJiBwZGF0YS0+ZG93bl9rZXkpIHsKKwkJa2V5ID0gKGRlbHRhID4g
MCkgPyBwZGF0YS0+dXBfa2V5IDogcGRhdGEtPmRvd25fa2V5OworCQlpbnB1dF9yZXBvcnRfa2V5
KHItPmlucHV0X2Rldiwga2V5LCAxKTsKKwkJaW5wdXRfcmVwb3J0X2tleShyLT5pbnB1dF9kZXYs
IGtleSwgMCk7CisJfSBlbHNlCisJCWlucHV0X3JlcG9ydF9yZWwoci0+aW5wdXRfZGV2LCBwZGF0
YS0+cmVsX2NvZGUsIGRlbHRhKTsKKworCWlucHV0X3N5bmMoci0+aW5wdXRfZGV2KTsKKwlyLT5s
YXN0X2VyY3IgPSBlcmNyOworCisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorCitzdGF0aWMgaW50
IHB4YTkzMF9yb3Rhcnlfb3BlbihzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpCit7CisJc3RydWN0IHB4
YTkzMF9yb3RhcnkgKnIgPSBpbnB1dF9nZXRfZHJ2ZGF0YShkZXYpOworCisJY2xlYXJfc2Jjcihy
KTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgcHhhOTMwX3JvdGFyeV9jbG9zZShzdHJ1
Y3QgaW5wdXRfZGV2ICpkZXYpCit7CisJc3RydWN0IHB4YTkzMF9yb3RhcnkgKnIgPSBpbnB1dF9n
ZXRfZHJ2ZGF0YShkZXYpOworCisJY2xlYXJfc2JjcihyKTsKK30KKworc3RhdGljIGludCBfX2Rl
dmluaXQgcHhhOTMwX3JvdGFyeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQor
eworCXN0cnVjdCBweGE5MzBfcm90YXJ5X3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gcGRldi0+ZGV2
LnBsYXRmb3JtX2RhdGE7CisJc3RydWN0IHB4YTkzMF9yb3RhcnkgKnI7CisJc3RydWN0IGlucHV0
X2RldiAqaW5wdXRfZGV2OworCXN0cnVjdCByZXNvdXJjZSAqcmVzOworCWludCBpcnE7CisJaW50
IGVyciA9IC1FSU5WQUw7CisKKwlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOworCWlm
IChpcnEgPCAwKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIGlycSBmb3Igcm90YXJ5IGNv
bnRyb2xsZXJcbiIpOworCQlyZXR1cm4gLUVOWElPOworCX0KKworCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7CisJaWYgKHJlcyA9PSBOVUxMKSB7
CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIEkvTyBtZW1vcnkgZGVmaW5lZFxuIik7CisJCXJl
dHVybiAtRU5YSU87CisJfQorCisJaWYgKHBkYXRhID09IE5VTEwpIHsKKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAibm8gcGxhdGZvcm0gZGF0YSBkZWZpbmVkXG4iKTsKKwkJcmV0dXJuIC1FSU5WQUw7
CisJfQorCisJciA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBweGE5MzBfcm90YXJ5KSwgR0ZQX0tF
Uk5FTCk7CisJaWYgKHIgPT0gTlVMTCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlyLT5tbWlvX2Jh
c2UgPSBpb3JlbWFwX25vY2FjaGUocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKKwlp
ZiAoci0+bW1pb19iYXNlID09IE5VTEwpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVk
IHRvIHJlbWFwIElPIG1lbW9yeVxuIik7CisJCWVyciA9IC1FTlhJTzsKKwkJZ290byBmYWlsZWRf
ZnJlZTsKKwl9CisKKwlyLT5wZGF0YSA9IHBkYXRhOworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIHIpOworCisJLyogYWxsb2NhdGUgYW5kIHJlZ2lzdGVyIHRoZSBpbnB1dCBkZXZpY2UgKi8K
KwlpbnB1dF9kZXYgPSBpbnB1dF9hbGxvY2F0ZV9kZXZpY2UoKTsKKwlpZiAoIWlucHV0X2Rldikg
eworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gYWxsb2NhdGUgaW5wdXQgZGV2aWNl
XG4iKTsKKwkJZXJyID0gLUVOT01FTTsKKwkJZ290byBmYWlsZWRfZnJlZV9pbzsKKwl9CisKKwlp
bnB1dF9kZXYtPm5hbWUgPSBwZGV2LT5uYW1lOworCWlucHV0X2Rldi0+aWQuYnVzdHlwZSA9IEJV
U19IT1NUOworCWlucHV0X2Rldi0+b3BlbiA9IHB4YTkzMF9yb3Rhcnlfb3BlbjsKKwlpbnB1dF9k
ZXYtPmNsb3NlID0gcHhhOTMwX3JvdGFyeV9jbG9zZTsKKwlpbnB1dF9kZXYtPmRldi5wYXJlbnQg
PSAmcGRldi0+ZGV2OworCisJaWYgKHBkYXRhLT51cF9rZXkgJiYgcGRhdGEtPmRvd25fa2V5KSB7
CisJCXNldF9iaXQocGRhdGEtPnVwX2tleSwgaW5wdXRfZGV2LT5rZXliaXQpOworCQlzZXRfYml0
KHBkYXRhLT5kb3duX2tleSwgaW5wdXRfZGV2LT5rZXliaXQpOworCQlpbnB1dF9kZXYtPmV2Yml0
WzBdID0gQklUX01BU0soRVZfS0VZKTsKKwl9IGVsc2UgeworCQlzZXRfYml0KHBkYXRhLT5yZWxf
Y29kZSwgaW5wdXRfZGV2LT5yZWxiaXQpOworCQlpbnB1dF9kZXYtPmV2Yml0WzBdID0gQklUX01B
U0soRVZfUkVMKTsKKwl9CisKKwlyLT5pbnB1dF9kZXYgPSBpbnB1dF9kZXY7CisJaW5wdXRfc2V0
X2RydmRhdGEoaW5wdXRfZGV2LCByKTsKKworCWVyciA9IHJlcXVlc3RfaXJxKGlycSwgcm90YXJ5
X2lycSwgSVJRRl9ESVNBQkxFRCwKKwkJCSJlbmhhbmNlZCByb3RhcnkiLCByKTsKKwlpZiAoZXJy
KSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZXF1ZXN0IElSUVxuIik7CisJ
CWdvdG8gZmFpbGVkX2ZyZWVfaW5wdXQ7CisJfQorCisJZXJyID0gaW5wdXRfcmVnaXN0ZXJfZGV2
aWNlKGlucHV0X2Rldik7CisJaWYgKGVycikgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWls
ZWQgdG8gcmVnaXN0ZXIgaW5wdXQgZGV2aWNlXG4iKTsKKwkJZ290byBmYWlsZWRfZnJlZV9pcnE7
CisJfQorCisJcmV0dXJuIDA7CisKK2ZhaWxlZF9mcmVlX2lycToKKwlmcmVlX2lycShpcnEsIHIp
OworZmFpbGVkX2ZyZWVfaW5wdXQ6CisJaW5wdXRfZnJlZV9kZXZpY2UoaW5wdXRfZGV2KTsKK2Zh
aWxlZF9mcmVlX2lvOgorCWlvdW5tYXAoci0+bW1pb19iYXNlKTsKK2ZhaWxlZF9mcmVlOgorCWtm
cmVlKHIpOworCXJldHVybiBlcnI7Cit9CisKK3N0YXRpYyBpbnQgX19kZXZleGl0IHB4YTkzMF9y
b3RhcnlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IHB4
YTkzMF9yb3RhcnkgKnIgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKworCWZyZWVfaXJx
KHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCksIHIpOworCisJaW5wdXRfdW5yZWdpc3Rlcl9kZXZp
Y2Uoci0+aW5wdXRfZGV2KTsKKworCWlvdW5tYXAoci0+bW1pb19iYXNlKTsKKwlwbGF0Zm9ybV9z
ZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsKKwlrZnJlZShyKTsKKwlyZXR1cm4gMDsKK30KKworc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgcHhhOTMwX3JvdGFyeV9kcml2ZXIgPSB7CisJLmRy
aXZlcgkJPSB7CisJCS5uYW1lCT0gInB4YTkzMC1yb3RhcnkiLAorCQkub3duZXIJPSBUSElTX01P
RFVMRSwKKwl9LAorCS5wcm9iZQkJPSBweGE5MzBfcm90YXJ5X3Byb2JlLAorCS5yZW1vdmUJCT0g
X19kZXZleGl0X3AocHhhOTMwX3JvdGFyeV9yZW1vdmUpLAorfTsKKworc3RhdGljIGludCBfX2lu
aXQgcHhhOTMwX3JvdGFyeV9pbml0KHZvaWQpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9y
ZWdpc3RlcigmcHhhOTMwX3JvdGFyeV9kcml2ZXIpOworfQorbW9kdWxlX2luaXQocHhhOTMwX3Jv
dGFyeV9pbml0KTsKKworc3RhdGljIHZvaWQgX19leGl0IHB4YTkzMF9yb3RhcnlfZXhpdCh2b2lk
KQoreworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZweGE5MzBfcm90YXJ5X2RyaXZlcik7
Cit9Cittb2R1bGVfZXhpdChweGE5MzBfcm90YXJ5X2V4aXQpOworCitNT0RVTEVfTElDRU5TRSgi
R1BMIik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkRyaXZlciBmb3IgUFhBOTN4IEVuaGFuY2VkIFJv
dGFyeSBDb250cm9sbGVyIik7CitNT0RVTEVfQVVUSE9SKCJZYW8gWW9uZyA8eWFveW9uZ0BtYXJ2
ZWxsLmNvbT4iKTsKLS0gCjEuNi4wLjQKCg==
------=_Part_17833_4789889.1228443303636--
