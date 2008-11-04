From: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Subject: [PATCH 2/2] INPUT: an interrupt-driven driver for Indy volume control
Date: Tue,  4 Nov 2008 22:56:56 +0200
Message-ID: <1225832216-6893-2-git-send-email-dmitri.vorobiev@movial.fi>
References: <1225832216-6893-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1225832216-6893-1-git-send-email-dmitri.vorobiev@movial.fi>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
List-Id: linux-input@vger.kernel.org

This patch introduces an interrupt-driven version of the SGI
Indy volume control buttons driver.

Tested using an Indy box.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/sgi-ip22/Makefile        |    2 +-
 arch/mips/sgi-ip22/ip22-platform.c |    6 +-
 arch/mips/sgi-ip22/ip22-reset.c    |    3 +-
 drivers/input/misc/Kconfig         |   11 ++
 drivers/input/misc/Makefile        |    1 +
 drivers/input/misc/sgipanel.c      |  219 ++++++++++++++++++++++++++++++++++++
 6 files changed, 237 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/misc/sgipanel.c

diff --git a/arch/mips/sgi-ip22/Makefile b/arch/mips/sgi-ip22/Makefile
index ef1564e..416b18f 100644
--- a/arch/mips/sgi-ip22/Makefile
+++ b/arch/mips/sgi-ip22/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_SGI_IP22) += ip22-berr.o
 obj-$(CONFIG_SGI_IP28) += ip28-berr.o
 obj-$(CONFIG_EISA)	+= ip22-eisa.o
 
-# EXTRA_CFLAGS += -Werror
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index deddbf0..1380566 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -183,15 +183,15 @@ static int __init sgi_hal2_devinit(void)
 
 device_initcall(sgi_hal2_devinit);
 
-static int __init sgi_button_devinit(void)
+static int __init sgi_panel_devinit(void)
 {
 	if (ip22_is_fullhouse())
 		return 0; /* full house has no volume buttons */
 
-	return IS_ERR(platform_device_register_simple("sgibtns", -1, NULL, 0));
+	return IS_ERR(platform_device_register_simple("sgipanel", -1, NULL, 0));
 }
 
-device_initcall(sgi_button_devinit);
+device_initcall(sgi_panel_devinit);
 
 static int __init sgi_ds1286_devinit(void)
 {
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 4ad5c33..b340fa1 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -191,7 +191,8 @@ static int __init reboot_setup(void)
 	_machine_halt = sgi_machine_halt;
 	pm_power_off = sgi_machine_power_off;
 
-	res = request_irq(SGI_PANEL_IRQ, panel_int, 0, "Front Panel", NULL);
+	res = request_irq(SGI_PANEL_IRQ, panel_int, IRQF_SHARED, "Front Panel",
+								reboot_setup);
 	if (res) {
 		printk(KERN_ERR "Allocation of front panel IRQ failed\n");
 		return res;
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1f93202..47e98e1 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -212,6 +212,17 @@ config INPUT_SGI_O2_BTNS
 	  To compile this driver as a module, choose M here: the module will
 	  be called o2_btns.
 
+config INPUT_SGI_INDY_PANEL
+	tristate "SGI Indy front panel buttons support"
+	depends on SGI_IP22
+	default m
+	help
+	  Select Y here if you want to support SGI Indy volume control
+	  buttons.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sgipanel.
+
 config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on GSC || HP300
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 2b18c92..d5e197c 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_SGI_O2_BTNS)		+= o2_btns.o
+obj-$(CONFIG_INPUT_SGI_INDY_PANEL)	+= sgipanel.o
diff --git a/drivers/input/misc/sgipanel.c b/drivers/input/misc/sgipanel.c
new file mode 100644
index 0000000..d1e2092
--- /dev/null
+++ b/drivers/input/misc/sgipanel.c
@@ -0,0 +1,219 @@
+/*
+ *  SGI Indy front panel driver
+ *
+ *  Copyright (C) 2008 Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
+ *  Based on the polling driver by Thomas Bogendoerfer
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
+
+#include <linux/bitops.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/sgi/ioc.h>
+#include <asm/sgi/ip22.h>
+
+#define POLL_INTERVAL_MSECS 30
+#define POLL_INTERVAL msecs_to_jiffies(POLL_INTERVAL_MSECS)
+
+static struct timer_list panel_timer;
+
+static const unsigned short panel_map[] = {
+	KEY_VOLUMEDOWN,
+	KEY_VOLUMEUP,
+};
+
+struct sgipanel {
+	struct input_dev *input;
+	struct timer_list *timer;
+	int pressed[ARRAY_SIZE(panel_map)];
+	int shutting_down;
+	unsigned short keymap[ARRAY_SIZE(panel_map)];
+};
+
+static inline u8 panel_status(void)
+{
+	u8 status;
+
+	status = sgioc->panel;
+	status ^= (SGIOC_PANEL_VOLDNHOLD | SGIOC_PANEL_VOLUPHOLD);
+
+	return ((status & SGIOC_PANEL_VOLUPHOLD) >> 6) |
+		((status & SGIOC_PANEL_VOLDNHOLD) >> 5);
+}
+
+static void timer(unsigned long data)
+{
+	struct sgipanel *bdev = (struct sgipanel *) data;
+	struct input_dev *input = bdev->input;
+	int status = panel_status();
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
+		if (status & BIT(i)) {
+			if (!bdev->pressed[i]) {
+				input_event(input, EV_MSC, MSC_SCAN, i);
+				input_report_key(input, bdev->keymap[i], 1);
+				input_sync(input);
+			}
+			bdev->pressed[i] = 1;
+			bdev->timer->expires = jiffies + POLL_INTERVAL;
+			if (!bdev->shutting_down)
+				add_timer(bdev->timer);
+		} else {
+			if (bdev->pressed[i]) {
+				input_event(input, EV_MSC, MSC_SCAN, i);
+				input_report_key(input, bdev->keymap[i], 0);
+				input_sync(input);
+			}
+			bdev->pressed[i] = 0;
+		}
+	}
+}
+
+static irqreturn_t panel_interrupt(int irq, void *data)
+{
+	struct sgipanel *bdev = (struct sgipanel *) data;
+
+	bdev->timer->expires = jiffies;
+	add_timer(bdev->timer);
+	return IRQ_HANDLED;
+}
+
+static int __devinit sgi_indy_panel_probe(struct platform_device *pdev)
+{
+	struct sgipanel *bdev;
+	struct input_dev *input;
+	int i, error;
+
+	/*
+	 * Section 2.6.2 of ioc.ps states: "Full House does not have
+	 * any support for Volume Control."
+	 */
+	if (ip22_is_fullhouse()) {
+		error = -ENODEV;
+		goto err_return;
+	}
+
+	bdev = kzalloc(sizeof(struct sgipanel), GFP_KERNEL);
+	if (!bdev) {
+		error = -ENOMEM;
+		dev_err(&pdev->dev, "Could not allocate memory\n");
+		goto err_return;
+	}
+
+	bdev->timer = &panel_timer;
+
+	init_timer(bdev->timer);
+	bdev->timer->data = (unsigned long) bdev;
+	bdev->timer->function = timer;
+
+	error = request_irq(SGI_PANEL_IRQ, panel_interrupt, IRQF_SHARED,
+							"Front Panel", bdev);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to get IRQ\n");
+		goto err_free_bdev;
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		dev_err(&pdev->dev, "Could not allocate input device\n");
+		goto err_free_irq;
+	}
+
+	memcpy(bdev->keymap, panel_map, sizeof(bdev->keymap));
+
+	input->name = "SGI panel";
+	input->phys = "sgi/input0";
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+
+	input->keycode = bdev->keymap;
+	input->keycodemax = ARRAY_SIZE(bdev->keymap);
+	input->keycodesize = sizeof(unsigned short);
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	__set_bit(EV_KEY, input->evbit);
+	for (i = 0; i < ARRAY_SIZE(panel_map); i++)
+		__set_bit(bdev->keymap[i], input->keybit);
+	__clear_bit(KEY_RESERVED, input->keybit);
+
+	bdev->input = input;
+	dev_set_drvdata(&pdev->dev, bdev);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev, "Could not register input device\n");
+		goto err_free_mem;
+	}
+
+	return 0;
+
+err_free_mem:
+	dev_set_drvdata(&pdev->dev, NULL);
+	input_free_device(input);
+err_free_irq:
+	free_irq(SGI_PANEL_IRQ, bdev);
+err_free_bdev:
+	kfree(bdev);
+err_return:
+	return error;
+}
+
+static int __devexit sgi_indy_panel_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sgipanel *bdev = dev_get_drvdata(dev);
+
+	bdev->shutting_down = 1;
+	input_unregister_device(bdev->input);
+	free_irq(SGI_PANEL_IRQ, bdev);
+	del_timer_sync(bdev->timer);
+	kfree(bdev);
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sgi_indy_panel_driver = {
+	.probe	= sgi_indy_panel_probe,
+	.remove	= __devexit_p(sgi_indy_panel_remove),
+	.driver	= {
+		.name	= "sgipanel",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init sgi_indy_panel_init(void)
+{
+	return platform_driver_register(&sgi_indy_panel_driver);
+}
+
+static void __exit sgi_indy_panel_exit(void)
+{
+	platform_driver_unregister(&sgi_indy_panel_driver);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dmitri Vorobiev <dmitri.vorobiev@movial.fi");
+MODULE_ALIAS("platform:sgipanel");
+MODULE_DESCRIPTION("SGI front panel driver");
+module_init(sgi_indy_panel_init);
+module_exit(sgi_indy_panel_exit);
-- 
1.5.4.3
