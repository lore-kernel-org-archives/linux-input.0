From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] new driver for SGI Indy volume buttons
Date: Fri, 11 Jul 2008 20:34:35 +0200 (CEST)
Message-ID: <20080711183435.4C53AC2EBF@solo.franken.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:44265 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbYGKSei (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2008 14:34:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru

This driver adds support for the volume buttons on the front of every
SGI Indy workstation.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.27.

 drivers/input/misc/Kconfig         |   10 +++
 drivers/input/misc/Makefile        |    1 +
 drivers/input/misc/sgi_indy_btns.c |  154 ++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 432699d..6c9d545 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -189,6 +189,16 @@ config INPUT_UINPUT
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
+config INPUT_SGI_INDY_BTNS
+	tristate "SGI Indy volume button interface"
+	depends on SGI_IP22
+	select INPUT_POLLDEV
+	help
+	  Say Y here if you want to support SGI Indy volume button interface.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sgi_indy_btns.
+
 config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on GSC || HP300
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index ebd39f2..b86360e 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
+obj-$(CONFIG_INPUT_SGI_INDY_BTNS)	+= sgi_indy_btns.o
diff --git a/drivers/input/misc/sgi_indy_btns.c b/drivers/input/misc/sgi_indy_btns.c
new file mode 100644
index 0000000..15f891a
--- /dev/null
+++ b/drivers/input/misc/sgi_indy_btns.c
@@ -0,0 +1,154 @@
+/*
+ *  SGI Indy Volume Button interface driver
+ *
+ *  Copyright (C) 2008  Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/init.h>
+#include <linux/input-polldev.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/sgi/ioc.h>
+
+#define BUTTONS_POLL_INTERVAL	30	/* msec */
+#define BUTTONS_COUNT_THRESHOLD	3
+
+static const unsigned short sgi_indy_map[] = {
+	KEY_VOLUMEDOWN,
+	KEY_VOLUMEUP
+};
+
+struct buttons_dev {
+	struct input_polled_dev *poll_dev;
+	unsigned short keymap[ARRAY_SIZE(sgi_indy_map)];
+	int count[ARRAY_SIZE(sgi_indy_map)];
+	void __iomem *reg;
+};
+
+static void handle_buttons(struct input_polled_dev *dev)
+{
+	struct buttons_dev *bdev = dev->private;
+	struct input_dev *input = dev->input;
+	u8 status;
+	int i;
+
+	status = readb(&sgioc->panel) ^ 0xa0;
+	status = ((status & 0x80) >> 7) | ((status & 0x20) >> 5);
+
+	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
+		if (status & (1U << i)) {
+			if (++bdev->count[i] == BUTTONS_COUNT_THRESHOLD) {
+				input_event(input, EV_MSC, MSC_SCAN, i);
+				input_report_key(input, bdev->keymap[i], 1);
+				input_sync(input);
+			}
+		} else {
+			if (bdev->count[i] >= BUTTONS_COUNT_THRESHOLD) {
+				input_event(input, EV_MSC, MSC_SCAN, i);
+				input_report_key(input, bdev->keymap[i], 0);
+				input_sync(input);
+			}
+			bdev->count[i] = 0;
+		}
+	}
+}
+
+static int __devinit sgi_indy_buttons_probe(struct platform_device *pdev)
+{
+	struct buttons_dev *bdev;
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input;
+	int error, i;
+
+	bdev = kzalloc(sizeof(struct buttons_dev), GFP_KERNEL);
+	poll_dev = input_allocate_polled_device();
+	if (!bdev || !poll_dev) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	memcpy(bdev->keymap, sgi_indy_map, sizeof(bdev->keymap));
+
+	poll_dev->private = bdev;
+	poll_dev->poll = handle_buttons;
+	poll_dev->poll_interval = BUTTONS_POLL_INTERVAL;
+
+	input = poll_dev->input;
+	input->name = "SGI Indy buttons";
+	input->phys = "indy/input0";
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+
+	input->keycode = bdev->keymap;
+	input->keycodemax = ARRAY_SIZE(bdev->keymap);
+	input->keycodesize = sizeof(unsigned short);
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	__set_bit(EV_KEY, input->evbit);
+	for (i = 0; i < ARRAY_SIZE(sgi_indy_map); i++)
+		__set_bit(bdev->keymap[i], input->keybit);
+	__clear_bit(KEY_RESERVED, input->keybit);
+
+	bdev->poll_dev = poll_dev;
+	dev_set_drvdata(&pdev->dev, bdev);
+
+	error = input_register_polled_device(poll_dev);
+	if (!error)
+		return 0;
+
+ err_free_mem:
+	input_free_polled_device(poll_dev);
+	kfree(bdev);
+	dev_set_drvdata(&pdev->dev, NULL);
+	return error;
+}
+
+static int __devexit sgi_indy_buttons_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct buttons_dev *bdev = dev_get_drvdata(dev);
+
+	input_unregister_polled_device(bdev->poll_dev);
+	input_free_polled_device(bdev->poll_dev);
+	kfree(bdev);
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sgi_indy_buttons_driver = {
+	.probe	= sgi_indy_buttons_probe,
+	.remove	= __devexit_p(sgi_indy_buttons_remove),
+	.driver	= {
+		.name	= "sgiindybtns",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init sgi_indy_buttons_init(void)
+{
+	return platform_driver_register(&sgi_indy_buttons_driver);
+}
+
+static void __exit sgi_indy_buttons_exit(void)
+{
+	platform_driver_unregister(&sgi_indy_buttons_driver);
+}
+
+module_init(sgi_indy_buttons_init);
+module_exit(sgi_indy_buttons_exit);
