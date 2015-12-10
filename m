From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Input: xpad: re-submit pending ff and led requests
Date: Wed, 9 Dec 2015 22:40:32 -0800
Message-ID: <20151210064032.GA35505@dtor-ws>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
 <1446391899-24250-4-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33114 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbbLJGkg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 01:40:36 -0500
Received: by pabur14 with SMTP id ur14so42740132pab.0
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2015 22:40:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446391899-24250-4-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org, Laura Abbott <labbott@fedoraproject.org>

Hi Pavel,

On Sun, Nov 01, 2015 at 04:31:37PM +0100, Pavel Rojtberg wrote:
> @@ -910,9 +942,17 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
>  		retval = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
>  		xpad->irq_out_active = 1;
>  	} else {
> -		retval = -EIO;
> -		dev_dbg(&xpad->dev->dev, "%s - dropped, irq_out is active\n",
> -				__func__);
> +		retval = 0;
> +
> +		if (xpad->pend_rum) {
> +			dev_dbg(&xpad->dev->dev,
> +				"%s - overwriting pending\n", __func__);
> +
> +			retval = -EIO;

Why do we return -EIO here?

> +		}
> +
> +		xpad->pend_rum = xpad->irq_out->transfer_buffer_length;
> +		memcpy(xpad->rum_odata, xpad->odata, xpad->pend_rum);

This is wrong: you first copy into xpad->odata which means that you may
alter the buffer while device is fetching the previous packet it.

Can you please try the version of the patch below? I squashed your #2
and #3 patches together and adjusted the behavior to avoid the issue
above.

The patches are also in 'xpad' branch of my tree.

Thanks!

-- 
Dmitry

Input: xpad - correctly handle concurrent LED and FF requests

From: Pavel Rojtberg <rojtberg@gmail.com>

Track the status of the irq_out URB to prevent submission iof new requests
while current one is active. Failure to do so results in the "URB submitted
while active" warning/stack trace.

Store pending brightness and FF effect in the driver structure and replace
it with the latest requests until the device is ready to process next
request. Alternate serving LED vs FF requests to make sure one does not
starve another. See [1] for discussion. Inspired by patch of Sarah Bessmer
[2].

[1]: http://www.spinics.net/lists/linux-input/msg40708.html
[2]: http://www.spinics.net/lists/linux-input/msg31450.html

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/xpad.c |  320 ++++++++++++++++++++++++++++-------------
 1 file changed, 221 insertions(+), 99 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1013c5c..4a7362e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -317,6 +317,19 @@ static struct usb_device_id xpad_table[] = {
 
 MODULE_DEVICE_TABLE(usb, xpad_table);
 
+struct xpad_output_packet {
+	u8 data[XPAD_PKT_LEN];
+	u8 len;
+	bool pending;
+};
+
+#define XPAD_OUT_CMD_IDX	0
+#define XPAD_OUT_FF_IDX		1
+#define XPAD_OUT_LED_IDX	(1 + IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF))
+#define XPAD_NUM_OUT_PACKETS	(1 + \
+				 IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF) + \
+				 IS_ENABLED(CONFIG_JOYSTICK_XPAD_LEDS))
+
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
 	struct usb_device *udev;	/* usb device */
@@ -329,9 +342,13 @@ struct usb_xpad {
 	dma_addr_t idata_dma;
 
 	struct urb *irq_out;		/* urb for interrupt out report */
+	bool irq_out_active;		/* we must not use an active URB */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
-	struct mutex odata_mutex;
+	spinlock_t odata_lock;
+
+	struct xpad_output_packet out_packets[XPAD_NUM_OUT_PACKETS];
+	int last_out_packet;
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -695,18 +712,71 @@ exit:
 			__func__, retval);
 }
 
+/* Callers must hold xpad->odata_lock spinlock */
+static bool xpad_prepare_next_out_packet(struct usb_xpad *xpad)
+{
+	struct xpad_output_packet *pkt, *packet = NULL;
+	int i;
+
+	for (i = 0; i < XPAD_NUM_OUT_PACKETS; i++) {
+		if (++xpad->last_out_packet >= XPAD_NUM_OUT_PACKETS)
+			xpad->last_out_packet = 0;
+
+		pkt = &xpad->out_packets[xpad->last_out_packet];
+		if (pkt->pending) {
+			dev_dbg(&xpad->intf->dev,
+				"%s - found pending output packet %d\n",
+				__func__, xpad->last_out_packet);
+			packet = pkt;
+			break;
+		}
+	}
+
+	if (packet) {
+		memcpy(xpad->odata, packet->data, packet->len);
+		xpad->irq_out->transfer_buffer_length = packet->len;
+		return true;
+	}
+
+	return false;
+}
+
+/* Callers must hold xpad->odata_lock spinlock */
+static int xpad_try_sending_next_out_packet(struct usb_xpad *xpad)
+{
+	int error;
+
+	if (!xpad->irq_out_active && xpad_prepare_next_out_packet(xpad)) {
+		error = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+		if (error) {
+			dev_err(&xpad->intf->dev,
+				"%s - usb_submit_urb failed with result %d\n",
+				__func__, error);
+			return -EIO;
+		}
+
+		xpad->irq_out_active = true;
+	}
+
+	return 0;
+}
+
 static void xpad_irq_out(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
 	struct device *dev = &xpad->intf->dev;
-	int retval, status;
+	int status = urb->status;
+	int error;
+	unsigned long flags;
 
-	status = urb->status;
+	spin_lock_irqsave(&xpad->odata_lock, flags);
 
 	switch (status) {
 	case 0:
 		/* success */
-		return;
+		xpad->out_packets[xpad->last_out_packet].pending = false;
+		xpad->irq_out_active = xpad_prepare_next_out_packet(xpad);
+		break;
 
 	case -ECONNRESET:
 	case -ENOENT:
@@ -714,19 +784,26 @@ static void xpad_irq_out(struct urb *urb)
 		/* this urb is terminated, clean up */
 		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
 			__func__, status);
-		return;
+		xpad->irq_out_active = false;
+		break;
 
 	default:
 		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
 			__func__, status);
-		goto exit;
+		break;
 	}
 
-exit:
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval)
-		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
-			__func__, retval);
+	if (xpad->irq_out_active) {
+		error = usb_submit_urb(urb, GFP_ATOMIC);
+		if (error) {
+			dev_err(dev,
+				"%s - usb_submit_urb failed with result %d\n",
+				__func__, error);
+			xpad->irq_out_active = false;
+		}
+	}
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 }
 
 static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
@@ -745,7 +822,7 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		goto fail1;
 	}
 
-	mutex_init(&xpad->odata_mutex);
+	spin_lock_init(&xpad->odata_lock);
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -787,27 +864,55 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
 
 static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 {
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+	unsigned long flags;
 	int retval;
 
-	mutex_lock(&xpad->odata_mutex);
-
-	xpad->odata[0] = 0x08;
-	xpad->odata[1] = 0x00;
-	xpad->odata[2] = 0x0F;
-	xpad->odata[3] = 0xC0;
-	xpad->odata[4] = 0x00;
-	xpad->odata[5] = 0x00;
-	xpad->odata[6] = 0x00;
-	xpad->odata[7] = 0x00;
-	xpad->odata[8] = 0x00;
-	xpad->odata[9] = 0x00;
-	xpad->odata[10] = 0x00;
-	xpad->odata[11] = 0x00;
-	xpad->irq_out->transfer_buffer_length = 12;
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
+	packet->data[0] = 0x08;
+	packet->data[1] = 0x00;
+	packet->data[2] = 0x0F;
+	packet->data[3] = 0xC0;
+	packet->data[4] = 0x00;
+	packet->data[5] = 0x00;
+	packet->data[6] = 0x00;
+	packet->data[7] = 0x00;
+	packet->data[8] = 0x00;
+	packet->data[9] = 0x00;
+	packet->data[10] = 0x00;
+	packet->data[11] = 0x00;
+	packet->len = 12;
+	packet->pending = true;
+
+	/* Reset the sequence so we send out presence first */
+	xpad->last_out_packet = -1;
+	retval = xpad_try_sending_next_out_packet(xpad);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+
+	return retval;
+}
+
+static int xpad_start_xbox_one(struct usb_xpad *xpad)
+{
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
+	/* Xbox one controller needs to be initialized. */
+	packet->data[0] = 0x05;
+	packet->data[1] = 0x20;
+	packet->len = 2;
+	packet->pending = true;
 
 	retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 
-	mutex_unlock(&xpad->odata_mutex);
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 
 	return retval;
 }
@@ -816,8 +921,11 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
+	struct xpad_output_packet *packet = &xpad->out_packets[XPAD_OUT_FF_IDX];
 	__u16 strong;
 	__u16 weak;
+	int retval;
+	unsigned long flags;
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
@@ -825,69 +933,80 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	strong = effect->u.rumble.strong_magnitude;
 	weak = effect->u.rumble.weak_magnitude;
 
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
 	switch (xpad->xtype) {
 	case XTYPE_XBOX:
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x06;
-		xpad->odata[2] = 0x00;
-		xpad->odata[3] = strong / 256;	/* left actuator */
-		xpad->odata[4] = 0x00;
-		xpad->odata[5] = weak / 256;	/* right actuator */
-		xpad->irq_out->transfer_buffer_length = 6;
+		packet->data[0] = 0x00;
+		packet->data[1] = 0x06;
+		packet->data[2] = 0x00;
+		packet->data[3] = strong / 256;	/* left actuator */
+		packet->data[4] = 0x00;
+		packet->data[5] = weak / 256;	/* right actuator */
+		packet->len = 6;
+		packet->pending = true;
 		break;
 
 	case XTYPE_XBOX360:
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x08;
-		xpad->odata[2] = 0x00;
-		xpad->odata[3] = strong / 256;  /* left actuator? */
-		xpad->odata[4] = weak / 256;	/* right actuator? */
-		xpad->odata[5] = 0x00;
-		xpad->odata[6] = 0x00;
-		xpad->odata[7] = 0x00;
-		xpad->irq_out->transfer_buffer_length = 8;
+		packet->data[0] = 0x00;
+		packet->data[1] = 0x08;
+		packet->data[2] = 0x00;
+		packet->data[3] = strong / 256;  /* left actuator? */
+		packet->data[4] = weak / 256;	/* right actuator? */
+		packet->data[5] = 0x00;
+		packet->data[6] = 0x00;
+		packet->data[7] = 0x00;
+		packet->len = 8;
+		packet->pending = true;
 		break;
 
 	case XTYPE_XBOX360W:
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x01;
-		xpad->odata[2] = 0x0F;
-		xpad->odata[3] = 0xC0;
-		xpad->odata[4] = 0x00;
-		xpad->odata[5] = strong / 256;
-		xpad->odata[6] = weak / 256;
-		xpad->odata[7] = 0x00;
-		xpad->odata[8] = 0x00;
-		xpad->odata[9] = 0x00;
-		xpad->odata[10] = 0x00;
-		xpad->odata[11] = 0x00;
-		xpad->irq_out->transfer_buffer_length = 12;
+		packet->data[0] = 0x00;
+		packet->data[1] = 0x01;
+		packet->data[2] = 0x0F;
+		packet->data[3] = 0xC0;
+		packet->data[4] = 0x00;
+		packet->data[5] = strong / 256;
+		packet->data[6] = weak / 256;
+		packet->data[7] = 0x00;
+		packet->data[8] = 0x00;
+		packet->data[9] = 0x00;
+		packet->data[10] = 0x00;
+		packet->data[11] = 0x00;
+		packet->len = 12;
+		packet->pending = true;
 		break;
 
 	case XTYPE_XBOXONE:
-		xpad->odata[0] = 0x09; /* activate rumble */
-		xpad->odata[1] = 0x08;
-		xpad->odata[2] = 0x00;
-		xpad->odata[3] = 0x08; /* continuous effect */
-		xpad->odata[4] = 0x00; /* simple rumble mode */
-		xpad->odata[5] = 0x03; /* L and R actuator only */
-		xpad->odata[6] = 0x00; /* TODO: LT actuator */
-		xpad->odata[7] = 0x00; /* TODO: RT actuator */
-		xpad->odata[8] = strong / 256;	/* left actuator */
-		xpad->odata[9] = weak / 256;	/* right actuator */
-		xpad->odata[10] = 0x80;	/* length of pulse */
-		xpad->odata[11] = 0x00;	/* stop period of pulse */
-		xpad->irq_out->transfer_buffer_length = 12;
+		packet->data[0] = 0x09; /* activate rumble */
+		packet->data[1] = 0x08;
+		packet->data[2] = 0x00;
+		packet->data[3] = 0x08; /* continuous effect */
+		packet->data[4] = 0x00; /* simple rumble mode */
+		packet->data[5] = 0x03; /* L and R actuator only */
+		packet->data[6] = 0x00; /* TODO: LT actuator */
+		packet->data[7] = 0x00; /* TODO: RT actuator */
+		packet->data[8] = strong / 256;	/* left actuator */
+		packet->data[9] = weak / 256;	/* right actuator */
+		packet->data[10] = 0x80;	/* length of pulse */
+		packet->data[11] = 0x00;	/* stop period of pulse */
+		packet->len = 12;
+		packet->pending = true;
 		break;
 
 	default:
 		dev_dbg(&xpad->dev->dev,
 			"%s - rumble command sent to unsupported xpad type: %d\n",
 			__func__, xpad->xtype);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto out;
 	}
 
-	return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+	retval = xpad_try_sending_next_out_packet(xpad);
+
+out:
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+	return retval;
 }
 
 static int xpad_init_ff(struct usb_xpad *xpad)
@@ -938,36 +1057,44 @@ struct xpad_led {
  */
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_LED_IDX];
+	unsigned long flags;
+
 	command %= 16;
 
-	mutex_lock(&xpad->odata_mutex);
+	spin_lock_irqsave(&xpad->odata_lock, flags);
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad->odata[0] = 0x01;
-		xpad->odata[1] = 0x03;
-		xpad->odata[2] = command;
-		xpad->irq_out->transfer_buffer_length = 3;
+		packet->data[0] = 0x01;
+		packet->data[1] = 0x03;
+		packet->data[2] = command;
+		packet->len = 3;
+		packet->pending = true;
 		break;
+
 	case XTYPE_XBOX360W:
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x00;
-		xpad->odata[2] = 0x08;
-		xpad->odata[3] = 0x40 + command;
-		xpad->odata[4] = 0x00;
-		xpad->odata[5] = 0x00;
-		xpad->odata[6] = 0x00;
-		xpad->odata[7] = 0x00;
-		xpad->odata[8] = 0x00;
-		xpad->odata[9] = 0x00;
-		xpad->odata[10] = 0x00;
-		xpad->odata[11] = 0x00;
-		xpad->irq_out->transfer_buffer_length = 12;
+		packet->data[0] = 0x00;
+		packet->data[1] = 0x00;
+		packet->data[2] = 0x08;
+		packet->data[3] = 0x40 + command;
+		packet->data[4] = 0x00;
+		packet->data[5] = 0x00;
+		packet->data[6] = 0x00;
+		packet->data[7] = 0x00;
+		packet->data[8] = 0x00;
+		packet->data[9] = 0x00;
+		packet->data[10] = 0x00;
+		packet->data[11] = 0x00;
+		packet->len = 12;
+		packet->pending = true;
 		break;
 	}
 
-	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-	mutex_unlock(&xpad->odata_mutex);
+	xpad_try_sending_next_out_packet(xpad);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 }
 
 /*
@@ -1058,13 +1185,8 @@ static int xpad_open(struct input_dev *dev)
 	if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
 		return -EIO;
 
-	if (xpad->xtype == XTYPE_XBOXONE) {
-		/* Xbox one controller needs to be initialized. */
-		xpad->odata[0] = 0x05;
-		xpad->odata[1] = 0x20;
-		xpad->irq_out->transfer_buffer_length = 2;
-		return usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-	}
+	if (xpad->xtype == XTYPE_XBOXONE)
+		return xpad_start_xbox_one(xpad);
 
 	return 0;
 }
