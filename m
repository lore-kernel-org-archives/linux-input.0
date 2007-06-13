From: Brian Magnuson <bdmagnuson@gmail.com>
Subject: Re: [PATCH 4/4] xpad.c - fixed report for dpad and inverted Y and
	RY axes
Date: Tue, 12 Jun 2007 21:13:34 -0400
Message-ID: <20070613011334.GA11765@rcn.com>
References: <alpine.LRH.0.98.0706031610380.22353@twin.jikos.cz> <d120d5000706110736g3a15f86bg75ff57e3170819f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000706110736g3a15f86bg75ff57e3170819f1@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jan Kratochvil <honza@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2007-06-12 20:59]:
> Hi,
>
> Sorry for disappearmign on you guys...
>
> On 6/3/07, Jan Kratochvil <honza@jikos.cz> wrote:
>> Fixed input report handling for xbox 360 controller.
>> Y/RY up is now positive and down negative.
>> DPAD report fixed.
>
> I have some concerns over this patch - when mapping dpad to buttons
> your new mapping follows mapping for classic xbox; however it is still
> different when mapping dpad to axes so this is suspicious. Could you
> please try the attached patch and tell me if it works for you?
>
> Also, please avoid constructs like this:
>
>> +               input_report_abs(dev, ABS_HAT0Y, !!((data[2] & 0x08) >> 3) 
>> - !!((data[2] & 0x04) >> 2));
>
> Doing shift is meaningles if you convert result to 0/1. I.e. it is
> exactly the same as !!(data[2] & 0x08) - !!(data[2] &0x04).
>
> Thank you.
>
> -- 
> Dmitry

Hi Dmitry,

Actually, I have to say now that my initial report of the axes being inverted
was based on my observations in jscalibrator which at the time was the only
app I had that took input from the analog joysticks.  My impression that up =
positive and down = negative seems to be a personal bias since the first
application that I tried it with (i.e. joymouse) seems to interpret it in the
opposite manner.

In any case here's an updated wireless 360 patch that leaves the polarity as
it is and also includes support for setting the LEDs of the wireless
controllers which of course is different than how the wired variety does it.

-Brian


Signed-off-by: Brian Magnuson <bdmagnuson@gmail.com>
---
 drivers/input/joystick/xpad.c |  135 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 664c765..7c5947c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -93,6 +93,7 @@
 
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
+#define XTYPE_XBOX360W    2
 
 static int dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -109,6 +110,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DPAD_TO_AXES, XTYPE_XBOX },
+	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
@@ -179,6 +181,7 @@ static const signed short xpad_abs_pad[] = {
 static struct usb_device_id xpad_table [] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	{ USB_DEVICE_INTERFACE_PROTOCOL(0x045e, 0x028e, 1) },	/* X-Box 360 controller */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(0x045e, 0x0719, 129) }, /* X-Box 360 wireless receiver */
 	{ }
 };
 
@@ -188,10 +191,15 @@ struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
 	struct usb_device *udev;	/* usb device */
 
+	int pad_present;
+
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
 	dma_addr_t idata_dma;
 
+	struct urb *bulk_out;
+	unsigned char *bdata;
+
 #ifdef CONFIG_JOYSTICK_XPAD_FF
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
@@ -318,6 +326,39 @@ static void xpad360_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	input_sync(dev);
 }
 
+/*
+ * xpad360w_process_packet
+ *
+ * Completes a request by converting the data into events for the
+ * input subsystem. It is version for xbox 360 wireless controller.
+ *
+ * Byte.Bit
+ * 00.1 - Status change: The controller or headset has connected/disconnected
+ *                       Bits 01.7 and 01.6 are valid
+ * 01.7 - Controller present
+ * 01.6 - Headset present
+ * 01.1 - Pad state (Bytes 4+) valid
+ *
+ */
+
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+{
+	/* Presence change */
+	if (data[0] & 0x08) {
+		if (data[1] & 0x80) {
+			xpad->pad_present = 1;
+			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
+		} else
+			xpad->pad_present = 0;
+	}
+
+	/* Valid pad data */
+	if (!(data[1] & 0x1))
+		return;
+
+	xpad360_process_packet(xpad, cmd, &data[4]);
+}
+
 static void xpad_irq_in(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
@@ -338,10 +379,16 @@ static void xpad_irq_in(struct urb *urb)
 		goto exit;
 	}
 
-	if (xpad->xtype == XTYPE_XBOX360)
+	switch (xpad->xtype) {
+	case XTYPE_XBOX360 :
 		xpad360_process_packet(xpad, 0, xpad->idata);
-	else
+		break;
+	case XTYPE_XBOX360W :
+		xpad360w_process_packet(xpad, 0, xpad->idata);
+		break;
+	default :
 		xpad_process_packet(xpad, 0, xpad->idata);
+	}
 
 exit:
 	retval = usb_submit_urb (urb, GFP_ATOMIC);
@@ -377,6 +424,23 @@ exit:
 		   __FUNCTION__, retval);
 }
 
+static void xpad_bulk_out(struct urb *urb)
+{
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d", __FUNCTION__, urb->status);
+		break;
+	default:
+		dbg("%s - nonzero urb status received: %d", __FUNCTION__, urb->status);
+	}
+}
+
 int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
@@ -408,7 +472,7 @@ static int xpad_init_ff(struct usb_interface *intf, struct usb_xpad *xpad)
 
 	xpad->odata = usb_buffer_alloc(xpad->udev, XPAD_PKT_LEN,
 				       GFP_ATOMIC, &xpad->odata_dma );
-	if (!xpad->idata)
+	if (!xpad->odata)
 		goto fail1;
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
@@ -460,6 +524,10 @@ static int xpad_open(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 
+	//URB was submitted in probe
+	if(xpad->xtype == XTYPE_XBOX360W)
+		return 0;
+
 	xpad->irq_in->dev = xpad->udev;
 	if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
 		return -EIO;
@@ -471,7 +539,8 @@ static void xpad_close(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 
-	usb_kill_urb(xpad->irq_in);
+	if(xpad->xtype != XTYPE_XBOX360W)
+		usb_kill_urb(xpad->irq_in);
 	xpad_stop_ff(xpad);
 }
 
@@ -550,7 +619,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	/* set up buttons */
 	for (i = 0; xpad_btn[i] >= 0; i++)
 		set_bit(xpad_btn[i], input_dev->keybit);
-	if (xpad->xtype == XTYPE_XBOX360)
+	if ((xpad->xtype == XTYPE_XBOX360) || (xpad->xtype == XTYPE_XBOX360W))
 		for (i = 0; xpad360_btn[i] >= 0; i++)
 			set_bit(xpad360_btn[i], input_dev->keybit);
 	if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS)
@@ -581,8 +650,59 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto fail3;
 
 	usb_set_intfdata(intf, xpad);
+
+	/*
+	 * Submit the int URB immediatly rather than waiting for open
+	 * because we get status messages from the device whether
+	 * or not any controllers are attached.  In fact, it's
+	 * exactly the message that a controller has arrived that
+	 * we're waiting for.
+	 */
+	if (xpad->xtype == XTYPE_XBOX360W) {
+
+		xpad->irq_in->dev = xpad->udev;
+		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
+		if (error) {
+			goto fail3;
+		}
+
+		/*
+		 * Setup the message to set the LEDs on the
+		 * controller when it shows up
+		 */
+		xpad->bulk_out = usb_alloc_urb(0, GFP_KERNEL);
+		if(!xpad->bulk_out)
+			goto fail4;
+
+		xpad->bdata = kzalloc(XPAD_PKT_LEN, GFP_KERNEL);
+		if(!xpad->bdata)
+			goto fail5;
+
+		xpad->bdata[2] = 0x08;
+		switch (intf->cur_altsetting->desc.bInterfaceNumber) {
+		case 0 :
+			xpad->bdata[3] = 0x42;
+			break;
+		case 2 :
+			xpad->bdata[3] = 0x43;
+			break;
+		case 4 :
+			xpad->bdata[3] = 0x44;
+			break;
+		case 6 :
+			xpad->bdata[3] = 0x45;
+		}
+
+		ep_irq_in = &intf->cur_altsetting->endpoint[1].desc;
+		usb_fill_bulk_urb(xpad->bulk_out, udev,
+		    usb_sndbulkpipe(udev, ep_irq_in->bEndpointAddress),
+		    xpad->bdata, XPAD_PKT_LEN, xpad_bulk_out, xpad);
+	}
+
 	return 0;
 
+ fail5:	usb_free_urb(xpad->bulk_out);
+ fail4:	usb_kill_urb(xpad->irq_in);
  fail3:	usb_free_urb(xpad->irq_in);
  fail2:	usb_buffer_free(udev, XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
  fail1:	input_free_device(input_dev);
@@ -599,6 +719,11 @@ static void xpad_disconnect(struct usb_interface *intf)
 	if (xpad) {
 		input_unregister_device(xpad->dev);
 		xpad_deinit_ff(xpad);
+		if(xpad->xtype == XTYPE_XBOX360W) {
+			usb_kill_urb(xpad->bulk_out);
+			usb_free_urb(xpad->bulk_out);
+			usb_kill_urb(xpad->irq_in);
+		}
 		usb_free_urb(xpad->irq_in);
 		usb_buffer_free(xpad->udev, XPAD_PKT_LEN,
 				xpad->idata, xpad->idata_dma);
-- 
1.5.2.1
