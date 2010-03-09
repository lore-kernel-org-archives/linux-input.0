From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v2] input/misc: PCF8574 I2C keypad input device driver
Date: Tue,  9 Mar 2010 16:01:53 -0500
Message-ID: <1268168513-7431-1-git-send-email-vapier@gentoo.org>
References: <20100309180906.GA19814@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:55124 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab0CIU6i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 15:58:38 -0500
In-Reply-To: <20100309180906.GA19814@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Bryan Wu <cooloney@kernel.org>

From: Bryan Wu <cooloney@kernel.org>

Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
v2
	- process all feedback from Dmitry except for threaded irqs; that'll have to be done later

 drivers/input/misc/Kconfig          |   10 ++
 drivers/input/misc/Makefile         |    1 +
 drivers/input/misc/pcf8574_keypad.c |  251 +++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/pcf8574_keypad.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 49a31bd..fa97c58 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -396,4 +396,14 @@ config INPUT_ADXL34X_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl34x-spi.
 
+config INPUT_PCF8574
+	tristate "PCF8574 Keypad input device"
+	depends on I2C && EXPERIMENTAL
+	help
+	  Say Y here if you want to support a keypad connetced via I2C
+	  with a PCF8574.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pcf8574_keypad.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 775db74..8107c57 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
 obj-$(CONFIG_INPUT_AD714X_SPI)		+= ad714x-spi.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
+obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
 obj-$(CONFIG_INPUT_ATI_REMOTE)		+= ati_remote.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
new file mode 100644
index 0000000..8b52a7e
--- /dev/null
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -0,0 +1,251 @@
+/*
+ * Driver for a keypad w/16 buttons connected to a PCF8574 I2C I/O expander
+ *
+ * Copyright 2005-2008 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+
+#define DRV_NAME "pcf8574_keypad"
+
+static const unsigned char pcf8574_kp_btncode[] = {
+	[0] = KEY_RESERVED,
+	[1] = KEY_ENTER,
+	[2] = KEY_BACKSLASH,
+	[3] = KEY_0,
+	[4] = KEY_RIGHTBRACE,
+	[5] = KEY_C,
+	[6] = KEY_9,
+	[7] = KEY_8,
+	[8] = KEY_7,
+	[9] = KEY_B,
+	[10] = KEY_6,
+	[11] = KEY_5,
+	[12] = KEY_4,
+	[13] = KEY_A,
+	[14] = KEY_3,
+	[15] = KEY_2,
+	[16] = KEY_1
+};
+
+struct kp_data {
+	unsigned char btncode[17];
+	struct input_dev *idev;
+	struct i2c_client *client;
+	char name[64];
+	char phys[32];
+	unsigned char laststate;
+	unsigned char statechanged;
+	unsigned long events_sent;
+	struct work_struct pcf8574_kp_work;
+};
+
+static short read_state(struct kp_data *lp)
+{
+	unsigned char x, y, a, b;
+
+	if (lp->client) {
+		i2c_smbus_write_byte(lp->client, 240);
+		x = 0xF & (~(i2c_smbus_read_byte(lp->client) >> 4));
+
+		i2c_smbus_write_byte(lp->client, 15);
+		y = 0xF & (~i2c_smbus_read_byte(lp->client));
+
+		for (a = 0; x > 0; a++)
+			x = x >> 1;
+		for (b = 0; y > 0; b++)
+			y = y >> 1;
+
+		return ((a - 1) * 4) + b;
+	}
+
+	return -1;
+}
+
+static void check_and_notify(struct work_struct *work)
+{
+	struct kp_data *lp =
+	    container_of(work, struct kp_data, pcf8574_kp_work);
+	unsigned char nextstate = read_state(lp);
+
+	lp->statechanged = lp->laststate ^ nextstate;
+
+	if (lp->statechanged)
+		input_report_key(lp->idev,
+				 nextstate > 17 ? lp->btncode[lp->laststate] :
+				 lp->btncode[nextstate],
+				 nextstate > 17 ? 0 : 1);
+	lp->laststate = nextstate;
+
+	input_sync(lp->idev);
+	enable_irq(lp->client->irq);
+}
+
+static irqreturn_t pcf8574_kp_irq_handler(int irq, void *dev_id)
+{
+	struct kp_data *lp = dev_id;
+
+	disable_irq_nosync(lp->client->irq);
+	schedule_work(&lp->pcf8574_kp_work);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	int i, ret;
+	struct input_dev *idev;
+	struct kp_data *lp;
+
+	if (i2c_smbus_write_byte(client, 240) < 0) {
+		dev_err(&client->dev, "probe: write fail\n");
+		return -ENODEV;
+	}
+
+	lp = kzalloc(sizeof(*lp), GFP_KERNEL);
+	if (!lp)
+		return -ENOMEM;
+	lp->client = client;
+
+	idev = input_allocate_device();
+	if (!idev) {
+		dev_err(&client->dev, "Can't allocate input device\n");
+		ret = -ENOMEM;
+		goto fail_allocate;
+	}
+
+	lp->idev = idev;
+	memcpy(lp->btncode, pcf8574_kp_btncode, sizeof(pcf8574_kp_btncode));
+
+	idev->evbit[0] = 0;
+
+	idev->evbit[0] |= BIT_MASK(EV_KEY);
+	idev->keycode = lp->btncode;
+	idev->keycodesize = sizeof(pcf8574_kp_btncode);
+	idev->keycodemax = ARRAY_SIZE(pcf8574_kp_btncode);
+
+	for (i = 0; i < ARRAY_SIZE(pcf8574_kp_btncode); ++i)
+		__set_bit(lp->btncode[i] & KEY_MAX, idev->keybit);
+
+	__clear_bit(KEY_RESERVED, idev->keybit);
+
+	sprintf(lp->name, DRV_NAME);
+	sprintf(lp->phys, "kp_data/input0");
+
+	idev->name = lp->name;
+	idev->phys = lp->phys;
+	idev->id.bustype = BUS_I2C;
+	idev->id.vendor = 0x0001;
+	idev->id.product = 0x0001;
+	idev->id.version = 0x0100;
+
+	input_set_drvdata(idev, lp);
+
+	ret = input_register_device(idev);
+	if (ret) {
+		dev_err(&client->dev, "input_register_device() failed\n");
+		goto fail_register;
+	}
+
+	lp->statechanged = 0x0;
+
+	lp->laststate = read_state(lp);
+
+	/* Set up our workqueue. */
+	INIT_WORK(&lp->pcf8574_kp_work, check_and_notify);
+
+	i2c_set_clientdata(client, lp);
+
+	ret = request_irq(client->irq, pcf8574_kp_irq_handler,
+		IRQF_TRIGGER_LOW, DRV_NAME, lp);
+	if (ret) {
+		dev_err(&client->dev, "IRQ %d is not free\n", client->irq);
+		goto fail_irq;
+	}
+
+	return 0;
+
+ fail_irq:
+	input_unregister_device(idev);
+ fail_register:
+	input_set_drvdata(idev, NULL);
+	input_free_device(idev);
+ fail_allocate:
+	kfree(lp);
+
+	return ret;
+}
+
+static int __devexit pcf8574_kp_remove(struct i2c_client *client)
+{
+	struct kp_data *lp = i2c_get_clientdata(client);
+
+	if (client->irq > 0)
+		free_irq(client->irq, lp);
+
+	input_set_drvdata(lp->idev, NULL);
+	input_unregister_device(lp->idev);
+	kfree(lp);
+
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int pcf8574_kp_resume(struct i2c_client *client)
+{
+	enable_irq(client->irq);
+	return 0;
+}
+
+static int pcf8574_kp_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	disable_irq(client->irq);
+	return 0;
+}
+#else
+# define pcf8574_kp_resume  NULL
+# define pcf8574_kp_suspend NULL
+#endif
+
+static const struct i2c_device_id pcf8574_kp_id[] = {
+	{ DRV_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf8574_kp_id);
+
+static struct i2c_driver pcf8574_kp_driver = {
+	.driver = {
+		.name  = DRV_NAME,
+		.owner = THIS_MODULE
+	},
+	.probe    = pcf8574_kp_probe,
+	.remove   = __devexit_p(pcf8574_kp_remove),
+	.suspend  = pcf8574_kp_suspend,
+	.resume   = pcf8574_kp_resume,
+	.id_table = pcf8574_kp_id,
+};
+
+static int __init pcf8574_kp_init(void)
+{
+	return i2c_add_driver(&pcf8574_kp_driver);
+}
+module_init(pcf8574_kp_init);
+
+static void __exit pcf8574_kp_exit(void)
+{
+	i2c_del_driver(&pcf8574_kp_driver);
+}
+module_exit(pcf8574_kp_exit);
+
+MODULE_AUTHOR("Michael Hennerich");
+MODULE_DESCRIPTION("Keypad input driver for 16 keys connected to PCF8574");
+MODULE_LICENSE("GPL");
-- 
1.7.0.2

