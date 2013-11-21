From: Mayeul Cantan <mayeul.cantan@gmail.com>
Subject: [RFC][PATCH] Input : xpad : Fix Blinking XBOX 360 Gamepad Blinking
 Leds.
Date: Thu, 21 Nov 2013 20:55:36 +0100
Message-ID: <528E6538.50506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:51204 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3KUTzs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 14:55:48 -0500
Received: by mail-we0-f181.google.com with SMTP id x55so232229wes.40
        for <linux-input@vger.kernel.org>; Thu, 21 Nov 2013 11:55:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, chf.fritz@googlemail.com

Hello,
This patch should allow the wireless xbox 360 controllers to display the 
correct controller ID instead of keeping blinking.
Since there are four "channels" on the Microsoft receiver, the 
controller displays the channel it uses,
so if both a wired and a wireless controller are attached to the 
computer, both will sow the ID #1.
I didn't have the opportunity to test this behavior on Microsoft 
Windows, so I need you to comment on this.

CHANGES :
Just cleaned the code which wasn't working correctly, and added some to 
make it work.
Corrected what I think was a typo line 143.
Added something like printk(KERN_INFO "Wireless controller %d 
(dis)connected\n" ),
I don't know if this is a good practice, so I need some feedback on this 
too.

This patch can be applied against the code since commit 
ed06349fe8d12dcb718984862b6e839fc8606c34 (3 months ago).

Thank you,

Mayeul

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 75e3b10..5f78604 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -140,7 +140,7 @@
  	{ 0x0738, 0x4728, "Mad Catz Street Fighter IV FightPad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
  	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
  	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
-	{ 0x0738, 0xbeef, "Mad Catz JOYTECH NEO SE Advanced GamePad", XTYPE_XBOX360 },
+	{ 0x0738, 0xbeef, "Mad Catz JOYTECH NEO SE Advanced GamePad", 0, XTYPE_XBOX360 },
  	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
  	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", DANCEPAD_MAP_CONFIG, XTYPE_XBOX },
  	{ 0x0c12, 0x880a, "Pelican Eclipse PL-2023", 0, XTYPE_XBOX },
@@ -274,9 +274,6 @@ struct usb_xpad {
  	unsigned char *idata;		/* input data */
  	dma_addr_t idata_dma;
  
-	struct urb *bulk_out;
-	unsigned char *bdata;
-
  #if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
  	struct urb *irq_out;		/* urb for interrupt out report */
  	unsigned char *odata;		/* output data */
@@ -451,15 +448,19 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
   *
   */
  
+static void xpad_send_led_command(struct usb_xpad *xpad, int command); //needed just after
  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
  {
  	/* Presence change */
  	if (data[0] & 0x08) {
  		if (data[1] & 0x80) {
  			xpad->pad_present = 1;
-			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
-		} else
+			xpad_send_led_command(xpad, xpad->intf->cur_altsetting->desc.bInterfaceNumber /2 + 66);
+			printk(KERN_INFO "Wireless controller %d connected\n",xpad->intf->cur_altsetting->desc.bInterfaceNumber /2 + 1);
+		} else {
+			printk(KERN_INFO "Wireless controller %d disconnected\n",xpad->intf->cur_altsetting->desc.bInterfaceNumber /2 + 1);
  			xpad->pad_present = 0;
+		}
  	}
  
  	/* Valid pad data */
@@ -512,28 +513,6 @@ static void xpad_irq_in(struct urb *urb)
  			__func__, retval);
  }
  
-static void xpad_bulk_out(struct urb *urb)
-{
-	struct usb_xpad *xpad = urb->context;
-	struct device *dev = &xpad->intf->dev;
-
-	switch (urb->status) {
-	case 0:
-		/* success */
-		break;
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/* this urb is terminated, clean up */
-		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
-			__func__, urb->status);
-		break;
-	default:
-		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
-			__func__, urb->status);
-	}
-}
-
  #if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
  static void xpad_irq_out(struct urb *urb)
  {
@@ -714,7 +693,7 @@ struct xpad_led {
  
  static void xpad_send_led_command(struct usb_xpad *xpad, int command)
  {
-	if (command >= 0 && command < 14) {
+	if (command >= 0 && command < 14 && xpad->xtype == XTYPE_XBOX360) {
  		mutex_lock(&xpad->odata_mutex);
  		xpad->odata[0] = 0x01;
  		xpad->odata[1] = 0x03;
@@ -723,6 +702,16 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
  		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
  		mutex_unlock(&xpad->odata_mutex);
  	}
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		mutex_lock(&xpad->odata_mutex);
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x08;
+		xpad->odata[3] = command;
+		xpad->irq_out->transfer_buffer_length = 4;
+		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		mutex_unlock(&xpad->odata_mutex);
+	}
  }
  
  static void xpad_led_set(struct led_classdev *led_cdev,
@@ -783,6 +772,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
  	}
  }
  #else
+static void xpad_send_led_command(struct usb_xpad *xpad, int command) { }
  static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
  static void xpad_led_disconnect(struct usb_xpad *xpad) { }
  #endif
@@ -971,42 +961,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
  
  	if (xpad->xtype == XTYPE_XBOX360W) {
  		/*
-		 * Setup the message to set the LEDs on the
-		 * controller when it shows up
-		 */
-		xpad->bulk_out = usb_alloc_urb(0, GFP_KERNEL);
-		if (!xpad->bulk_out) {
-			error = -ENOMEM;
-			goto fail7;
-		}
-
-		xpad->bdata = kzalloc(XPAD_PKT_LEN, GFP_KERNEL);
-		if (!xpad->bdata) {
-			error = -ENOMEM;
-			goto fail8;
-		}
-
-		xpad->bdata[2] = 0x08;
-		switch (intf->cur_altsetting->desc.bInterfaceNumber) {
-		case 0:
-			xpad->bdata[3] = 0x42;
-			break;
-		case 2:
-			xpad->bdata[3] = 0x43;
-			break;
-		case 4:
-			xpad->bdata[3] = 0x44;
-			break;
-		case 6:
-			xpad->bdata[3] = 0x45;
-		}
-
-		ep_irq_in = &intf->cur_altsetting->endpoint[1].desc;
-		usb_fill_bulk_urb(xpad->bulk_out, udev,
-				usb_sndbulkpipe(udev, ep_irq_in->bEndpointAddress),
-				xpad->bdata, XPAD_PKT_LEN, xpad_bulk_out, xpad);
-
-		/*
  		 * Submit the int URB immediately rather than waiting for open
  		 * because we get status messages from the device whether
  		 * or not any controllers are attached.  In fact, it's
@@ -1016,13 +970,11 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
  		xpad->irq_in->dev = xpad->udev;
  		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
  		if (error)
-			goto fail9;
+			goto fail7;
  	}
  
  	return 0;
  
- fail9:	kfree(xpad->bdata);
- fail8:	usb_free_urb(xpad->bulk_out);
   fail7:	input_unregister_device(input_dev);
  	input_dev = NULL;
   fail6:	xpad_led_disconnect(xpad);
@@ -1046,8 +998,6 @@ static void xpad_disconnect(struct usb_interface *intf)
  	xpad_deinit_output(xpad);
  
  	if (xpad->xtype == XTYPE_XBOX360W) {
-		usb_kill_urb(xpad->bulk_out);
-		usb_free_urb(xpad->bulk_out);
  		usb_kill_urb(xpad->irq_in);
  	}
  
@@ -1055,7 +1005,6 @@ static void xpad_disconnect(struct usb_interface *intf)
  	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
  			xpad->idata, xpad->idata_dma);
  
-	kfree(xpad->bdata);
  	kfree(xpad);
  
  	usb_set_intfdata(intf, NULL);


