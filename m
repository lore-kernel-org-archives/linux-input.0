From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 2/2] input: add driver for S1 button of rb532
Date: Thu, 22 Jan 2009 20:12:08 +0100
Message-ID: <20090122191216.15285400E106@mail.nwl.cc>
References: <1232651528-19870-1-git-send-email-n0-1@freewrt.org>
 <1232651528-19870-2-git-send-email-n0-1@freewrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:56123 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646AbZAVTMR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2009 14:12:17 -0500
In-Reply-To: <1232651528-19870-2-git-send-email-n0-1@freewrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>

Mikrotik's Routerboard 532 has two builtin buttons, from which one
triggers a hardware reset. The other one is accessible through GPIO pin
1. Sadly, this pin is being multiplexed with UART0 input, so enabling it
as interrupt source (as implied by the gpio-keys driver) is not possible
unless UART0 has been turned off. The later one though is a rather bad
idea as the Routerboard is an embedded device with only a single serial
port, so it's almost always used as serial console device.

This patch adds a driver based on INPUT_POLLDEV, which disables the UART
and reconfigures GPIO pin 1 temporarily while reading the button state.
This procedure works fine and has been tested as part of another,
unpublished driver for this device.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/input/misc/Kconfig        |    8 +++
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/rb532_button.c |  111 +++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/rb532_button.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 67e5553..9666462 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -227,4 +227,12 @@ config INPUT_PCF50633_PMU
 	 Say Y to include support for delivering  PMU events via  input
 	 layer on NXP PCF50633.
 
+config INPUT_RB532_BUTTON
+	tristate "Mikrotik Routerboard 532 button interface"
+	depends on MIKROTIK_RB532
+	select INPUT_POLLDEV
+	help
+	  Say Y here if you want support for the S1 button built into
+	  Mikrotik's Routerboard 532.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index bb62e6e..0bb6a0e 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
+obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
diff --git a/drivers/input/misc/rb532_button.c b/drivers/input/misc/rb532_button.c
new file mode 100644
index 0000000..05f2f49
--- /dev/null
+++ b/drivers/input/misc/rb532_button.c
@@ -0,0 +1,111 @@
+/*
+ * Support for the S1 button on Routerboard 532
+ *
+ * Copyright (C) 2009  Phil Sutter <n0-1@freewrt.org>
+ */
+
+#include <linux/input-polldev.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-rc32434/gpio.h>
+#include <asm/mach-rc32434/rb.h>
+
+#define DRV_NAME "rb532-button"
+
+#define RB532_BTN_RATE 100 /* msec */
+#define RB532_BTN_KSYM BTN_0
+
+/* The S1 button state is provided by GPIO pin 1. But as this
+ * pin is also used for uart input as alternate function, the
+ * operational modes must be switched first:
+ * 1) disable uart using set_latch_u5()
+ * 2) turn off alternate function implicitly through
+ *    gpio_direction_input()
+ * 3) read the GPIO's current value
+ * 4) undo step 2 by enabling alternate function (in this
+ *    mode the GPIO direction is fixed, so no change needed)
+ * 5) turn on uart again
+ * The GPIO value occurs to be inverted, so pin high means
+ * button is not pressed.
+ */
+static bool rb532_button_pressed(void) {
+        int val;
+
+	set_latch_u5(0, LO_FOFF);
+	gpio_direction_input(GPIO_BTN_S1);
+
+	val = gpio_get_value(GPIO_BTN_S1);
+
+	rb532_gpio_set_func(GPIO_BTN_S1);
+	set_latch_u5(LO_FOFF, 0);
+
+        return !val;
+}
+
+static void rb532_button_poll(struct input_polled_dev *poll_dev)
+{
+	input_report_key(poll_dev->input, RB532_BTN_KSYM,
+	                 rb532_button_pressed());
+	input_sync(poll_dev->input);
+}
+
+static int __devinit rb532_button_probe(struct platform_device *pdev)
+{
+	struct input_polled_dev *poll_dev;
+
+	poll_dev = input_allocate_polled_device();
+	if (!poll_dev)
+		return -ENOMEM;
+
+	poll_dev->poll = rb532_button_poll;
+	poll_dev->poll_interval = RB532_BTN_RATE;
+
+	poll_dev->input->name = "rb532 button";
+	poll_dev->input->phys = "rb532/button0";
+	poll_dev->input->id.bustype = BUS_HOST;
+	poll_dev->input->dev.parent = &pdev->dev;
+
+	dev_set_drvdata(&pdev->dev, poll_dev);
+
+	input_set_capability(poll_dev->input, EV_KEY, RB532_BTN_KSYM);
+
+	return input_register_polled_device(poll_dev);
+}
+
+static int __devexit rb532_button_remove(struct platform_device *pdev)
+{
+	struct input_polled_dev *poll_dev = dev_get_drvdata(&pdev->dev);
+
+	input_unregister_polled_device(poll_dev);
+	input_free_polled_device(poll_dev);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver rb532_button_driver = {
+	.probe = rb532_button_probe,
+	.remove = __devexit_p(rb532_button_remove),
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init rb532_button_init(void)
+{
+	return platform_driver_register(&rb532_button_driver);
+}
+
+static void __exit rb532_button_exit(void)
+{
+	platform_driver_unregister(&rb532_button_driver);
+}
+
+module_init(rb532_button_init);
+module_exit(rb532_button_exit);
+
+MODULE_AUTHOR("Phil Sutter <n0-1@freewrt.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Support for S1 button on Routerboard 532");
-- 
1.5.6.4

