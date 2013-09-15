From: Andrew Deason <adeason@dson.org>
Subject: [PATCH 2/2] Input: synaptics_usb - Add stick_hid param
Date: Sun, 15 Sep 2013 16:02:02 -0500
Message-ID: <20130915160202.f0168d6797fc450fe7361d43@dson.org>
References: <20130915155755.946c17243cc33d621245138f@dson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:38936 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3IOVCE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Sep 2013 17:02:04 -0400
Received: by mail-yh0-f47.google.com with SMTP id l109so1624239yhq.6
        for <linux-input@vger.kernel.org>; Sun, 15 Sep 2013 14:02:04 -0700 (PDT)
In-Reply-To: <20130915155755.946c17243cc33d621245138f@dson.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Add a module parameter (stick_hid) that makes the trackpoint device
present itself as a HID mouse. In this mode, the hardware translates
the force readings into relative mouse motion itself, instead of the
driver performing the translation.

This can be useful, since the code to translate trackpoint force
readings into cursor movement inside synaptics_usb itself still
involves some guesswork. Without detailed knowledge of the hardware
device, it may not ever be possible to get the same results from our
driver as what the hardware provides. This parameter allows the
behavior to be identical to behavior before the introduction of the
synaptics_usb driver, if the user prefers that behavior.

The stick_hid mode also requires fewer calculations to be done by the
synaptics_usb driver, if someone is bothered by the overhead of the
trackpoint movement calculations.

Signed-off-by: Andrew Deason <adeason@dson.org>
---
 drivers/input/mouse/synaptics_usb.c | 54 ++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 8571005..652afae 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -35,7 +35,8 @@
  *	setting 1: one int endpoint for absolute finger position
  *	setting 2 (cPad only): one int endpoint for absolute finger position and
  *		   two bulk endpoints for the display (in/out)
- * This driver uses setting 1.
+ * This driver uses setting 1. For touchsticks, you can use setting 0 instead
+ * by setting the stick_hid module parameter.
  */
 
 #include <linux/kernel.h>
@@ -443,7 +444,9 @@ static void synusb_report_buttons(struct synusb *synusb)
 	input_report_key(input_dev, BTN_MIDDLE, synusb->data[1] & 0x02);
 }
 
-static void synusb_report_stick(struct synusb *synusb)
+/* This uses the 'raw' force readings from the trackpoint and translates them
+ * into relative mouse movement. */
+static void synusb_report_stick_raw(struct synusb *synusb)
 {
 	struct input_dev *input_dev = synusb->input;
 	int x, y;
@@ -470,6 +473,24 @@ static void synusb_report_stick(struct synusb *synusb)
 	input_sync(input_dev);
 }
 
+/* This just reads the HID data from the stick device, and just passes it on
+ * to the input subsystem. */
+static int stick_hid;
+static void synusb_report_stick_hid(struct synusb *synusb)
+{
+	struct input_dev *dev = synusb->input;
+	signed char *data = synusb->data;
+
+	input_report_key(dev, BTN_LEFT,   data[0] & 0x01);
+	input_report_key(dev, BTN_RIGHT,  data[0] & 0x02);
+	input_report_key(dev, BTN_MIDDLE, data[0] & 0x04);
+
+	input_report_rel(dev, REL_X,     data[1]);
+	input_report_rel(dev, REL_Y,     data[2]);
+
+	input_sync(dev);
+}
+
 static void synusb_report_touchpad(struct synusb *synusb)
 {
 	struct input_dev *input_dev = synusb->input;
@@ -555,9 +576,13 @@ static void synusb_irq(struct urb *urb)
 		break;
 	}
 
-	if (synusb->flags & SYNUSB_STICK)
-		synusb_report_stick(synusb);
-	else
+	if (synusb->flags & SYNUSB_STICK) {
+		if (stick_hid) {
+			synusb_report_stick_hid(synusb);
+		} else {
+			synusb_report_stick_raw(synusb);
+		}
+	} else
 		synusb_report_touchpad(synusb);
 
 resubmit:
@@ -640,6 +665,15 @@ static int synusb_probe(struct usb_interface *intf,
 	unsigned int intf_num = intf->cur_altsetting->desc.bInterfaceNumber;
 	unsigned int altsetting = min(intf->num_altsetting, 1U);
 	int error;
+	int pipe, maxp;
+
+	if ((id->driver_info & SYNUSB_COMBO) && intf_num == 1) {
+		/* we are a pointing stick */
+		if (stick_hid) {
+			/* alt setting 0 is the HID non-advanced mode */
+			altsetting = 0;
+		}
+	}
 
 	error = usb_set_interface(udev, intf_num, altsetting);
 	if (error) {
@@ -687,9 +721,12 @@ static int synusb_probe(struct usb_interface *intf,
 		goto err_free_urb;
 	}
 
+	pipe = usb_rcvintpipe(udev, ep->bEndpointAddress);
+	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+
 	usb_fill_int_urb(synusb->urb, udev,
-			 usb_rcvintpipe(udev, ep->bEndpointAddress),
-			 synusb->data, SYNUSB_RECV_SIZE,
+			 pipe,
+			 synusb->data, (maxp > SYNUSB_RECV_SIZE ? SYNUSB_RECV_SIZE : maxp),
 			 synusb_irq, synusb,
 			 ep->bInterval);
 	synusb->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
@@ -920,3 +957,6 @@ MODULE_LICENSE("GPL");
 
 module_param(stick_debug, int, 0644);
 MODULE_PARM_DESC(stick_debug, "Activate pointing stick movement debugging output");
+
+module_param(stick_hid, int, 0644);
+MODULE_PARM_DESC(stick_hid, "Use HID data for pointing sticks instead of raw force readings");
-- 
1.8.4.rc3
