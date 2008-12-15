From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]hopefully final version of full autosuspend for usb hid
Date: Mon, 15 Dec 2008 16:16:13 +0100
Message-ID: <200812151616.16888.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:48018 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYLOPOY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2008 10:14:24 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jirislaby@gmail.com>, pavel@ucw.cz, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

This uses the USB busy mechanism for aggessive autosuspend of USB
HID devices. It autosuspends all opened devices supporting remote wakeup
after a timeout unless

- output is being done to the device
- a key is being held down (remote wakeup isn't triggered upon key release)
- LED(s) are lit
- hiddev is opened

As in the current driver closed devices will be autosuspended even if they
don't support remote wakeup.

The patch is quite large because output to devices is done in hard interrupt
context meaning a lot a queuing and locking had to be touched. The LED stuff
has been solved by means of a simple counter. Additions to the generic HID code
could be avoided. In addition it now covers hidraw. It contains an embryonic
version of an API to let the generic HID code tell the lower levels which
capabilities with respect to power management are needed.

Signed-off-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver

---

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 40df3e1..2c321fb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1719,6 +1719,22 @@ static DECLARE_WORK(hid_compat_work, hid_compat_load);
 static struct workqueue_struct *hid_compat_wq;
 #endif
 
+int hid_check_keys_pressed(struct hid_device *hid)
+{
+	struct hid_input *hidinput;
+	int i;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		for (i = 0; i < BITS_TO_LONGS(KEY_MAX); i++)
+			if (hidinput->input->key[i])
+				return 1;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
+
 static int __init hid_init(void)
 {
 	int ret;
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 96ec1ba..e8e2bac 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -181,9 +181,17 @@ static int hidraw_open(struct inode *inode, struct file *file)
 
 	dev = hidraw_table[minor];
 	if (!dev->open++) {
+		if (dev->hid->ll_driver->power) {
+			err = dev->hid->ll_driver->power(dev->hid, PM_HINT_FULLON);
+			if (err < 0)
+				goto out_unlock;
+		}
 		err = dev->hid->ll_driver->open(dev->hid);
-		if (err < 0)
+		if (err < 0) {
+			if (dev->hid->ll_driver->power)
+				dev->hid->ll_driver->power(dev->hid, PM_HINT_NORMAL);
 			dev->open--;
+		}
 	}
 
 out_unlock:
@@ -209,10 +217,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	list_del(&list->node);
 	dev = hidraw_table[minor];
 	if (!--dev->open) {
-		if (list->hidraw->exist)
+		if (list->hidraw->exist) {
+			if (dev->hid->ll_driver->power)
+				dev->hid->ll_driver->power(dev->hid, PM_HINT_NORMAL);
 			dev->hid->ll_driver->close(dev->hid);
-		else
+		} else {
 			kfree(list->hidraw);
+		}
 	}
 
 	kfree(list);
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 606369e..fa7ff1f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
  *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007-2008 Oliver Neukum
  */
 
 /*
@@ -27,6 +28,7 @@
 #include <asm/byteorder.h>
 #include <linux/input.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <linux/usb.h>
 
@@ -53,6 +55,10 @@ static unsigned int hid_mousepoll_interval;
 module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
 MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
 
+static unsigned int ignoreled;
+module_param_named(ignoreled, ignoreled, uint, 0644);
+MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
+
 /* Quirks specified at module load time */
 static char *quirks_param[MAX_USBHID_BOOT_QUIRKS] = { [ 0 ... (MAX_USBHID_BOOT_QUIRKS - 1) ] = NULL };
 module_param_array_named(quirks, quirks_param, charp, NULL, 0444);
@@ -63,8 +69,13 @@ MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
 /*
  * Input submission and I/O error handler.
  */
+static DEFINE_MUTEX(hid_open_mut);
+static struct workqueue_struct *resumption_waker;
 
 static void hid_io_error(struct hid_device *hid);
+static int hid_submit_out(struct hid_device *hid);
+static int hid_submit_ctrl(struct hid_device *hid);
+static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid);
 
 /* Start up the input URB */
 static int hid_start_in(struct hid_device *hid)
@@ -73,15 +84,16 @@ static int hid_start_in(struct hid_device *hid)
 	int rc = 0;
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	spin_lock_irqsave(&usbhid->inlock, flags);
-	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+	spin_lock_irqsave(&usbhid->lock, flags);
+	if (hid->open > 0 &&
 			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
+			!test_bit(HID_REPORTED_IDLE, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 	}
-	spin_unlock_irqrestore(&usbhid->inlock, flags);
+	spin_unlock_irqrestore(&usbhid->lock, flags);
 	return rc;
 }
 
@@ -146,7 +158,7 @@ static void hid_io_error(struct hid_device *hid)
 	unsigned long flags;
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	spin_lock_irqsave(&usbhid->inlock, flags);
+	spin_lock_irqsave(&usbhid->lock, flags);
 
 	/* Stop when disconnected */
 	if (test_bit(HID_DISCONNECTED, &usbhid->iofl))
@@ -176,7 +188,51 @@ static void hid_io_error(struct hid_device *hid)
 	mod_timer(&usbhid->io_retry,
 			jiffies + msecs_to_jiffies(usbhid->retry_delay));
 done:
-	spin_unlock_irqrestore(&usbhid->inlock, flags);
+	spin_unlock_irqrestore(&usbhid->lock, flags);
+}
+
+static void usbhid_mark_busy(struct usbhid_device *usbhid)
+{
+	struct usb_interface *intf = usbhid->intf;
+
+	usb_mark_last_busy(interface_to_usbdev(intf));
+}
+
+static int usbhid_restart_out_queue(struct usbhid_device *usbhid)
+{
+	struct hid_device *hid = usb_get_intfdata(usbhid->intf);
+	int kicked;
+
+	if (!hid)
+		return 0;
+
+	if ((kicked = (usbhid->outhead != usbhid->outtail))) {
+		dbg("Kicking head %d tail %d", usbhid->outhead, usbhid->outtail);
+		if (hid_submit_out(hid)) {
+			clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
+			wake_up(&usbhid->wait);
+		}
+	}
+	return kicked;
+}
+
+static int usbhid_restart_ctrl_queue(struct usbhid_device *usbhid)
+{
+	struct hid_device *hid = usb_get_intfdata(usbhid->intf);
+	int kicked;
+
+	WARN_ON(hid == NULL);
+	if (!hid)
+		return 0;
+
+	if ((kicked = (usbhid->ctrlhead != usbhid->ctrltail))) {
+		dbg("Kicking head %d tail %d", usbhid->ctrlhead, usbhid->ctrltail);
+		if (hid_submit_ctrl(hid)) {
+			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
+			wake_up(&usbhid->wait);
+		}
+	}
+	return kicked;
 }
 
 /*
@@ -191,12 +247,23 @@ static void hid_irq_in(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:			/* success */
+		usbhid_mark_busy(usbhid);
 		usbhid->retry_delay = 0;
 		hid_input_report(urb->context, HID_INPUT_REPORT,
 				 urb->transfer_buffer,
 				 urb->actual_length, 1);
+		/*
+		 * autosuspend refused while keys are pressed
+		 * because most keyboards don't wake up when
+		 * a key is released
+		 */
+		if (hid_check_keys_pressed(hid))
+			set_bit(HID_KEYS_PRESSED, &usbhid->iofl);
+		else
+			clear_bit(HID_KEYS_PRESSED, &usbhid->iofl);
 		break;
 	case -EPIPE:		/* stall */
+		usbhid_mark_busy(usbhid);
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 		set_bit(HID_CLEAR_HALT, &usbhid->iofl);
 		schedule_work(&usbhid->reset_work);
@@ -210,6 +277,7 @@ static void hid_irq_in(struct urb *urb)
 	case -EPROTO:		/* protocol error or unplug */
 	case -ETIME:		/* protocol error or unplug */
 	case -ETIMEDOUT:	/* Should never happen, but... */
+		usbhid_mark_busy(usbhid);
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 		hid_io_error(hid);
 		return;
@@ -240,16 +308,25 @@ static int hid_submit_out(struct hid_device *hid)
 	report = usbhid->out[usbhid->outtail].report;
 	raw_report = usbhid->out[usbhid->outtail].raw_report;
 
-	usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
-	usbhid->urbout->dev = hid_to_usb_dev(hid);
-	memcpy(usbhid->outbuf, raw_report, usbhid->urbout->transfer_buffer_length);
-	kfree(raw_report);
+	if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
+		usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
+		usbhid->urbout->dev = hid_to_usb_dev(hid);
+		memcpy(usbhid->outbuf, raw_report, usbhid->urbout->transfer_buffer_length);
+		kfree(raw_report);
 
-	dbg_hid("submitting out urb\n");
+		dbg_hid("submitting out urb\n");
 
-	if (usb_submit_urb(usbhid->urbout, GFP_ATOMIC)) {
-		err_hid("usb_submit_urb(out) failed");
-		return -1;
+		if (usb_submit_urb(usbhid->urbout, GFP_ATOMIC)) {
+			err_hid("usb_submit_urb(out) failed");
+			return -1;
+		}
+	} else {
+		/*
+		 * queue work to wake up the device.
+		 * as the work queue is freezeable, this is safe
+		 * with respect to STD and STR
+		 */
+		queue_work(resumption_waker, &usbhid->restart_work);	
 	}
 
 	return 0;
@@ -267,41 +344,50 @@ static int hid_submit_ctrl(struct hid_device *hid)
 	raw_report = usbhid->ctrl[usbhid->ctrltail].raw_report;
 	dir = usbhid->ctrl[usbhid->ctrltail].dir;
 
-	len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
-	if (dir == USB_DIR_OUT) {
-		usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
-		usbhid->urbctrl->transfer_buffer_length = len;
-		memcpy(usbhid->ctrlbuf, raw_report, len);
-		kfree(raw_report);
-	} else {
-		int maxpacket, padlen;
-
-		usbhid->urbctrl->pipe = usb_rcvctrlpipe(hid_to_usb_dev(hid), 0);
-		maxpacket = usb_maxpacket(hid_to_usb_dev(hid), usbhid->urbctrl->pipe, 0);
-		if (maxpacket > 0) {
-			padlen = DIV_ROUND_UP(len, maxpacket);
-			padlen *= maxpacket;
-			if (padlen > usbhid->bufsize)
-				padlen = usbhid->bufsize;
-		} else
-			padlen = 0;
-		usbhid->urbctrl->transfer_buffer_length = padlen;
-	}
-	usbhid->urbctrl->dev = hid_to_usb_dev(hid);
+	if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
+		len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
+		if (dir == USB_DIR_OUT) {
+			usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
+			usbhid->urbctrl->transfer_buffer_length = len;
+			memcpy(usbhid->ctrlbuf, raw_report, len);
+			kfree(raw_report);
+		} else {
+			int maxpacket, padlen;
+
+			usbhid->urbctrl->pipe = usb_rcvctrlpipe(hid_to_usb_dev(hid), 0);
+			maxpacket = usb_maxpacket(hid_to_usb_dev(hid), usbhid->urbctrl->pipe, 0);
+			if (maxpacket > 0) {
+				padlen = DIV_ROUND_UP(len, maxpacket);
+				padlen *= maxpacket;
+				if (padlen > usbhid->bufsize)
+					padlen = usbhid->bufsize;
+			} else
+				padlen = 0;
+			usbhid->urbctrl->transfer_buffer_length = padlen;
+		}
+		usbhid->urbctrl->dev = hid_to_usb_dev(hid);
 
-	usbhid->cr->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE | dir;
-	usbhid->cr->bRequest = (dir == USB_DIR_OUT) ? HID_REQ_SET_REPORT : HID_REQ_GET_REPORT;
-	usbhid->cr->wValue = cpu_to_le16(((report->type + 1) << 8) | report->id);
-	usbhid->cr->wIndex = cpu_to_le16(usbhid->ifnum);
-	usbhid->cr->wLength = cpu_to_le16(len);
+		usbhid->cr->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE | dir;
+		usbhid->cr->bRequest = (dir == USB_DIR_OUT) ? HID_REQ_SET_REPORT : HID_REQ_GET_REPORT;
+		usbhid->cr->wValue = cpu_to_le16(((report->type + 1) << 8) | report->id);
+		usbhid->cr->wIndex = cpu_to_le16(usbhid->ifnum);
+		usbhid->cr->wLength = cpu_to_le16(len);
 
-	dbg_hid("submitting ctrl urb: %s wValue=0x%04x wIndex=0x%04x wLength=%u\n",
-		usbhid->cr->bRequest == HID_REQ_SET_REPORT ? "Set_Report" : "Get_Report",
-		usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);
+		dbg_hid("submitting ctrl urb: %s wValue=0x%04x wIndex=0x%04x wLength=%u\n",
+			usbhid->cr->bRequest == HID_REQ_SET_REPORT ? "Set_Report" : "Get_Report",
+			usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);
 
-	if (usb_submit_urb(usbhid->urbctrl, GFP_ATOMIC)) {
-		err_hid("usb_submit_urb(ctrl) failed");
-		return -1;
+		if (usb_submit_urb(usbhid->urbctrl, GFP_ATOMIC)) {
+			err_hid("usb_submit_urb(ctrl) failed");
+			return -1;
+		}
+	} else {
+		/*
+		 * queue work to wake up the device.
+		 * as the work queue is freezeable, this is safe
+		 * with respect to STD and STR
+		 */
+		queue_work(resumption_waker, &usbhid->restart_work);	
 	}
 
 	return 0;
@@ -333,7 +419,7 @@ static void hid_irq_out(struct urb *urb)
 				"received\n", urb->status);
 	}
 
-	spin_lock_irqsave(&usbhid->outlock, flags);
+	spin_lock_irqsave(&usbhid->lock, flags);
 
 	if (unplug)
 		usbhid->outtail = usbhid->outhead;
@@ -345,12 +431,12 @@ static void hid_irq_out(struct urb *urb)
 			clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
 			wake_up(&usbhid->wait);
 		}
-		spin_unlock_irqrestore(&usbhid->outlock, flags);
+		spin_unlock_irqrestore(&usbhid->lock, flags);
 		return;
 	}
 
 	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->outlock, flags);
+	spin_unlock_irqrestore(&usbhid->lock, flags);
 	wake_up(&usbhid->wait);
 }
 
@@ -362,12 +448,11 @@ static void hid_ctrl(struct urb *urb)
 {
 	struct hid_device *hid = urb->context;
 	struct usbhid_device *usbhid = hid->driver_data;
-	unsigned long flags;
-	int unplug = 0;
+	int unplug = 0, status = urb->status;
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
+	spin_lock(&usbhid->lock);
 
-	switch (urb->status) {
+	switch (status) {
 	case 0:			/* success */
 		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
 			hid_input_report(urb->context,
@@ -384,7 +469,7 @@ static void hid_ctrl(struct urb *urb)
 		break;
 	default:		/* error */
 		dev_warn(&urb->dev->dev, "ctrl urb status %d "
-				"received\n", urb->status);
+				"received\n", status);
 	}
 
 	if (unplug)
@@ -397,19 +482,18 @@ static void hid_ctrl(struct urb *urb)
 			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
 			wake_up(&usbhid->wait);
 		}
-		spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+		spin_unlock(&usbhid->lock);
 		return;
 	}
 
 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+	spin_unlock(&usbhid->lock);
 	wake_up(&usbhid->wait);
 }
 
-void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+void __usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
 {
 	int head;
-	unsigned long flags;
 	struct usbhid_device *usbhid = hid->driver_data;
 	int len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 
@@ -417,18 +501,13 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 		return;
 
 	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT) {
-
-		spin_lock_irqsave(&usbhid->outlock, flags);
-
 		if ((head = (usbhid->outhead + 1) & (HID_OUTPUT_FIFO_SIZE - 1)) == usbhid->outtail) {
-			spin_unlock_irqrestore(&usbhid->outlock, flags);
 			dev_warn(&hid->dev, "output queue full\n");
 			return;
 		}
 
 		usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
 		if (!usbhid->out[usbhid->outhead].raw_report) {
-			spin_unlock_irqrestore(&usbhid->outlock, flags);
 			dev_warn(&hid->dev, "output queueing failed\n");
 			return;
 		}
@@ -439,15 +518,10 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 		if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl))
 			if (hid_submit_out(hid))
 				clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-
-		spin_unlock_irqrestore(&usbhid->outlock, flags);
 		return;
 	}
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
-
 	if ((head = (usbhid->ctrlhead + 1) & (HID_CONTROL_FIFO_SIZE - 1)) == usbhid->ctrltail) {
-		spin_unlock_irqrestore(&usbhid->ctrllock, flags);
 		dev_warn(&hid->dev, "control queue full\n");
 		return;
 	}
@@ -455,7 +529,6 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 	if (dir == USB_DIR_OUT) {
 		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
 		if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
-			spin_unlock_irqrestore(&usbhid->ctrllock, flags);
 			dev_warn(&hid->dev, "control queueing failed\n");
 			return;
 		}
@@ -468,15 +541,25 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 	if (!test_and_set_bit(HID_CTRL_RUNNING, &usbhid->iofl))
 		if (hid_submit_ctrl(hid))
 			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
+}
 
-	spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usbhid->lock, flags);
+	__usbhid_submit_report(hid, report, dir);
+	spin_unlock_irqrestore(&usbhid->lock, flags);
 }
 EXPORT_SYMBOL_GPL(usbhid_submit_report);
 
 static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
+	struct usbhid_device *usbhid = hid->driver_data;
 	struct hid_field *field;
+	unsigned long flags;
 	int offset;
 
 	if (type == EV_FF)
@@ -491,6 +574,15 @@ static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, un
 	}
 
 	hid_set_field(field, offset, value);
+	if (value) {
+		spin_lock_irqsave(&usbhid->lock, flags);
+		usbhid->ledcount++;
+		spin_unlock_irqrestore(&usbhid->lock, flags);
+	} else {
+		spin_lock_irqsave(&usbhid->lock, flags);
+		usbhid->ledcount--;
+		spin_unlock_irqrestore(&usbhid->lock, flags);
+	}
 	usbhid_submit_report(hid, field->report, USB_DIR_OUT);
 
 	return 0;
@@ -539,15 +631,22 @@ int usbhid_open(struct hid_device *hid)
 	struct usbhid_device *usbhid = hid->driver_data;
 	int res;
 
+	mutex_lock(&hid_open_mut);
 	if (!hid->open++) {
 		res = usb_autopm_get_interface(usbhid->intf);
+		/* the device must be awake to reliable request remote wakeup */
 		if (res < 0) {
 			hid->open--;
+			mutex_unlock(&hid_open_mut);
 			return -EIO;
 		}
+		usbhid->intf->needs_remote_wakeup = 1;
+		if (hid_start_in(hid))
+			hid_io_error(hid);
+ 
+		usb_autopm_put_interface(usbhid->intf);
 	}
-	if (hid_start_in(hid))
-		hid_io_error(hid);
+	mutex_unlock(&hid_open_mut);
 	return 0;
 }
 
@@ -555,10 +654,22 @@ void usbhid_close(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
+	mutex_lock(&hid_open_mut);
+
+	/* protecting hid->open to make sure we don't restart
+	 * data acquistion due to a resumption we no longer
+	 * care about
+	 */
+	spin_lock_irq(&usbhid->lock);
 	if (!--hid->open) {
+		spin_unlock_irq(&usbhid->lock);
 		usb_kill_urb(usbhid->urbin);
-		usb_autopm_put_interface(usbhid->intf);
+		flush_scheduled_work();
+		usbhid->intf->needs_remote_wakeup = 0;
+	} else {
+		spin_unlock_irq(&usbhid->lock);
 	}
+	mutex_unlock(&hid_open_mut);
 }
 
 /*
@@ -687,6 +798,25 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 	return ret;
 }
 
+static void usbhid_restart_queues(struct usbhid_device *usbhid)
+{
+	if (usbhid->urbout)
+		usbhid_restart_out_queue(usbhid);
+	usbhid_restart_ctrl_queue(usbhid);
+}
+
+static void __usbhid_restart_queues(struct work_struct *work)
+{
+	struct usbhid_device *usbhid =
+		container_of(work, struct usbhid_device, restart_work);
+	int r;
+
+	r = usb_autopm_get_interface(usbhid->intf);
+	if (r < 0)
+		return;
+	usb_autopm_put_interface(usbhid->intf);
+}
+
 static void hid_free_buffers(struct usb_device *dev, struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
@@ -850,11 +980,11 @@ static int usbhid_start(struct hid_device *hid)
 
 	init_waitqueue_head(&usbhid->wait);
 	INIT_WORK(&usbhid->reset_work, hid_reset);
+	INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
 
-	spin_lock_init(&usbhid->inlock);
-	spin_lock_init(&usbhid->outlock);
-	spin_lock_init(&usbhid->ctrllock);
+	spin_lock_init(&usbhid->lock);
+	spin_lock_init(&usbhid->lock);
 
 	usbhid->intf = intf;
 	usbhid->ifnum = interface->desc.bInterfaceNumber;
@@ -897,15 +1027,14 @@ static void usbhid_stop(struct hid_device *hid)
 		return;
 
 	clear_bit(HID_STARTED, &usbhid->iofl);
-	spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
+	spin_lock_irq(&usbhid->lock);	/* Sync with error handler */
 	set_bit(HID_DISCONNECTED, &usbhid->iofl);
-	spin_unlock_irq(&usbhid->inlock);
+	spin_unlock_irq(&usbhid->lock);
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbout);
 	usb_kill_urb(usbhid->urbctrl);
 
-	del_timer_sync(&usbhid->io_retry);
-	cancel_work_sync(&usbhid->reset_work);
+	hid_cancel_delayed_stuff(usbhid);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_disconnect(hid);
@@ -926,12 +1055,28 @@ static void usbhid_stop(struct hid_device *hid)
 	hid_free_buffers(hid_to_usb_dev(hid), hid);
 }
 
+static int usbhid_power(struct hid_device *hid, int lvl)
+{
+	int r = 0;
+
+	switch (lvl) {
+	case PM_HINT_FULLON:
+		r = usbhid_get_power(hid);
+		break;
+	case PM_HINT_NORMAL:
+		usbhid_put_power(hid);
+		break;
+	}
+	return r;
+}
+
 static struct hid_ll_driver usb_hid_driver = {
 	.parse = usbhid_parse,
 	.start = usbhid_start,
 	.stop = usbhid_stop,
 	.open = usbhid_open,
 	.close = usbhid_close,
+	.power = usbhid_power,
 	.hidinput_input_event = usb_hidinput_input_event,
 };
 
@@ -1040,19 +1185,75 @@ static void hid_disconnect(struct usb_interface *intf)
 	kfree(usbhid);
 }
 
+static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
+{
+	del_timer_sync(&usbhid->io_retry);
+	cancel_work_sync(&usbhid->restart_work);
+	cancel_work_sync(&usbhid->reset_work);
+}
+
+static void hid_cease_io(struct usbhid_device *usbhid)
+{
+	del_timer(&usbhid->io_retry);
+	usb_kill_urb(usbhid->urbin);
+	usb_kill_urb(usbhid->urbctrl);
+	usb_kill_urb(usbhid->urbout);
+	flush_scheduled_work();
+}
+
 static int hid_suspend(struct usb_interface *intf, pm_message_t message)
 {
-	struct hid_device *hid = usb_get_intfdata (intf);
+	struct hid_device *hid = usb_get_intfdata(intf);
 	struct usbhid_device *usbhid = hid->driver_data;
+	struct usb_device *udev = interface_to_usbdev(intf);
+	int status;
 
-	if (!test_bit(HID_STARTED, &usbhid->iofl))
-		return 0;
+	if (udev->auto_pm) {
+		spin_lock_irq(&usbhid->lock);	/* Sync with error handler */
+		if (!test_bit(HID_RESET_PENDING, &usbhid->iofl)
+		    && !test_bit(HID_CLEAR_HALT, &usbhid->iofl)
+		    && !test_bit(HID_OUT_RUNNING, &usbhid->iofl)
+		    && !test_bit(HID_CTRL_RUNNING, &usbhid->iofl)
+		    && !test_bit(HID_KEYS_PRESSED, &usbhid->iofl)
+		    && (!usbhid->ledcount || ignoreled))
+		{
+			set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+			spin_unlock_irq(&usbhid->lock);
+		} else {
+			usbhid_mark_busy(usbhid);
+			spin_unlock_irq(&usbhid->lock);
+			return -EBUSY;
+		}
+		
+	} else {
+		spin_lock_irq(&usbhid->lock);
+		set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+		spin_unlock_irq(&usbhid->lock);
+		if (usbhid_wait_io(hid) < 0)
+			return -EIO;
+	}
 
-	spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
-	set_bit(HID_SUSPENDED, &usbhid->iofl);
-	spin_unlock_irq(&usbhid->inlock);
-	del_timer_sync(&usbhid->io_retry);
-	usb_kill_urb(usbhid->urbin);
+	if (!ignoreled && udev->auto_pm) {
+		spin_lock_irq(&usbhid->lock);
+		if (test_bit(HID_LED_ON, &usbhid->iofl)) {
+			spin_unlock_irq(&usbhid->lock);
+			usbhid_mark_busy(usbhid);
+			return -EBUSY;
+		}
+		spin_unlock_irq(&usbhid->lock);
+	}
+
+	hid_cancel_delayed_stuff(usbhid);
+	hid_cease_io(usbhid);
+
+	if (udev->auto_pm && test_bit(HID_KEYS_PRESSED, &usbhid->iofl)) {
+		/* lost race against keypresses */
+		status = hid_start_in(hid);
+		if (status < 0)
+			hid_io_error(hid);
+		usbhid_mark_busy(usbhid);
+		return -EBUSY;
+	}
 	dev_dbg(&intf->dev, "suspend\n");
 	return 0;
 }
@@ -1066,18 +1267,33 @@ static int hid_resume(struct usb_interface *intf)
 	if (!test_bit(HID_STARTED, &usbhid->iofl))
 		return 0;
 
-	clear_bit(HID_SUSPENDED, &usbhid->iofl);
+	clear_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+	usbhid_mark_busy(usbhid);
+
+	if (test_bit(HID_CLEAR_HALT, &usbhid->iofl) ||
+	    test_bit(HID_RESET_PENDING, &usbhid->iofl))
+		schedule_work(&usbhid->reset_work);
 	usbhid->retry_delay = 0;
 	status = hid_start_in(hid);
+	if (status < 0)
+		hid_io_error(hid);
+	usbhid_restart_queues(usbhid);
+
 	dev_dbg(&intf->dev, "resume status %d\n", status);
-	return status;
+	return 0;
 }
 
 /* Treat USB reset pretty much the same as suspend/resume */
 static int hid_pre_reset(struct usb_interface *intf)
 {
-	/* FIXME: What if the interface is already suspended? */
-	hid_suspend(intf, PMSG_ON);
+	struct hid_device *hid = usb_get_intfdata(intf);
+	struct usbhid_device *usbhid = hid->driver_data;
+
+	spin_lock_irq(&usbhid->lock);
+	set_bit(HID_RESET_PENDING, &usbhid->iofl);
+	spin_unlock_irq(&usbhid->lock);
+	hid_cease_io(usbhid);
+
 	return 0;
 }
 
@@ -1085,11 +1301,35 @@ static int hid_pre_reset(struct usb_interface *intf)
 static int hid_post_reset(struct usb_interface *intf)
 {
 	struct usb_device *dev = interface_to_usbdev (intf);
-
+	struct hid_device *hid = usb_get_intfdata(intf);
+	struct usbhid_device *usbhid = hid->driver_data;
+	int status;
+ 
+	spin_lock_irq(&usbhid->lock);
+	clear_bit(HID_RESET_PENDING, &usbhid->iofl);
+	spin_unlock_irq(&usbhid->lock);
 	hid_set_idle(dev, intf->cur_altsetting->desc.bInterfaceNumber, 0, 0);
 	/* FIXME: Any more reinitialization needed? */
+	status = hid_start_in(hid);
+	if (status < 0)
+		hid_io_error(hid);
+	usbhid_restart_queues(usbhid);
 
-	return hid_resume(intf);
+	return 0;
+}
+
+int usbhid_get_power(struct hid_device *hid)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+ 
+	return usb_autopm_get_interface(usbhid->intf);
+}
+
+void usbhid_put_power(struct hid_device *hid)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+ 
+	usb_autopm_put_interface(usbhid->intf);
 }
 
 static struct usb_device_id hid_usb_ids [] = {
@@ -1125,7 +1365,11 @@ static struct hid_driver hid_usb_driver = {
 
 static int __init hid_init(void)
 {
-	int retval;
+	int retval = -ENOMEM;
+
+	resumption_waker = create_freezeable_workqueue("usbhid_resumer");
+	if (!resumption_waker)
+		goto no_queue;
 	retval = hid_register_driver(&hid_usb_driver);
 	if (retval)
 		goto hid_register_fail;
@@ -1149,6 +1393,8 @@ hiddev_init_fail:
 usbhid_quirks_init_fail:
 	hid_unregister_driver(&hid_usb_driver);
 hid_register_fail:
+	destroy_workqueue(resumption_waker);
+no_queue:
 	return retval;
 }
 
@@ -1158,6 +1404,7 @@ static void __exit hid_exit(void)
 	hiddev_exit();
 	usbhid_quirks_exit();
 	hid_unregister_driver(&hid_usb_driver);
+	destroy_workqueue(resumption_waker);
 }
 
 module_init(hid_init);
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 83e851a..2096397 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -247,10 +247,12 @@ static int hiddev_release(struct inode * inode, struct file * file)
 	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
 
 	if (!--list->hiddev->open) {
-		if (list->hiddev->exist)
+		if (list->hiddev->exist) {
 			usbhid_close(list->hiddev->hid);
-		else
+			usbhid_put_power(list->hiddev->hid);
+		} else {
 			kfree(list->hiddev);
+		}
 	}
 
 	kfree(list);
@@ -265,6 +267,7 @@ static int hiddev_open(struct inode *inode, struct file *file)
 {
 	struct hiddev_list *list;
 	unsigned long flags;
+	int res;
 
 	int i = iminor(inode) - HIDDEV_MINOR_BASE;
 
@@ -283,8 +286,13 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	file->private_data = list;
 
 	if (!list->hiddev->open++)
-		if (list->hiddev->exist)
-			usbhid_open(hiddev_table[i]->hid);
+		if (list->hiddev->exist) {
+			struct hid_device *hid = hiddev_table[i]->hid;
+			res = usbhid_get_power(hid);
+			if (res < 0)
+				return -EIO;
+			usbhid_open(hid);
+		}
 
 	return 0;
 }
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 332abcd..abf40ba 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -38,7 +38,10 @@ int usbhid_wait_io(struct hid_device* hid);
 void usbhid_close(struct hid_device *hid);
 int usbhid_open(struct hid_device *hid);
 void usbhid_init_reports(struct hid_device *hid);
-void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir);
+void usbhid_submit_report
+(struct hid_device *hid, struct hid_report *report, unsigned char dir);
+int usbhid_get_power(struct hid_device *hid);
+void usbhid_put_power(struct hid_device *hid);
 
 /*
  * USB-specific HID struct, to be pointed to
@@ -56,7 +59,6 @@ struct usbhid_device {
 	struct urb *urbin;                                              /* Input URB */
 	char *inbuf;                                                    /* Input buffer */
 	dma_addr_t inbuf_dma;                                           /* Input buffer dma */
-	spinlock_t inlock;                                              /* Input fifo spinlock */
 
 	struct urb *urbctrl;                                            /* Control URB */
 	struct usb_ctrlrequest *cr;                                     /* Control request struct */
@@ -65,21 +67,22 @@ struct usbhid_device {
 	unsigned char ctrlhead, ctrltail;                               /* Control fifo head & tail */
 	char *ctrlbuf;                                                  /* Control buffer */
 	dma_addr_t ctrlbuf_dma;                                         /* Control buffer dma */
-	spinlock_t ctrllock;                                            /* Control fifo spinlock */
 
 	struct urb *urbout;                                             /* Output URB */
 	struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Output pipe fifo */
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
-	spinlock_t outlock;                                             /* Output fifo spinlock */
 
+	spinlock_t lock;						/* fifo spinlock */
 	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /* Retry timer */
 	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
 	unsigned int retry_delay;                                       /* Delay length in ms */
 	struct work_struct reset_work;                                  /* Task context for resets */
+	struct work_struct restart_work;				/* waking up for output to be done in a task */
 	wait_queue_head_t wait;						/* For sleeping */
+	int ledcount;							/* counting the number of active leds */
 };
 
 #define	hid_to_usb_dev(hid_dev) \
diff --git a/include/linux/hid.h b/include/linux/hid.h
index e5780f8..078dbb9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -411,6 +411,9 @@ struct hid_output_fifo {
 #define HID_CLEAR_HALT		6
 #define HID_DISCONNECTED	7
 #define HID_STARTED		8
+#define HID_REPORTED_IDLE	9
+#define HID_KEYS_PRESSED	10
+#define HID_LED_ON		11
 
 struct hid_input {
 	struct list_head list;
@@ -607,12 +610,17 @@ struct hid_ll_driver {
 	int (*open)(struct hid_device *hdev);
 	void (*close)(struct hid_device *hdev);
 
+	int (*power)(struct hid_device *hdev, int level);
+
 	int (*hidinput_input_event) (struct input_dev *idev, unsigned int type,
 			unsigned int code, int value);
 
 	int (*parse)(struct hid_device *hdev);
 };
 
+#define	PM_HINT_FULLON	1<<5
+#define PM_HINT_NORMAL	1<<1
+
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
 #define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || (a == 0x000d0002))
@@ -645,6 +653,7 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
 void hid_output_report(struct hid_report *report, __u8 *data);
 struct hid_device *hid_allocate_device(void);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
+int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
 
 /**
