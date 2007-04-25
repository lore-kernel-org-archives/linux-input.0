From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Add Cobalt button interface driver support
Date: Wed, 25 Apr 2007 01:34:33 -0400
Message-ID: <200704250134.33610.dtor@insightbb.com>
References: <20070216123608.733f04a3.yoichi_yuasa@tripeaks.co.jp> <200704040001.41494.dtor@insightbb.com> <200704050502.l3552gss048910@mbox31.po.2iij.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_phuLG8S2DLlxZT6"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704050502.l3552gss048910@mbox31.po.2iij.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

--Boundary-00=_phuLG8S2DLlxZT6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Yoichi,

On Thursday 05 April 2007 01:02, Yoichi Yuasa wrote:
> Hi Dmitry,
> 
> On Wed, 4 Apr 2007 00:01:41 -0400
> Dmitry Torokhov <dtor@insightbb.com> wrote:
> 
> > Hi Yoichi,
> > 
> > Could you please try the patch below? It moves platform device creation
> > code into cobalt arch code to belletr follow driver model.
> 
> It works fine.
>

Coudl you please try couple more patches, please? I wrote a generic
stub for polled (as opposed to interrupt-driven) input devices and
converting existing drivers to use it. Cobalt buttons seem to be
a good candidate...
  
Thank you in advance.

-- 
Dmitry


--Boundary-00=_phuLG8S2DLlxZT6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="polled-button.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="polled-button.patch"

Subject: XXX
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig         |   11 ++
 drivers/input/misc/Makefile        |    1 
 drivers/input/misc/input-polldev.c |  171 +++++++++++++++++++++++++++++++++++++
 include/linux/input-polldev.h      |   46 +++++++++
 4 files changed, 229 insertions(+)

Index: work/drivers/input/misc/Kconfig
===================================================================
--- work.orig/drivers/input/misc/Kconfig
+++ work/drivers/input/misc/Kconfig
@@ -90,6 +90,17 @@ config INPUT_UINPUT
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
+config INPUT_POLLDEV
+	tristate "Polled input device skeleton"
+	help
+	  Say Y here if you are using a driver for an input
+	  device that periodically polls hardware state. This
+	  option is only useful for out-of-tree drivers since
+	  in-tree drivers select it automatically.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called input-polldev.
+
 config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on GSC || HP300
Index: work/drivers/input/misc/Makefile
===================================================================
--- work.orig/drivers/input/misc/Makefile
+++ work/drivers/input/misc/Makefile
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_INPUT_POLLDEV)		+= input-polldev.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
Index: work/drivers/input/misc/input-polldev.c
===================================================================
--- /dev/null
+++ work/drivers/input/misc/input-polldev.c
@@ -0,0 +1,171 @@
+/*
+ * Generic implementation of a polled input device
+
+ * Copyright (c) 2007 Dmitry Torokhov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/input-polldev.h>
+
+static DEFINE_MUTEX(polldev_mutex);
+static int polldev_users;
+static struct workqueue_struct *polldev_wq;
+
+static int input_polldev_start_workqueue(void)
+{
+	int retval;
+
+	retval = mutex_lock_interruptible(&polldev_mutex);
+	if (retval)
+		return retval;
+
+	if (!polldev_users) {
+		polldev_wq = create_singlethread_workqueue("ipolldevd");
+		if (!polldev_wq) {
+			printk(KERN_ERR "input-polldev: failed to create "
+				"ipolldevd workqueue\n");
+			retval = -ENOMEM;
+			goto out;
+		}
+	}
+
+	polldev_users++;
+
+ out:
+	mutex_unlock(&polldev_mutex);
+	return retval;
+}
+
+static void input_polldev_stop_workqueue(void)
+{
+	mutex_lock(&polldev_mutex);
+
+	if (!--polldev_users)
+		destroy_workqueue(polldev_wq);
+
+	mutex_unlock(&polldev_mutex);
+}
+
+static void input_polled_device_work(struct work_struct *work)
+{
+	struct input_polled_dev *dev =
+		container_of(work, struct input_polled_dev, work.work);
+
+	dev->poll(dev);
+	queue_delayed_work(polldev_wq, &dev->work,
+			   msecs_to_jiffies(dev->poll_interval));
+}
+
+static int input_open_polled_device(struct input_dev *input)
+{
+	struct input_polled_dev *dev = input->private;
+	int error;
+
+	error = input_polldev_start_workqueue();
+	if (error)
+		return error;
+
+	if (dev->flush)
+		dev->flush(dev);
+
+	queue_delayed_work(polldev_wq, &dev->work,
+			   msecs_to_jiffies(dev->poll_interval));
+
+	return 0;
+}
+
+static void input_close_polled_device(struct input_dev *input)
+{
+	struct input_polled_dev *dev = input->private;
+
+	cancel_rearming_delayed_workqueue(polldev_wq, &dev->work);
+	input_polldev_stop_workqueue();
+}
+
+/**
+ * input_allocate_polled_device - allocated memory polled device
+ *
+ * The function allocates memory for a polled device and also
+ * for an input device associated with this polled device.
+ */
+struct input_polled_dev *input_allocate_polled_device(void)
+{
+	struct input_polled_dev *dev;
+
+	dev = kzalloc(sizeof(struct input_polled_dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	dev->input = input_allocate_device();
+	if (!dev->input) {
+		kfree(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(input_allocate_polled_device);
+
+/**
+ * input_free_polled_device - free memory allocated for polled device
+ * @dev: device to free
+ *
+ * The function frees memory allocated for pollign device and drops
+ * reference to the associated input device (if present).
+ */
+void input_free_polled_device(struct input_polled_dev *dev)
+{
+	if (dev) {
+		input_free_device(dev->input);
+		kfree(dev);
+	}
+}
+EXPORT_SYMBOL(input_free_polled_device);
+
+/**
+ * input_register_polled_device - register polled device
+ * @dev: device to register
+ *
+ * The function registers previously initialized polled input device
+ * with input layer. The device should be allocated with call to
+ * input_allocate_polled_device(). Callers should also set up poll()
+ * method and set up capabilities (id, name, phys, bits) of the
+ * corresponing input_dev structure.
+ */
+int input_register_polled_device(struct input_polled_dev *dev)
+{
+	struct input_dev *input = dev->input;
+
+	INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
+	if (!dev->poll_interval)
+		dev->poll_interval = 500;
+	input->private = dev;
+	input->open = input_open_polled_device;
+	input->close = input_close_polled_device;
+
+	return input_register_device(input);
+}
+EXPORT_SYMBOL(input_register_polled_device);
+
+/**
+ * input_unregister_polled_device - unregister polled device
+ * @dev: device to unregister
+ *
+ * The function unregisters previously registered polled input
+ * device from input layer. Polling is stopped and device is
+ * ready to be freed with call to input_free_polled_device().
+ * Callers should not attempt to access dev->input pointer
+ * after calling this function.
+ */
+void input_unregister_polled_device(struct input_polled_dev *dev)
+{
+	input_unregister_device(dev->input);
+	dev->input = NULL;
+}
+EXPORT_SYMBOL(input_unregister_polled_device);
+
Index: work/include/linux/input-polldev.h
===================================================================
--- /dev/null
+++ work/include/linux/input-polldev.h
@@ -0,0 +1,46 @@
+#ifndef _INPUT_POLLDEV_H
+#define _INPUT_POLLDEV_H
+
+/*
+ * Copyright (c) 2007 Dmitry Torokhov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/input.h>
+#include <linux/workqueue.h>
+
+/**
+ * struct input_polled_dev - simple polled input device
+ * @private: private driver data
+ * @flush: driver-supplied method that flushes device's state upon
+ *	opening (optional)
+ * @poll: driver-supplied method that polls the device and posts
+ *	input events (mandatory).
+ * @poll_interval: specifies how often the poll() method shoudl be called.
+ * @input: input device structire associated with the polled device.
+ *	Must be properly initialized by the driver (id, name, phys, bits).
+ *
+ * Polled input device provides a skeleton for supporting simple input
+ * devices that do not raise interrupts but have to be periodically
+ * scanned to detect changes in their state.
+ */
+struct input_polled_dev {
+	void *private;
+
+	void (*flush)(struct input_polled_dev *dev);
+	void (*poll)(struct input_polled_dev *dev);
+	unsigned int poll_interval; /* msec */
+
+	struct input_dev *input;
+	struct delayed_work work;
+};
+
+struct input_polled_dev *input_allocate_polled_device(void);
+void input_free_polled_device(struct input_polled_dev *dev);
+int input_register_polled_device(struct input_polled_dev *dev);
+void input_unregister_polled_device(struct input_polled_dev *dev);
+
+#endif

--Boundary-00=_phuLG8S2DLlxZT6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cobalt-to-polldev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cobalt-to-polldev.patch"

Subject: XXX
Input: cobalt_btns - convert to use polldev library

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig       |    1 
 drivers/input/misc/cobalt_btns.c |   59 ++++++++++++++-------------------------
 2 files changed, 23 insertions(+), 37 deletions(-)

Index: work/drivers/input/misc/cobalt_btns.c
===================================================================
--- work.orig/drivers/input/misc/cobalt_btns.c
+++ work/drivers/input/misc/cobalt_btns.c
@@ -18,19 +18,17 @@
  *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/init.h>
-#include <linux/input.h>
+#include <linux/input-polldev.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/jiffies.h>
-#include <linux/timer.h>
 
 #define BUTTONS_POLL_INTERVAL	30	/* msec */
 #define BUTTONS_COUNT_THRESHOLD	3
 #define BUTTONS_STATUS_MASK	0xfe000000
 
 struct buttons_dev {
-	struct input_dev *input;
+	struct input_polled_dev *poll_dev;
 	void __iomem *reg;
 };
 
@@ -50,16 +48,14 @@ static struct buttons_map buttons_map[] 
 	{ 0x80000000, KEY_SELECT, },
 };
 
-static struct timer_list buttons_timer;
-
-static void handle_buttons(unsigned long data)
+static void handle_buttons(struct input_polled_dev *dev)
 {
 	struct buttons_map *button = buttons_map;
-	struct buttons_dev *bdev;
+	struct buttons_dev *bdev = dev->private;
+	struct input_dev *input = dev->input;
 	uint32_t status;
 	int i;
 
-	bdev = (struct buttons_dev *)data;
 	status = readl(bdev->reg);
 	status = ~status & BUTTONS_STATUS_MASK;
 
@@ -68,55 +64,45 @@ static void handle_buttons(unsigned long
 			button->count++;
 		} else {
 			if (button->count >= BUTTONS_COUNT_THRESHOLD) {
-				input_report_key(bdev->input, button->keycode, 0);
-				input_sync(bdev->input);
+				input_report_key(input, button->keycode, 0);
+				input_sync(input);
 			}
 			button->count = 0;
 		}
 
 		if (button->count == BUTTONS_COUNT_THRESHOLD) {
-			input_report_key(bdev->input, button->keycode, 1);
-			input_sync(bdev->input);
+			input_report_key(input, button->keycode, 1);
+			input_sync(input);
 		}
 
 		button++;
 	}
-
-	mod_timer(&buttons_timer, jiffies + msecs_to_jiffies(BUTTONS_POLL_INTERVAL));
-}
-
-static int cobalt_buttons_open(struct input_dev *dev)
-{
-	mod_timer(&buttons_timer, jiffies + msecs_to_jiffies(BUTTONS_POLL_INTERVAL));
-
-	return 0;
-}
-
-static void cobalt_buttons_close(struct input_dev *dev)
-{
-	del_timer_sync(&buttons_timer);
 }
 
 static int __devinit cobalt_buttons_probe(struct platform_device *pdev)
 {
 	struct buttons_dev *bdev;
+	struct input_polled_dev *poll_dev;
 	struct input_dev *input;
 	struct resource *res;
 	int error, i;
 
 	bdev = kzalloc(sizeof(struct buttons_dev), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!bdev || !input) {
+	poll_dev = input_allocate_polled_device();
+	if (!bdev || !poll_dev) {
 		error = -ENOMEM;
 		goto err_free_mem;
 	}
 
+	poll_dev->private = bdev;
+	poll_dev->poll = handle_buttons;
+	poll_dev->poll_interval = BUTTONS_POLL_INTERVAL;
+
+	input = poll_dev->input;
 	input->name = "Cobalt buttons";
 	input->phys = "cobalt/input0";
 	input->id.bustype = BUS_HOST;
 	input->cdev.dev = &pdev->dev;
-	input->open = cobalt_buttons_open;
-	input->close = cobalt_buttons_close;
 
 	input->evbit[0] = BIT(EV_KEY);
 	for (i = 0; i < ARRAY_SIZE(buttons_map); i++) {
@@ -130,13 +116,11 @@ static int __devinit cobalt_buttons_prob
 		goto err_free_mem;
 	}
 
-	bdev->input = input;
+	bdev->poll_dev = poll_dev;
 	bdev->reg = ioremap(res->start, res->end - res->start + 1);
 	dev_set_drvdata(&pdev->dev, bdev);
 
-	setup_timer(&buttons_timer, handle_buttons, (unsigned long)bdev);
-
-	error = input_register_device(input);
+	error = input_register_polled_device(poll_dev);
 	if (error)
 		goto err_iounmap;
 
@@ -145,7 +129,7 @@ static int __devinit cobalt_buttons_prob
  err_iounmap:
 	iounmap(bdev->reg);
  err_free_mem:
-	input_free_device(input);
+	input_free_polled_device(poll_dev);
 	kfree(bdev);
 	dev_set_drvdata(&pdev->dev, NULL);
 	return error;
@@ -156,7 +140,8 @@ static int __devexit cobalt_buttons_remo
 	struct device *dev = &pdev->dev;
 	struct buttons_dev *bdev = dev_get_drvdata(dev);
 
-	input_unregister_device(bdev->input);
+	input_unregister_polled_device(bdev->poll_dev);
+	input_free_polled_device(bdev->poll_dev);
 	iounmap(bdev->reg);
 	kfree(bdev);
 	dev_set_drvdata(dev, NULL);
Index: work/drivers/input/misc/Kconfig
===================================================================
--- work.orig/drivers/input/misc/Kconfig
+++ work/drivers/input/misc/Kconfig
@@ -43,6 +43,7 @@ config INPUT_M68K_BEEP
 config INPUT_COBALT_BTNS
 	tristate "Cobalt button interface"
 	depends on MIPS_COBALT
+	select INPUT_POLLDEV
 	help
 	  Say Y here if you want to support MIPS Cobalt button interface.
 

--Boundary-00=_phuLG8S2DLlxZT6--
