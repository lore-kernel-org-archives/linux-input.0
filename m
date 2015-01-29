From: Thomas Sanchez <thomas.sanchz@gmail.com>
Subject: [PATCH] drivers: input: mouse: Add Foxconn's CNTouch driver
Date: Thu, 29 Jan 2015 17:22:50 +0100
Message-ID: <1422548570-19080-2-git-send-email-thomas.sanchz@gmail.com>
References: <1422547421-28052-1-git-send-email-thomas.sanchz@gmail.com>
 <1422548570-19080-1-git-send-email-thomas.sanchz@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49494 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbbA2QXT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 11:23:19 -0500
Received: by mail-wi0-f179.google.com with SMTP id l15so26675681wiw.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 08:23:17 -0800 (PST)
In-Reply-To: <1422548570-19080-1-git-send-email-thomas.sanchz@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Thomas Sanchez <thomas.sanchz@gmail.com>

This commit introduces a new driver for Foxconn CNTouch trackpad that
can be found on LDLC's laptop IRIS family.  The driver has been inspired
from usbmouse.c.

Signed-off-by: Thomas Sanchez <thomas.sanchz@gmail.com>
---
 drivers/input/mouse/Kconfig       |  11 ++
 drivers/input/mouse/Makefile      |   1 +
 drivers/input/mouse/foxconn_usb.c | 206 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/input/mouse/foxconn_usb.c

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index d8b46b0..3ccb924 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -403,4 +403,15 @@ config MOUSE_NAVPOINT_PXA27x
 	  To compile this driver as a module, choose M here: the
 	  module will be called navpoint.
 
+config MOUSE_FOXCONN_CNTOUCH
+	tristate "Foxconn CNTouch USB device support"
+	depends on USB_ARCH_HAS_HCD
+	select USB
+	help
+	  This driver adds support for the Foxconn CNTouch trackpad present for
+	  instance on IRIS laptop family from LDLC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called foxconn_usb.
+
 endif
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 560003d..4bfcc75 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MOUSE_ATARI)		+= atarimouse.o
 obj-$(CONFIG_MOUSE_BCM5974)		+= bcm5974.o
 obj-$(CONFIG_MOUSE_CYAPA)		+= cyapa.o
 obj-$(CONFIG_MOUSE_ELAN_I2C)		+= elan_i2c.o
+obj-$(CONFIG_MOUSE_FOXCONN_CNTOUCH)	+= foxconn_usb.o
 obj-$(CONFIG_MOUSE_GPIO)		+= gpio_mouse.o
 obj-$(CONFIG_MOUSE_INPORT)		+= inport.o
 obj-$(CONFIG_MOUSE_LOGIBM)		+= logibm.o
diff --git a/drivers/input/mouse/foxconn_usb.c b/drivers/input/mouse/foxconn_usb.c
new file mode 100644
index 0000000..d05d03e
--- /dev/null
+++ b/drivers/input/mouse/foxconn_usb.c
@@ -0,0 +1,206 @@
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/input.h>
+
+#define USB_VENDOR_ID_FOXCONN		0x294e
+#define USB_DEVICE_ID_FOXCONN_CNTOUCH	0x1001
+
+#define DRIVER_DESC	"CNTouch USB Driver"
+
+static const struct usb_device_id cntouch_devices[] = {
+	{USB_DEVICE(USB_VENDOR_ID_FOXCONN, USB_DEVICE_ID_FOXCONN_CNTOUCH)},
+	{},
+};
+
+MODULE_AUTHOR("Thomas Sanchez, thomas.sanchz@gmail.com");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(usb, cntouch_devices);
+
+struct cntouch_device {
+	struct usb_device *usb_dev;
+	struct input_dev *input_dev;
+	struct urb *irq;
+	signed char *data;
+	dma_addr_t data_dma;
+	char usb_path[64];
+};
+
+static void cntouch_irq(struct urb *urb)
+{
+	struct cntouch_device *cn_dev = urb->context;
+	signed char *data = cn_dev->data;
+	struct input_dev *dev = cn_dev->input_dev;
+	int status;
+
+	switch (urb->status) {
+	case 0:
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		return;
+	default:
+		goto resubmit;
+	}
+
+	input_report_key(dev, BTN_LEFT, data[0] & 0x01);
+	input_report_key(dev, BTN_RIGHT, data[0] & 0x02);
+
+	/*
+	 * when scrolling horizontally with two fingers, data[4] is used but I
+	 * did not find the right mapping...
+	 */
+	input_report_key(dev, BTN_TOOL_FINGER, data[4] == 0 ? 1 : 2);
+
+	input_report_rel(dev, REL_X, data[1]);
+	input_report_rel(dev, REL_Y, data[2]);
+
+	input_report_rel(dev, REL_WHEEL, data[3]);
+
+	input_sync(dev);
+
+resubmit:
+	status = usb_submit_urb(urb, GFP_ATOMIC);
+	if (status) {
+		dev_err(&cn_dev->usb_dev->dev,
+			"can't resubmit intr, %s-%s/input0, status %d\n",
+			cn_dev->usb_dev->bus->bus_name,
+			cn_dev->usb_dev->devpath, status);
+	}
+}
+
+static int cntouch_open(struct input_dev *dev)
+{
+	struct cntouch_device *cn_dev = input_get_drvdata(dev);
+
+	cn_dev->irq->dev = cn_dev->usb_dev;
+	if (usb_submit_urb(cn_dev->irq, GFP_KERNEL))
+		return -EIO;
+	return 0;
+}
+
+static void cntouch_close(struct input_dev *dev)
+{
+	struct cntouch_device *cn_dev = input_get_drvdata(dev);
+
+	usb_kill_urb(cn_dev->irq);
+}
+
+static int cntouch_probe(struct usb_interface *interface,
+			 const struct usb_device_id *id)
+{
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
+	struct cntouch_device *cn_dev = NULL;
+	struct usb_host_interface *host_interface;
+	struct usb_endpoint_descriptor *endpoint;
+	int pipe, maxp;
+	int error = -ENOMEM;
+
+	host_interface = interface->cur_altsetting;
+
+	if (host_interface->desc.bNumEndpoints != 1)
+		return -ENODEV;
+
+	endpoint = &host_interface->endpoint[0].desc;
+	if (!usb_endpoint_is_int_in(endpoint))
+		return -ENODEV;
+
+	pipe = usb_rcvintpipe(usb_dev, endpoint->bEndpointAddress);
+	maxp = usb_maxpacket(usb_dev, pipe, usb_pipeout(pipe));
+
+	cn_dev = kzalloc(sizeof(*cn_dev), GFP_KERNEL);
+	if (cn_dev == NULL)
+		goto err_1;
+
+	cn_dev->input_dev = input_allocate_device();
+	if (!cn_dev->input_dev)
+		goto err_2;
+
+	cn_dev->usb_dev = usb_get_dev(usb_dev);
+
+	cn_dev->data =
+	    usb_alloc_coherent(usb_dev, 8, GFP_ATOMIC, &cn_dev->data_dma);
+	if (!cn_dev->data)
+		goto err_3;
+
+	cn_dev->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!cn_dev->irq)
+		goto err_4;
+
+	usb_set_intfdata(interface, cn_dev);
+
+	usb_make_path(usb_dev, cn_dev->usb_path, sizeof(cn_dev->usb_path));
+	strlcat(cn_dev->usb_path, "/input0", sizeof(cn_dev->usb_path));
+
+	cn_dev->input_dev->name = "CNTouch";
+	cn_dev->input_dev->phys = cn_dev->usb_path;
+	usb_to_input_id(usb_dev, &cn_dev->input_dev->id);
+	cn_dev->input_dev->dev.parent = &interface->dev;
+
+	cn_dev->input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
+	cn_dev->input_dev->keybit[BIT_WORD(BTN_MOUSE)] =
+	    BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_RIGHT);
+	cn_dev->input_dev->relbit[0] =
+	    BIT_MASK(REL_X) | BIT_MASK(REL_Y) | BIT_MASK(REL_WHEEL);
+
+	input_set_drvdata(cn_dev->input_dev, cn_dev);
+
+	cn_dev->input_dev->open = cntouch_open;
+	cn_dev->input_dev->close = cntouch_close;
+
+	usb_fill_int_urb(cn_dev->irq, usb_dev, pipe, cn_dev->data,
+			 (maxp > 8 ? 8 : maxp), cntouch_irq, cn_dev,
+			 endpoint->bInterval);
+	cn_dev->irq->transfer_dma = cn_dev->data_dma;
+	cn_dev->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	error = input_register_device(cn_dev->input_dev);
+	if (error)
+		goto err_5;
+
+	dev_info(&interface->dev, DRIVER_DESC "device now attached\n");
+	return 0;
+
+err_5:
+	usb_free_urb(cn_dev->irq);
+err_4:
+	usb_free_coherent(usb_dev, 8, cn_dev->data, cn_dev->data_dma);
+err_3:
+	input_free_device(cn_dev->input_dev);
+err_2:
+	usb_set_intfdata(interface, NULL);
+	usb_put_dev(cn_dev->usb_dev);
+	kfree(cn_dev);
+err_1:
+	dev_err(&interface->dev, "out of memory\n");
+	return error;
+}
+
+static void cntouch_disconnect(struct usb_interface *interface)
+{
+	struct cntouch_device *cn_dev = usb_get_intfdata(interface);
+
+	usb_kill_urb(cn_dev->irq);
+	input_unregister_device(cn_dev->input_dev);
+	usb_free_urb(cn_dev->irq);
+	usb_free_coherent(cn_dev->usb_dev, 8, cn_dev->data, cn_dev->data_dma);
+	usb_set_intfdata(interface, NULL);
+	usb_put_dev(cn_dev->usb_dev);
+	input_free_device(cn_dev->input_dev);
+	kfree(cn_dev);
+	dev_info(&interface->dev, DRIVER_DESC " now disconnected\n");
+}
+
+static struct usb_driver cntouch_driver = {
+	.name = "CNTouch",
+	.probe = &cntouch_probe,
+	.disconnect = &cntouch_disconnect,
+	.id_table = cntouch_devices,
+};
+
+module_usb_driver(cntouch_driver);
-- 
2.1.0

