From: Laura Abbott <labbott@fedoraproject.org>
Subject: [PATCHv3] Input: xpad - Fix double URB submission races
Date: Mon, 16 Nov 2015 14:47:13 -0800
Message-ID: <1447714033-13809-1-git-send-email-labbott@fedoraproject.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbbKPWrS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 17:47:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

The xpad driver has several races with respect to URB submission which
make it easy to end up with submission while active:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 3563 at drivers/usb/core/urb.c:339
usb_submit_urb+0x2ad/0x5a0()
URB ffff8804078ac240 submitted while active
CPU: 3 PID: 3563 Comm: led_test.sh Not tainted 4.2.0-rc4-xpad+ #14
Hardware name: LENOVO 20BFS0EC00/20BFS0EC00, BIOS GMET62WW (2.10 )
03/19/2014
0000000000000000 0000000017a45bc6 ffff8800c9a0fbd8 ffffffff81758a11
0000000000000000 ffff8800c9a0fc30 ffff8800c9a0fc18 ffffffff8109b656
0000000000000002 ffff8804078ac240 00000000000000d0 ffff8800c9806d60
Call Trace:
[<ffffffff81758a11>] dump_stack+0x45/0x57
[<ffffffff8109b656>] warn_slowpath_common+0x86/0xc0
[<ffffffff8109b6e5>] warn_slowpath_fmt+0x55/0x70
[<ffffffff8120f218>] ? do_truncate+0x88/0xc0
[<ffffffff815427fd>] usb_submit_urb+0x2ad/0x5a0
[<ffffffff81230df4>] ? mntput+0x24/0x40
[<ffffffff8121b667>] ? terminate_walk+0xc7/0xe0
[<ffffffffa0430877>] xpad_send_led_command+0xc7/0x110 [xpad]
[<ffffffffa04308d5>] xpad_led_set+0x15/0x20 [xpad]
[<ffffffff815f9678>] led_set_brightness+0x88/0xc0
[<ffffffff815f9b0e>] brightness_store+0x7e/0xc0
[<ffffffff814b7478>] dev_attr_store+0x18/0x30
[<ffffffff8128bba7>] sysfs_kf_write+0x37/0x40
[<ffffffff8128b15d>] kernfs_fop_write+0x11d/0x170
[<ffffffff81210d17>] __vfs_write+0x37/0x100
[<ffffffff81213b28>] ? __sb_start_write+0x58/0x110
[<ffffffff813124dd>] ? security_file_permission+0x3d/0xc0
[<ffffffff81211696>] vfs_write+0xa6/0x1a0
[<ffffffff8120e93a>] ? filp_close+0x5a/0x80
[<ffffffff81212385>] SyS_write+0x55/0xc0
[<ffffffff8175f0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
---[ end trace f573b768c94a66d6 ]---

This is easily reproducible with

while true; do
        for i in $(seq 0 5); do
                echo $i > /sys/class/leds/xpad0/subsystem/xpad0/brightness
        done
done

xpad_send_led_command attempts to protect against races by locking
around usb_submit_urb. This is not sufficent since usb_submit_urb
is asynchronous; the urb is considered to be in use until the callback
(xpad_irq_out) returns appropriately. Additionally, there is no
protection at all in xpad_play_effect which uses the same urb. Fix this
by only allowing URB submission after the IRQ callback is complete.
If another request comes in which URB submission is in progress, the
request may be stored for submission later.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
v3: Only keep a buffer of one command instead of all the commands
---
 drivers/input/joystick/xpad.c | 295 ++++++++++++++++++++++++++++--------------
 1 file changed, 201 insertions(+), 94 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index fd4100d..6a90cd5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -317,6 +317,14 @@ static struct usb_device_id xpad_table[] = {
 
 MODULE_DEVICE_TABLE(usb, xpad_table);
 
+#define OUT_IRQ_AVAILABLE	0
+#define OUT_IRQ_QUEUE_EMPTY	1
+#define OUT_IRQ_QUEUE_FULL	2
+
+#define OUT_IRQ_FF		0
+#define OUT_IRQ_LED		1
+#define OUT_IRQ_INQUIRY		2
+
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
 	struct usb_device *udev;	/* usb device */
@@ -330,8 +338,13 @@ struct usb_xpad {
 
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
+	unsigned char odata_queue[XPAD_PKT_LEN]; /* pending output data */
 	dma_addr_t odata_dma;
-	struct mutex odata_mutex;
+	spinlock_t submit_lock;
+	int transfer_length;
+	int submit_state;		/* Can the out urb be submitted */
+	int out_submitter;		/* which submitter is being processed */
+	int queue_submitter;		/* Which submission type is in the queue */
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -346,6 +359,104 @@ struct usb_xpad {
 };
 
 /*
+ * Must be called with the lock held
+ */
+static int __xpad_submit_urb(struct usb_xpad *xpad,
+			unsigned char odata[XPAD_PKT_LEN], int transfer_length,
+			int type, bool safe_submit)
+{
+	int ret;
+
+	if (safe_submit || xpad->submit_state == OUT_IRQ_AVAILABLE) {
+		memcpy(xpad->odata, odata, transfer_length);
+		xpad->irq_out->transfer_buffer_length = transfer_length;
+		ret = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+		xpad->submit_state = OUT_IRQ_QUEUE_EMPTY;
+		xpad->out_submitter = type;
+	} else {
+		/*
+		 * The goal here is to prevent starvation of any other type.
+		 * If this type matches what is being submitted and there is
+		 * another type in the queue, don't ovewrite it
+		 */
+		if (xpad->submit_state != OUT_IRQ_QUEUE_EMPTY &&
+		    xpad->out_submitter == type &&
+		    xpad->queue_submitter != type) {
+			ret = -EBUSY;
+			goto out;
+		}
+		memcpy(xpad->odata_queue, odata, transfer_length);
+		xpad->transfer_length = transfer_length;
+		xpad->submit_state = OUT_IRQ_QUEUE_FULL;
+		xpad->queue_submitter = type;
+		ret = 0;
+	}
+
+out:
+	return ret;
+}
+
+static int xpad_clear_queue(struct usb_xpad *xpad, bool again)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&xpad->submit_lock, flags);
+	if (again) {
+		ret = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+	} else if (xpad->submit_state == OUT_IRQ_QUEUE_FULL) {
+		ret = __xpad_submit_urb(xpad, xpad->odata_queue,
+					xpad->transfer_length,
+					xpad->submit_state,
+					true);
+	} else {
+		xpad->submit_state = OUT_IRQ_AVAILABLE;
+	}
+	spin_unlock_irqrestore(&xpad->submit_lock, flags);
+	return ret;
+}
+
+int xpad_submit_ff(struct usb_xpad *xpad, unsigned char odata[XPAD_PKT_LEN],
+			int transfer_length)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&xpad->submit_lock, flags);
+	ret = __xpad_submit_urb(xpad, odata, transfer_length, OUT_IRQ_FF,
+				false);
+	spin_unlock_irqrestore(&xpad->submit_lock, flags);
+	return ret;
+}
+
+int xpad_submit_led(struct usb_xpad *xpad, unsigned char odata[XPAD_PKT_LEN],
+			int transfer_length)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&xpad->submit_lock, flags);
+	ret = __xpad_submit_urb(xpad, odata, transfer_length, OUT_IRQ_LED,
+				false);
+	spin_unlock_irqrestore(&xpad->submit_lock, flags);
+	return ret;
+}
+
+int xpad_submit_inquiry(struct usb_xpad *xpad,
+			unsigned char odata[XPAD_PKT_LEN],
+			int transfer_length)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&xpad->submit_lock, flags);
+	ret = __xpad_submit_urb(xpad, odata, transfer_length, OUT_IRQ_INQUIRY,
+				false);
+	spin_unlock_irqrestore(&xpad->submit_lock, flags);
+	return ret;
+}
+
+/*
  *	xpad_process_packet
  *
  *	Completes a request by converting the data into events for the
@@ -689,7 +800,7 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
-		return;
+		break;
 
 	case -ECONNRESET:
 	case -ENOENT:
@@ -702,11 +813,10 @@ static void xpad_irq_out(struct urb *urb)
 	default:
 		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
 			__func__, status);
-		goto exit;
+		break;
 	}
 
-exit:
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	retval = xpad_clear_queue(xpad, status);
 	if (retval)
 		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
 			__func__, retval);
@@ -727,8 +837,8 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		error = -ENOMEM;
 		goto fail1;
 	}
-
-	mutex_init(&xpad->odata_mutex);
+	memset(xpad->odata_queue, 0, XPAD_PKT_LEN);
+	spin_lock_init(&xpad->submit_lock);
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -770,29 +880,24 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
 
 static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 {
-	int retval;
-
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
-
-	retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-
-	mutex_unlock(&xpad->odata_mutex);
-
-	return retval;
+	unsigned char odata[XPAD_PKT_LEN];
+	int transfer_buffer_length;
+
+	odata[0] = 0x08;
+	odata[1] = 0x00;
+	odata[2] = 0x0F;
+	odata[3] = 0xC0;
+	odata[4] = 0x00;
+	odata[5] = 0x00;
+	odata[6] = 0x00;
+	odata[7] = 0x00;
+	odata[8] = 0x00;
+	odata[9] = 0x00;
+	odata[10] = 0x00;
+	odata[11] = 0x00;
+	transfer_buffer_length = 12;
+
+	return xpad_submit_inquiry(xpad, odata, transfer_buffer_length);
 }
 
 #ifdef CONFIG_JOYSTICK_XPAD_FF
@@ -801,6 +906,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 	__u16 strong;
 	__u16 weak;
+	unsigned char odata[XPAD_PKT_LEN];
+	int transfer_buffer_length;
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
@@ -810,57 +917,57 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX:
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x06;
-		xpad->odata[2] = 0x00;
-		xpad->odata[3] = strong / 256;	/* left actuator */
-		xpad->odata[4] = 0x00;
-		xpad->odata[5] = weak / 256;	/* right actuator */
-		xpad->irq_out->transfer_buffer_length = 6;
+		odata[0] = 0x00;
+		odata[1] = 0x06;
+		odata[2] = 0x00;
+		odata[3] = strong / 256;	/* left actuator */
+		odata[4] = 0x00;
+		odata[5] = weak / 256;	/* right actuator */
+		transfer_buffer_length = 6;
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
+		odata[0] = 0x00;
+		odata[1] = 0x08;
+		odata[2] = 0x00;
+		odata[3] = strong / 256;  /* left actuator? */
+		odata[4] = weak / 256;	/* right actuator? */
+		odata[5] = 0x00;
+		odata[6] = 0x00;
+		odata[7] = 0x00;
+		transfer_buffer_length = 8;
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
+		odata[0] = 0x00;
+		odata[1] = 0x01;
+		odata[2] = 0x0F;
+		odata[3] = 0xC0;
+		odata[4] = 0x00;
+		odata[5] = strong / 256;
+		odata[6] = weak / 256;
+		odata[7] = 0x00;
+		odata[8] = 0x00;
+		odata[9] = 0x00;
+		odata[10] = 0x00;
+		odata[11] = 0x00;
+		transfer_buffer_length = 12;
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
+		odata[0] = 0x09; /* activate rumble */
+		odata[1] = 0x08;
+		odata[2] = 0x00;
+		odata[3] = 0x08; /* continuous effect */
+		odata[4] = 0x00; /* simple rumble mode */
+		odata[5] = 0x03; /* L and R actuator only */
+		odata[6] = 0x00; /* TODO: LT actuator */
+		odata[7] = 0x00; /* TODO: RT actuator */
+		odata[8] = strong / 256;	/* left actuator */
+		odata[9] = weak / 256;	/* right actuator */
+		odata[10] = 0x80;	/* length of pulse */
+		odata[11] = 0x00;	/* stop period of pulse */
+		transfer_buffer_length = 12;
 		break;
 
 	default:
@@ -870,7 +977,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		return -EINVAL;
 	}
 
-	return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+	return xpad_submit_ff(xpad, odata, transfer_buffer_length);
 }
 
 static int xpad_init_ff(struct usb_xpad *xpad)
@@ -921,36 +1028,36 @@ struct xpad_led {
  */
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	command %= 16;
+	unsigned char odata[XPAD_PKT_LEN];
+	int transfer_buffer_length = 0;
 
-	mutex_lock(&xpad->odata_mutex);
+	command %= 16;
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad->odata[0] = 0x01;
-		xpad->odata[1] = 0x03;
-		xpad->odata[2] = command;
-		xpad->irq_out->transfer_buffer_length = 3;
+		odata[0] = 0x01;
+		odata[1] = 0x03;
+		odata[2] = command;
+		transfer_buffer_length = 3;
 		break;
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
+		odata[0] = 0x00;
+		odata[1] = 0x00;
+		odata[2] = 0x08;
+		odata[3] = 0x40 + command;
+		odata[4] = 0x00;
+		odata[5] = 0x00;
+		odata[6] = 0x00;
+		odata[7] = 0x00;
+		odata[8] = 0x00;
+		odata[9] = 0x00;
+		odata[10] = 0x00;
+		odata[11] = 0x00;
+		transfer_buffer_length = 12;
 		break;
 	}
 
-	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-	mutex_unlock(&xpad->odata_mutex);
+	xpad_submit_led(xpad, odata, transfer_buffer_length);
 }
 
 /*
-- 
2.5.0

