From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Input: xpad: handle "present" and "gone" correctly
Date: Mon, 14 Dec 2015 15:29:16 -0800
Message-ID: <20151214232916.GA16209@dtor-ws>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
 <1446391899-24250-2-git-send-email-rojtberg@gmail.com>
 <20151210070239.GD35505@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36649 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbbLNX3T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2015 18:29:19 -0500
Received: by pfbu66 with SMTP id u66so69054105pfb.3
        for <linux-input@vger.kernel.org>; Mon, 14 Dec 2015 15:29:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151210070239.GD35505@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Wed, Dec 09, 2015 at 11:02:39PM -0800, Dmitry Torokhov wrote:
> On Sun, Nov 01, 2015 at 04:31:35PM +0100, Pavel Rojtberg wrote:
> > From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> > 
> > Handle the "a new device is present" message properly by dynamically
> > creating the input device at this point in time. This means we now do
> > not "preallocate" all 4 devices when a single
> > wireless base station is seen. This requires a workqueue as we are in
> > interrupt context when we learn about this.
> > 
> >  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
> >  {
> > +	int presence;
> > +
> >  	/* Presence change */
> >  	if (data[0] & 0x08) {
> > -		if (data[1] & 0x80) {
> > -			xpad->pad_present = 1;
> > -			/*
> > -			 * Light up the segment corresponding to
> > -			 * controller number.
> > -			 */
> > -			xpad_identify_controller(xpad);
> > -		} else
> > -			xpad->pad_present = 0;
> > +		presence = (data[1] & 0x80) != 0;
> > +
> > +		if (xpad->pad_present != presence) {
> > +			xpad->pad_present = presence;
> > +			schedule_work(&xpad->work);
> > +		}
> 
> I think this is racy: we'll crash if we get motion packets before we
> finish creating input device. I think we should be returning whether we
> want to have xpad->irq_in URB be re-submitted and in case we scheduke
> work we'd return "false" and have work resubmit IRQ when it is done
> creating or destroying input device.

Hmm, after I thought about it some more I am not sure that simply
not submitting any more input URBs is sufficient: what will happen if
the device sends motion event before we send our query (I.e. user is
holding a button on the controller). I think it is safer to make sure we
are not accessing half-created or half-gone input device when
processing packet.

Could you please take a look at the new version of this patch below?

Thanks!

-- 
Dmitry

Input: xpad - handle "present" and "gone" correctly

From: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>

Handle the "a new device is present" message properly by dynamically
creating the input device at this point in time. This means we now do not
"preallocate" all 4 devices when a single wireless base station is seen.
This requires a workqueue as we are in interrupt context when we learn
about this.

Also properly disconnect any devices that we are told are removed.

Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/xpad.c |  107 ++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c44cbd4..1d51d24 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -76,6 +76,8 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
@@ -319,10 +321,12 @@ MODULE_DEVICE_TABLE(usb, xpad_table);
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
+	struct input_dev __rcu *x360w_dev;
 	struct usb_device *udev;	/* usb device */
 	struct usb_interface *intf;	/* usb interface */
 
-	int pad_present;
+	bool pad_present;
+	bool input_created;
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
@@ -343,8 +347,12 @@ struct usb_xpad {
 	int xtype;			/* type of xbox device */
 	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
+	struct work_struct work;	/* init/remove device from callback */
 };
 
+static int xpad_init_input(struct usb_xpad *xpad);
+static void xpad_deinit_input(struct usb_xpad *xpad);
+
 /*
  *	xpad_process_packet
  *
@@ -424,11 +432,9 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
  *		http://www.free60.org/wiki/Gamepad
  */
 
-static void xpad360_process_packet(struct usb_xpad *xpad,
+static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 				   u16 cmd, unsigned char *data)
 {
-	struct input_dev *dev = xpad->dev;
-
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (left, right, up, down) */
@@ -495,7 +501,30 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 	input_sync(dev);
 }
 
-static void xpad_identify_controller(struct usb_xpad *xpad);
+static void xpad_presence_work(struct work_struct *work)
+{
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	int error;
+
+	if (xpad->pad_present) {
+		error = xpad_init_input(xpad);
+		if (error) {
+			/* complain only, not much else we can do here */
+			dev_err(&xpad->dev->dev,
+				"unable to init device: %d\n", error);
+		} else {
+			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
+		}
+	} else {
+		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+		synchronize_rcu();
+		/*
+		 * Now that we are sure xpad360w_process_packet is not
+		 * using input device we can get rid of it.
+		 */
+		xpad_deinit_input(xpad);
+	}
+}
 
 /*
  * xpad360w_process_packet
@@ -513,24 +542,28 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
  */
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
+	struct input_dev *dev;
+	bool present;
+
 	/* Presence change */
 	if (data[0] & 0x08) {
-		if (data[1] & 0x80) {
-			xpad->pad_present = 1;
-			/*
-			 * Light up the segment corresponding to
-			 * controller number.
-			 */
-			xpad_identify_controller(xpad);
-		} else
-			xpad->pad_present = 0;
+		present = (data[1] & 0x80) != 0;
+
+		if (xpad->pad_present != present) {
+			xpad->pad_present = present;
+			schedule_work(&xpad->work);
+		}
 	}
 
 	/* Valid pad data */
 	if (data[1] != 0x1)
 		return;
 
-	xpad360_process_packet(xpad, cmd, &data[4]);
+	rcu_read_lock();
+	dev = rcu_dereference(xpad->x360w_dev);
+	if (dev)
+		xpad360_process_packet(xpad, dev, cmd, &data[4]);
+	rcu_read_unlock();
 }
 
 /*
@@ -659,7 +692,7 @@ static void xpad_irq_in(struct urb *urb)
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad360_process_packet(xpad, 0, xpad->idata);
+		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
 		xpad360w_process_packet(xpad, 0, xpad->idata);
@@ -1001,14 +1034,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (error)
 		goto err_free_id;
 
-	if (xpad->xtype == XTYPE_XBOX360) {
-		/*
-		 * Light up the segment corresponding to controller
-		 * number on wired devices. On wireless we'll do that
-		 * when they respond to "presence" packet.
-		 */
-		xpad_identify_controller(xpad);
-	}
+	xpad_identify_controller(xpad);
 
 	return 0;
 
@@ -1097,8 +1123,11 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 
 static void xpad_deinit_input(struct usb_xpad *xpad)
 {
-	xpad_led_disconnect(xpad);
-	input_unregister_device(xpad->dev);
+	if (xpad->input_created) {
+		xpad->input_created = false;
+		xpad_led_disconnect(xpad);
+		input_unregister_device(xpad->dev);
+	}
 }
 
 static int xpad_init_input(struct usb_xpad *xpad)
@@ -1181,6 +1210,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	if (error)
 		goto err_disconnect_led;
 
+	xpad->input_created = true;
 	return 0;
 
 err_disconnect_led:
@@ -1241,6 +1271,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->mapping = xpad_device[i].mapping;
 	xpad->xtype = xpad_device[i].xtype;
 	xpad->name = xpad_device[i].name;
+	INIT_WORK(&xpad->work, xpad_presence_work);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
@@ -1277,10 +1308,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 
 	usb_set_intfdata(intf, xpad);
 
-	error = xpad_init_input(xpad);
-	if (error)
-		goto err_deinit_output;
-
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		/*
 		 * Submit the int URB immediately rather than waiting for open
@@ -1292,7 +1319,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->irq_in->dev = xpad->udev;
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
-			goto err_deinit_input;
+			goto err_deinit_output;
 
 		/*
 		 * Send presence packet.
@@ -1304,13 +1331,15 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = xpad_inquiry_pad_presence(xpad);
 		if (error)
 			goto err_kill_in_urb;
+	} else {
+		error = xpad_init_input(xpad);
+		if (error)
+			goto err_deinit_output;
 	}
 	return 0;
 
 err_kill_in_urb:
 	usb_kill_urb(xpad->irq_in);
-err_deinit_input:
-	xpad_deinit_input(xpad);
 err_deinit_output:
 	xpad_deinit_output(xpad);
 err_free_in_urb:
@@ -1327,17 +1356,19 @@ static void xpad_disconnect(struct usb_interface *intf)
 {
 	struct usb_xpad *xpad = usb_get_intfdata (intf);
 
-	xpad_deinit_input(xpad);
-	xpad_deinit_output(xpad);
-
-	if (xpad->xtype == XTYPE_XBOX360W) {
+	if (xpad->xtype == XTYPE_XBOX360W)
 		usb_kill_urb(xpad->irq_in);
-	}
+
+	cancel_work_sync(&xpad->work);
+
+	xpad_deinit_input(xpad);
 
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
+	xpad_deinit_output(xpad);
+
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);
