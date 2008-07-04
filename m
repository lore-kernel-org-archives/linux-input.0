From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] new driver for SGI O2 volume buttons
Date: Sat,  5 Jul 2008 01:12:17 +0200 (CEST)
Message-ID: <20080704231217.4912A1DA77A@solo.franken.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:56155 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbYGEAFL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Jul 2008 20:05:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru

This driver adds support for the volume buttons on the front of every
SGI O2 workstation.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.27.

 drivers/input/misc/Kconfig      |   10 +++
 drivers/input/misc/Makefile     |    1 +
 drivers/input/misc/sgio2_btns.c |  154 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 432699d..e33d7cb 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -189,6 +189,16 @@ config INPUT_UINPUT
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
+config INPUT_SGIO2_BTNS
+	tristate "SGI O2 volume button interface"
+	depends on SGI_IP32
+	select INPUT_POLLDEV
+	help
+	  Say Y here if you want to support SGI O2 volume button interface.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sgio_btns.
+
 config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on GSC || HP300
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index ebd39f2..0e274f1 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
+obj-$(CONFIG_INPUT_SGIO2_BTNS)		+= sgio2_btns.o
diff --git a/drivers/input/misc/sgio2_btns.c b/drivers/input/misc/sgio2_btns.c
new file mode 100644
index 0000000..ef144a9
--- /dev/null
+++ b/drivers/input/misc/sgio2_btns.c
@@ -0,0 +1,154 @@
+/*
+ *  SGI O2 Volume Button interface driver
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
+#include <asm/ip32/mace.h>
+
+#define BUTTONS_POLL_INTERVAL	30	/* msec */
+#define BUTTONS_COUNT_THRESHOLD	3
+
+static const unsigned short sgio2_map[] = {
+	KEY_VOLUMEUP,
+	KEY_VOLUMEDOWN
+};
+
+struct buttons_dev {
+	struct input_polled_dev *poll_dev;
+	unsigned short keymap[ARRAY_SIZE(sgio2_map)];
+	int count[ARRAY_SIZE(sgio2_map)];
+	void __iomem *reg;
+};
+
+static void handle_buttons(struct input_polled_dev *dev)
+{
+	struct buttons_dev *bdev = dev->private;
+	struct input_dev *input = dev->input;
+	u64 status;
+	int i;
+
+	status = (readq(&mace->perif.audio.control) >> 23) & 3;
+
+	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
+		if (status & (1U << i)) {
+			writeq(status & ~(1U << i), &mace->perif.audio.control);
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
+static int __devinit sgio2_buttons_probe(struct platform_device *pdev)
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
+	memcpy(bdev->keymap, sgio2_map, sizeof(bdev->keymap));
+
+	poll_dev->private = bdev;
+	poll_dev->poll = handle_buttons;
+	poll_dev->poll_interval = BUTTONS_POLL_INTERVAL;
+
+	input = poll_dev->input;
+	input->name = "SGI O2 buttons";
+	input->phys = "sgio2/input0";
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+
+	input->keycode = bdev->keymap;
+	input->keycodemax = ARRAY_SIZE(bdev->keymap);
+	input->keycodesize = sizeof(unsigned short);
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	__set_bit(EV_KEY, input->evbit);
+	for (i = 0; i < ARRAY_SIZE(sgio2_map); i++)
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
+static int __devexit sgio2_buttons_remove(struct platform_device *pdev)
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
+static struct platform_driver sgio2_buttons_driver = {
+	.probe	= sgio2_buttons_probe,
+	.remove	= __devexit_p(sgio2_buttons_remove),
+	.driver	= {
+		.name	= "sgio2btns",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init sgio2_buttons_init(void)
+{
+	return platform_driver_register(&sgio2_buttons_driver);
+}
+
+static void __exit sgio2_buttons_exit(void)
+{
+	platform_driver_unregister(&sgio2_buttons_driver);
+}
+
+module_init(sgio2_buttons_init);
+module_exit(sgio2_buttons_exit);
