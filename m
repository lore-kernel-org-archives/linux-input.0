From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v2] input: tablet: add Pegasus Notetaker tablet driver
Date: Thu, 19 May 2016 10:49:01 +0200
Message-ID: <1463647741-3107-1-git-send-email-martink@posteo.de>
References: <1463223447-5322-1-git-send-email-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:52335 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012AbcESItT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 04:49:19 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 2321520BE1
	for <linux-input@vger.kernel.org>; Thu, 19 May 2016 10:49:15 +0200 (CEST)
In-Reply-To: <1463223447-5322-1-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

This adds a driver for the Pegasus Notetaker Pen. When connected,
this uses the Pen as an input tablet.

This device was sold in various different brandings, for example
	"Pegasus Mobile Notetaker M210",
	"Genie e-note The Notetaker",
	"Staedtler Digital ballpoint pen 990 01",
	"IRISnotes Express" or
	"NEWLink Digital Note Taker".

Here's an example, so that you know what we are talking about:
http://www.staedtler.com/en/products/ink-writing-instruments/ballpoint-pens/digital-pen-990-01-digital-ballpoint-pen

http://pegatech.blogspot.com/ seems to be a remaining official resource.

This device can also transfer saved (offline recorded handwritten) data and
there are userspace programs that do this, see https://launchpad.net/m210
(Well, alternatively there are really fast scanners out there :)

It's *really* fun to use as an input tablet though! So let's support this
for everybody.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

Any thoughts on this yet? I'd be happy for review. I like it and I'm sure
others would use this too, if available like this.

revision history
================
v2 minor cleanup (remove unnecessary variables)
v1 initial release


 drivers/input/tablet/Kconfig             |  15 ++
 drivers/input/tablet/Makefile            |   1 +
 drivers/input/tablet/pegasus_notetaker.c | 400 +++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/input/tablet/pegasus_notetaker.c

diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index 623bb9e..a2b9f97 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -73,6 +73,21 @@ config TABLET_USB_KBTAB
 	  To compile this driver as a module, choose M here: the
 	  module will be called kbtab.
 
+config TABLET_USB_PEGASUS
+	tristate "Pegasus Mobile Notetaker Pen input tablet support"
+	depends on USB_ARCH_HAS_HCD
+	select USB
+	help
+	  Say Y here if you want to use the Pegasus Mobile Notetaker,
+	  also known as:
+	  Genie e-note The Notetaker,
+	  Staedtler Digital ballpoint pen 990 01,
+	  IRISnotes Express or
+	  NEWLink Digital Note Taker.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pegasus_notetaker.
+
 config TABLET_SERIAL_WACOM4
 	tristate "Wacom protocol 4 serial tablet support"
 	select SERIO
diff --git a/drivers/input/tablet/Makefile b/drivers/input/tablet/Makefile
index 2e13010..200fc4e 100644
--- a/drivers/input/tablet/Makefile
+++ b/drivers/input/tablet/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_TABLET_USB_AIPTEK)	+= aiptek.o
 obj-$(CONFIG_TABLET_USB_GTCO)	+= gtco.o
 obj-$(CONFIG_TABLET_USB_HANWANG) += hanwang.o
 obj-$(CONFIG_TABLET_USB_KBTAB)	+= kbtab.o
+obj-$(CONFIG_TABLET_USB_PEGASUS) += pegasus_notetaker.o
 obj-$(CONFIG_TABLET_SERIAL_WACOM4) += wacom_serial4.o
diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
new file mode 100644
index 0000000..2955b4f
--- /dev/null
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -0,0 +1,400 @@
+/*
+ * Pegasus Mobile Notetaker Pen input tablet driver
+ *
+ * Copyright (c) 2016 Martin Kepplinger <martink@posteo.de>
+ */
+
+/*
+ * request packet (control endpoint):
+ * |-------------------------------------|
+ * | Report ID | Nr of bytes | command   |
+ * | (1 byte)  | (1 byte)    | (n bytes) |
+ * |-------------------------------------|
+ * | 0x02      | n           |           |
+ * |-------------------------------------|
+ *
+ * data packet after set xy mode command, 0x80 0xb5 0x02 0x01
+ * and pen is in range:
+ *
+ * byte	byte name		value (bits)
+ * --------------------------------------------
+ * 0	status			0 1 0 0 0 0 X X
+ * 1	color			0 0 0 0 H 0 S T
+ * 2	X low
+ * 3	X high
+ * 4	Y low
+ * 5	Y high
+ *
+ * X X	battery state:
+ *	no state reported	0x00
+ *	battery low		0x01
+ *	battery good		0x02
+ *
+ * H	Hovering
+ * S	Switch 1 (pen button)
+ * T	Tip
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/hid.h>
+#include <linux/usb/input.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+
+/* USB HID defines */
+#define USB_REQ_GET_REPORT		0x01
+#define USB_REQ_SET_REPORT		0x09
+
+#define USB_VENDOR_ID_PEGASUSTECH	0x0e20
+#define USB_DEVICE_ID_PEGASUS_NOTETAKER_EN100	0x0101
+
+/* device specific defines */
+#define NOTETAKER_REPORT_ID		0x02
+#define NOTETAKER_SET_CMD		0x80
+#define NOTETAKER_SET_MODE		0xb5
+
+#define NOTETAKER_LED_MOUSE             0x02
+#define PEN_MODE_XY                     0x01
+
+#define SPECIAL_COMMAND			0x80
+#define BUTTON_PRESSED			0xb5
+#define COMMAND_VERSION			0xa9
+
+/* in xy data packet */
+#define BATTERY_NO_REPORT		0x40
+#define BATTERY_LOW			0x41
+#define BATTERY_GOOD			0x42
+#define PEN_BUTTON_PRESSED		BIT(1)
+#define PEN_TIP				BIT(0)
+
+static struct task_struct *pegasus_thread;
+static DECLARE_WAIT_QUEUE_HEAD(pegasus_wait);
+
+struct pegasus {
+	unsigned char *data;
+	u8 data_len;
+	dma_addr_t data_dma;
+	struct input_dev *dev;
+	struct usb_device *usbdev;
+	struct urb *irq;
+	char name[128];
+	char phys[64];
+};
+
+static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
+{
+	const int sizeof_buf = len * sizeof(u8) + 2;
+	int result;
+	u8 *cmd_buf;
+
+	cmd_buf = kmalloc(sizeof_buf, GFP_KERNEL);
+	if (!cmd_buf)
+		return;
+
+	cmd_buf[0] = NOTETAKER_REPORT_ID;
+	cmd_buf[1] = len;
+	memcpy(cmd_buf + 2, data, len);
+
+	result = usb_control_msg(pegasus->usbdev,
+				 usb_sndctrlpipe(pegasus->usbdev, 0),
+				 USB_REQ_SET_REPORT,
+				 USB_TYPE_VENDOR | USB_DIR_OUT,
+				 0, 0, cmd_buf, sizeof_buf,
+				 USB_CTRL_SET_TIMEOUT);
+
+	if (result != sizeof_buf)
+		dev_err(&pegasus->usbdev->dev, "control msg error\n");
+
+	kfree(cmd_buf);
+}
+
+static void pegasus_set_mode(struct pegasus *pegasus, u8 mode, u8 led)
+{
+	static u8 cmd[4] = {NOTETAKER_SET_CMD, NOTETAKER_SET_MODE, 0x00, 0x00};
+
+	cmd[2] = led;
+	cmd[3] = mode;
+
+	pegasus_control_msg(pegasus, cmd, sizeof(cmd));
+}
+
+static void pegasus_parse_packet(struct pegasus *pegasus)
+{
+	unsigned char *data = pegasus->data;
+	struct input_dev *dev = pegasus->dev;
+	u16 x, y = 0;
+
+	switch (data[0]) {
+	case SPECIAL_COMMAND:
+		/* device button pressed */
+		if (data[1] == BUTTON_PRESSED)
+			wake_up(&pegasus_wait);
+
+		break;
+	/* xy data */
+	case BATTERY_NO_REPORT:
+	case BATTERY_LOW:
+		dev_warn_once(&dev->dev, "Pen battery low\n");
+	case BATTERY_GOOD:
+		memcpy(&x, data + 2, 2);
+		memcpy(&y, data + 4, 2);
+
+		/* ignore pen up events */
+		if (x == 0 && y == 0)
+			break;
+
+		if (data[1] & PEN_BUTTON_PRESSED) {
+			input_report_key(dev, BTN_TOUCH, 0);
+			input_report_key(dev, BTN_RIGHT, 1);
+		} else if (data[1] & PEN_TIP) {
+			input_report_key(dev, BTN_TOUCH, 1);
+			input_report_key(dev, BTN_RIGHT, 0);
+		} else {
+			input_report_key(dev, BTN_TOUCH, 0);
+			input_report_key(dev, BTN_RIGHT, 0);
+		}
+
+		input_report_key(dev, BTN_TOOL_PEN, 1);
+		input_report_abs(dev, ABS_X, (s16)le16_to_cpu(x));
+		input_report_abs(dev, ABS_Y, le16_to_cpu(y));
+
+		input_sync(dev);
+		break;
+	default:
+		dev_warn_once(&pegasus->usbdev->dev,
+			      "unknown answer from device\n");
+	}
+}
+
+static void pegasus_irq(struct urb *urb)
+{
+	struct pegasus *pegasus = urb->context;
+	struct usb_device *dev = pegasus->usbdev;
+	int retval;
+
+	switch (urb->status) {
+	case 0:
+		pegasus_parse_packet(pegasus);
+		usb_mark_last_busy(pegasus->usbdev);
+
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		dev_err(&dev->dev, "%s - urb shutting down with status: %d",
+			__func__, urb->status);
+		return;
+	default:
+		dev_err(&dev->dev, "%s - nonzero urb status received: %d",
+			__func__, urb->status);
+		break;
+	}
+
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (retval)
+		dev_err(&dev->dev, "%s - usb_submit_urb failed with result %d",
+			__func__, retval);
+}
+
+/* initialize device on startup and device button pressed */
+static int pegasus_threadf(void *data)
+{
+	struct pegasus *pegasus = data;
+
+	DEFINE_WAIT(wait);
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+
+		pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
+
+		prepare_to_wait(&pegasus_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+	}
+
+	finish_wait(&pegasus_wait, &wait);
+
+	return 0;
+}
+
+static int pegasus_open(struct input_dev *dev)
+{
+	struct pegasus *pegasus = input_get_drvdata(dev);
+
+	pegasus->irq->dev = pegasus->usbdev;
+	if (usb_submit_urb(pegasus->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void pegasus_close(struct input_dev *dev)
+{
+	struct pegasus *pegasus = input_get_drvdata(dev);
+
+	usb_kill_urb(pegasus->irq);
+}
+
+static int pegasus_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *endpoint;
+	struct pegasus *pegasus;
+	struct input_dev *input_dev;
+	int error;
+	int pipe, maxp;
+
+	/* we control interface 0 */
+	if (intf->cur_altsetting->desc.bInterfaceNumber == 1)
+		return -ENODEV;
+
+	endpoint = &intf->cur_altsetting->endpoint[0].desc;
+
+	pegasus = kzalloc(sizeof(*pegasus), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!pegasus || !input_dev) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	pegasus->usbdev = dev;
+	pegasus->dev = input_dev;
+
+	pegasus->data = usb_alloc_coherent(dev, endpoint->wMaxPacketSize,
+					   GFP_KERNEL, &pegasus->data_dma);
+	if (!pegasus->data) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	pegasus->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!pegasus->irq) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
+	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
+	pegasus->data_len = maxp;
+
+	usb_fill_int_urb(pegasus->irq, dev, pipe, pegasus->data, maxp,
+			 pegasus_irq, pegasus, endpoint->bInterval);
+
+	pegasus->irq->transfer_dma = pegasus->data_dma;
+	pegasus->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	if (dev->manufacturer)
+		strlcpy(pegasus->name, dev->manufacturer,
+			sizeof(pegasus->name));
+
+	if (dev->product) {
+		if (dev->manufacturer)
+			strlcat(pegasus->name, " ", sizeof(pegasus->name));
+		strlcat(pegasus->name, dev->product, sizeof(pegasus->name));
+	}
+
+	if (!strlen(pegasus->name))
+		snprintf(pegasus->name, sizeof(pegasus->name),
+			 "USB Pegasus Device %04x:%04x",
+			 le16_to_cpu(dev->descriptor.idVendor),
+			 le16_to_cpu(dev->descriptor.idProduct));
+
+	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
+	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
+
+	usb_set_intfdata(intf, pegasus);
+
+	input_dev->name = pegasus->name;
+	input_dev->phys = pegasus->phys;
+	usb_to_input_id(dev, &input_dev->id);
+	input_dev->dev.parent = &intf->dev;
+
+	input_set_drvdata(input_dev, pegasus);
+
+	input_dev->open = pegasus_open;
+	input_dev->close = pegasus_close;
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+
+	__set_bit(ABS_X, input_dev->absbit);
+	__set_bit(ABS_Y, input_dev->absbit);
+
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+	__set_bit(BTN_RIGHT, input_dev->keybit);
+	__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+	input_set_abs_params(input_dev, ABS_X, -1500, 1500, 8, 0);
+	input_set_abs_params(input_dev, ABS_Y, 1600, 3000, 8, 0);
+
+	error = input_register_device(pegasus->dev);
+	if (error)
+		goto err_free_dma;
+
+	pegasus_thread = kthread_run(pegasus_threadf, pegasus,
+				     "pegasus_notetaker_thread");
+	if (IS_ERR(pegasus_thread)) {
+		error = -ENOMEM;
+		goto err_free_dma;
+	}
+
+	return 0;
+
+err_free_dma:
+	usb_free_coherent(dev, pegasus->data_len,
+			  pegasus->data, pegasus->data_dma);
+
+	usb_free_urb(pegasus->irq);
+err_free_mem:
+	kfree(pegasus);
+	usb_set_intfdata(intf, NULL);
+
+	return error;
+}
+
+static void pegasus_disconnect(struct usb_interface *intf)
+{
+	struct pegasus *pegasus = usb_get_intfdata(intf);
+
+	input_unregister_device(pegasus->dev);
+	if (pegasus_thread) {
+		if (kthread_stop(pegasus_thread) == -EINTR)
+			dev_err(&pegasus->usbdev->dev,
+				"wake_up_proc was never called\n");
+	}
+
+	usb_free_urb(pegasus->irq);
+	usb_free_coherent(interface_to_usbdev(intf),
+			  pegasus->data_len, pegasus->data,
+			  pegasus->data_dma);
+	kfree(pegasus);
+	usb_set_intfdata(intf, NULL);
+}
+
+static const struct usb_device_id pegasus_ids[] = {
+	{ USB_DEVICE(USB_VENDOR_ID_PEGASUSTECH,
+		     USB_DEVICE_ID_PEGASUS_NOTETAKER_EN100) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, pegasus_ids);
+
+static struct usb_driver pegasus_driver = {
+	.name		= "pegasus_notetaker",
+	.probe		= pegasus_probe,
+	.disconnect	= pegasus_disconnect,
+	.id_table	= pegasus_ids,
+};
+
+module_usb_driver(pegasus_driver);
+
+MODULE_AUTHOR("Martin Kepplinger <martink@posteo.de>");
+MODULE_DESCRIPTION("Pegasus Mobile Notetaker Pen tablet driver");
+MODULE_LICENSE("GPL");
-- 
2.1.4

