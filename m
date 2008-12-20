From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: [PATCH] sh: maple: add Maple controller as a joystick device
Date: Sat, 20 Dec 2008 18:26:54 +0000
Message-ID: <1229797614.6502.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org

Now with proper checks for NULL pointers.


sh: maple: add Maple controller as joystick device

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index be5c14a..ca7ce42 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -294,4 +294,17 @@ config JOYSTICK_XPAD_LEDS
 	  This option enables support for the LED which surrounds the Big X on
 	  XBox 360 controller.
 
+config JOYSTICK_MAPLE
+	tristate "Dreamcast control pad"
+	depends on SH_DREAMCAST
+	select MAPLE
+	help
+	  Say Y here if you have a SEGA Dreamcast and want to use your
+	  controller as a joystick.
+
+	  Most Dreamcast users will say Y.
+
+	  To compile this as a module choose M here: the module will be called
+	  maplecontrol.
+
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index fdbf8c4..bfd848d 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_JOYSTICK_AMIGA)		+= amijoy.o
 obj-$(CONFIG_JOYSTICK_ANALOG)		+= analog.o
 obj-$(CONFIG_JOYSTICK_COBRA)		+= cobra.o
 obj-$(CONFIG_JOYSTICK_DB9)		+= db9.o
+obj-$(CONFIG_JOYSTICK_MAPLE)		+= maplecontrol.o
 obj-$(CONFIG_JOYSTICK_GAMECON)		+= gamecon.o
 obj-$(CONFIG_JOYSTICK_GF2K)		+= gf2k.o
 obj-$(CONFIG_JOYSTICK_GRIP)		+= grip.o
diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
new file mode 100644
index 0000000..ca7d438
--- /dev/null
+++ b/drivers/input/joystick/maplecontrol.c
@@ -0,0 +1,211 @@
+/*
+ * 	SEGA Dreamcast controller driver
+ *	Based on drivers/usb/iforce.c
+ *
+ * 	Copyright Yaegashi Takeshi, 2001
+ *	Adrian McMenamin, 2008
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/maple.h>
+
+MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
+MODULE_DESCRIPTION("SEGA Dreamcast controller driver");
+MODULE_LICENSE("GPL");
+
+struct dc_pad {
+	struct input_dev *dev;
+	struct maple_device *mdev;
+};
+
+static void dc_pad_callback(struct mapleq *mq)
+{
+	unsigned short buttons;
+	struct maple_device *mapledev = mq->dev;
+	struct dc_pad *pad = maple_get_drvdata(mapledev);
+	struct input_dev *dev = pad->dev;
+	unsigned char *res = mq->recvbuf;
+
+	buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
+
+	input_report_abs(dev, ABS_HAT0Y,
+			 (buttons & 0x0010 ? -1:0) + (buttons & 0x0020 ? 1:0));
+	input_report_abs(dev, ABS_HAT0X,
+			 (buttons & 0x0040 ? -1:0) + (buttons & 0x0080 ? 1:0));
+	input_report_abs(dev, ABS_HAT1Y,
+			 (buttons & 0x1000 ? -1:0) + (buttons & 0x2000 ? 1:0));
+	input_report_abs(dev, ABS_HAT1X,
+			 (buttons & 0x4000 ? -1:0) + (buttons & 0x8000 ? 1:0));
+
+	input_report_key(dev, BTN_C,      buttons & 0x0001);
+	input_report_key(dev, BTN_B,      buttons & 0x0002);
+	input_report_key(dev, BTN_A,      buttons & 0x0004);
+	input_report_key(dev, BTN_START,  buttons & 0x0008);
+	input_report_key(dev, BTN_Z,      buttons & 0x0100);
+	input_report_key(dev, BTN_Y,      buttons & 0x0200);
+	input_report_key(dev, BTN_X,      buttons & 0x0400);
+	input_report_key(dev, BTN_SELECT, buttons & 0x0800);
+
+	input_report_abs(dev, ABS_GAS,   res[10]);
+	input_report_abs(dev, ABS_BRAKE, res[11]);
+	input_report_abs(dev, ABS_X,     res[12]);
+	input_report_abs(dev, ABS_Y,     res[13]);
+	input_report_abs(dev, ABS_RX,    res[14]);
+	input_report_abs(dev, ABS_RY,    res[15]);
+}
+
+static int dc_pad_open(struct input_dev *dev)
+{
+	struct dc_pad *pad;
+
+	pad = dev->dev.platform_data;
+	maple_getcond_callback(pad->mdev, dc_pad_callback, HZ/20,
+		MAPLE_FUNC_CONTROLLER);
+	return 0;
+}
+
+static void dc_pad_close(struct input_dev *dev)
+{
+	struct dc_pad *pad;
+	
+	pad = dev->dev.platform_data;
+	maple_getcond_callback(pad->mdev, dc_pad_callback, 0,
+		MAPLE_FUNC_CONTROLLER);
+}
+
+/* allow the controller to be used */
+static int probe_maple_controller(struct device *dev)
+{
+	struct maple_device *mdev;
+	struct maple_driver *mdrv;
+	int i, error;
+	struct dc_pad *pad;
+	struct input_dev *idev;
+	unsigned long data;
+	const short btn_bit[32] = {
+		BTN_C, BTN_B, BTN_A, BTN_START, -1, -1, -1, -1,
+		BTN_Z, BTN_Y, BTN_X, BTN_SELECT, -1, -1, -1, -1,
+		-1, -1, -1, -1, -1, -1, -1, -1,
+		-1, -1, -1, -1, -1, -1, -1, -1,
+	};
+	const short abs_bit[32] = {
+		-1, -1, -1, -1, ABS_HAT0Y, ABS_HAT0Y, ABS_HAT0X, ABS_HAT0X,
+		-1, -1, -1, -1, ABS_HAT1Y, ABS_HAT1Y, ABS_HAT1X, ABS_HAT1X,
+		ABS_GAS, ABS_BRAKE, ABS_X, ABS_Y, ABS_RX, ABS_RY, -1, -1,
+		-1, -1, -1, -1, -1, -1, -1, -1,
+	};
+
+	mdev = to_maple_dev(dev);
+	if (!mdev) {
+		error = EINVAL;
+		goto fail;
+	}
+	
+	mdrv = to_maple_driver(dev->driver);
+	if (!mdrv) {
+		error = EINVAL;
+		goto fail;
+	}
+
+	data = be32_to_cpu(mdev->devinfo.function_data[0]);
+
+	pad = kzalloc(sizeof(struct dc_pad), GFP_KERNEL);
+	if (!pad) {
+		error = ENOMEM;
+		goto fail;
+	}
+	idev = input_allocate_device();
+	if (!idev){
+		error = ENOMEM;
+		goto fail_idev;
+	}
+
+	pad->dev = idev;
+	pad->mdev = mdev;
+
+	idev->open = dc_pad_open;
+	idev->close = dc_pad_close;
+
+	for (i = 0; i < 32; i++)
+		if (data & (1<<i) && btn_bit[i] >= 0)
+			idev->keybit[BIT_WORD(BTN_JOYSTICK)] |= BIT_MASK(btn_bit[i]);
+
+	if (idev->keybit[BTN_JOYSTICK/32])
+		idev->evbit[0] |= BIT_MASK(EV_KEY);
+
+	for (i = 0; i < 32; i++)
+		if (data & (1<<i) && abs_bit[i] >= 0)
+			idev->absbit[0] |= BIT_MASK(abs_bit[i]);
+
+	if (idev->absbit[0])
+		idev->evbit[0] |= BIT_MASK(EV_ABS);
+
+	for (i = ABS_X; i <= ABS_BRAKE; i++)
+		input_set_abs_params(idev, i, 0, 255, 0, 0);
+
+	for (i = ABS_HAT0X; i <= ABS_HAT3Y; i++)
+		input_set_abs_params(idev, i, 1, -1, 0, 0);
+
+	idev->dev.platform_data = pad;
+	idev->event = NULL;
+	idev->dev.parent = &mdev->dev;
+	idev->name = mdev->product_name;
+	idev->id.bustype = BUS_HOST;
+	input_set_drvdata(idev, pad);
+
+	error = input_register_device(idev);
+	if (error)
+		goto fail_register;
+
+	mdev->driver = mdrv;
+	maple_set_drvdata(mdev, pad);
+
+	return error;
+
+fail_register:
+	maple_set_drvdata(mdev, NULL);
+	input_free_device(pad->dev);
+fail_idev:
+	kfree(pad);
+fail:
+	return -error;
+}
+
+static int remove_maple_controller(struct device *dev)
+{
+	struct maple_device *mdev = to_maple_dev(dev);
+	struct dc_pad *pad = maple_get_drvdata(mdev);
+
+	mdev->callback = NULL;
+	input_unregister_device(pad->dev);
+	maple_set_drvdata(mdev, NULL);
+	kfree(pad);
+	return 0;
+}
+
+static struct maple_driver dc_pad_driver = {
+	.function =	MAPLE_FUNC_CONTROLLER,
+	.drv = {
+		.name = "Dreamcast_controller",
+		.probe = probe_maple_controller,
+		.remove = remove_maple_controller,
+	},
+};
+
+static int __init dc_pad_init(void)
+{
+	return 	maple_driver_register(&dc_pad_driver);
+}
+
+static void __exit dc_pad_exit(void)
+{
+	maple_driver_unregister(&dc_pad_driver);
+}
+
+module_init(dc_pad_init);
+module_exit(dc_pad_exit);

