From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]full runtime power management for usbhid
Date: Tue, 26 Aug 2008 11:39:13 +0200
Message-ID: <200808261139.14410.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:40597 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729AbYHZJiE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2008 05:38:04 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org

Hi,

this patch enables full runtime power management for usbhid.
Currently usbhid supports autosuspend only upon open and close. Thus
it is useless for devices which are always opened, such as keyboards
and mice. This patch enables the use of remote wakeup for devices that
support it.

It suspends idle usb hid devices after a timeout if possible unless

- hiddev has opened the device
- error handling is under way
- a key is being held down
(keyboards don't signal remote wakeup upon release of a key)
- an led is active on the device
(leds use too much power for a suspend device to keep lit -
this can be overridden with a module parameter)

Furthermore a device is resumed if this is necessary for output (to leds).
If output is requested while a device is suspended, the output is queued
and the device woken from within a work queue.

In detail the patch

- reduces granularity of locking in usbhid to avoid deadlocks
- introduces locking between open/close and suspend/resume
- adds detection for the conditions under which a device is not autosuspended
- adds queuing logic for output (bulk of the patch)
- adds coordination of reset and power management
- marks the device busy at appropriate places

It works for my keyboard and mice. I am looking forward to comments
and reports.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

--- a/drivers/hid/hid-core.c	2008-05-06 13:49:51.000000000 +0200
+++ b/drivers/hid/hid-core.c	2008-05-06 14:54:38.000000000 +0200
@@ -1006,6 +1006,22 @@ int hid_input_report(struct hid_device *
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
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
 	return hidraw_init();
--- a/drivers/hid/usbhid/hiddev.c	2008-05-06 13:49:51.000000000 +0200
+++ b/drivers/hid/usbhid/hiddev.c	2008-05-06 13:53:54.000000000 +0200
@@ -249,10 +249,12 @@ static int hiddev_release(struct inode *
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
@@ -267,6 +269,7 @@ static int hiddev_open(struct inode *ino
 {
 	struct hiddev_list *list;
 	unsigned long flags;
+	int res;
 
 	int i = iminor(inode) - HIDDEV_MINOR_BASE;
 
@@ -285,8 +288,13 @@ static int hiddev_open(struct inode *ino
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
--- a/drivers/hid/usbhid/usbhid.h	2008-05-06 13:49:51.000000000 +0200
+++ b/drivers/hid/usbhid/usbhid.h	2008-05-06 14:58:49.000000000 +0200
@@ -37,7 +37,10 @@ int usbhid_wait_io(struct hid_device* hi
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
@@ -64,20 +67,20 @@ struct usbhid_device {
 	unsigned char ctrlhead, ctrltail;                               /* Control fifo head & tail */
 	char *ctrlbuf;                                                  /* Control buffer */
 	dma_addr_t ctrlbuf_dma;                                         /* Control buffer dma */
-	spinlock_t ctrllock;                                            /* Control fifo spinlock */
 
 	struct urb *urbout;                                             /* Output URB */
 	struct hid_report *out[HID_CONTROL_FIFO_SIZE];                  /* Output pipe fifo */
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
-	spinlock_t outlock;                                             /* Output fifo spinlock */
+	spinlock_t outputlock;                                             /* Output fifo spinlock */
 
 	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /* Retry timer */
 	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
 	unsigned int retry_delay;                                       /* Delay length in ms */
 	struct work_struct reset_work;                                  /* Task context for resets */
+	struct work_struct restart_work;				/* waking up for output to be done in a task */
 	wait_queue_head_t wait;						/* For sleeping */
 };
 
--- a/include/linux/hid.h	2008-05-06 13:50:05.000000000 +0200
+++ b/include/linux/hid.h	2008-05-06 22:02:57.000000000 +0200
@@ -425,6 +425,9 @@ struct hid_control_fifo {
 #define HID_SUSPENDED		5
 #define HID_CLEAR_HALT		6
 #define HID_DISCONNECTED	7
+#define HID_REPORTED_IDLE	8
+#define HID_KEYS_PRESSED	9
+#define HID_LED_ON		10
 
 struct hid_input {
 	struct list_head list;
@@ -535,6 +538,7 @@ int hidinput_apple_event(struct hid_devi
 void hid_output_report(struct hid_report *report, __u8 *data);
 void hid_free_device(struct hid_device *device);
 struct hid_device *hid_parse_report(__u8 *start, unsigned size);
+int hid_check_keys_pressed(struct hid_device *hid);
 
 /* HID quirks API */
 u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);
--- a/drivers/hid/usbhid/hid-core.c	2008-05-06 13:49:51.000000000 +0200
+++ b/drivers/hid/usbhid/hid-core.c	2008-05-06 22:03:18.000000000 +0200
@@ -5,6 +5,7 @@
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
  *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007 Oliver Neukum
  */
 
 /*
@@ -26,6 +27,7 @@
 #include <asm/byteorder.h>
 #include <linux/input.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <linux/usb.h>
 
@@ -54,6 +56,10 @@ static unsigned int hid_mousepoll_interv
 module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
 MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
 
+static unsigned int ignoreled;
+module_param_named(ignoreled, ignoreled, uint, 0644);
+MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
+
 /* Quirks specified at module load time */
 static char *quirks_param[MAX_USBHID_BOOT_QUIRKS] = { [ 0 ... (MAX_USBHID_BOOT_QUIRKS - 1) ] = NULL };
 module_param_array_named(quirks, quirks_param, charp, NULL, 0444);
@@ -70,8 +76,12 @@ MODULE_PARM_DESC(rdesc_quirks, "Add/modi
 /*
  * Input submission and I/O error handler.
  */
+static DEFINE_MUTEX(hid_open_mut);
+static struct workqueue_struct *resumption_waker;
 
 static void hid_io_error(struct hid_device *hid);
+static int hid_submit_out(struct hid_device *hid);
+static int hid_submit_ctrl(struct hid_device *hid);
 
 /* Start up the input URB */
 static int hid_start_in(struct hid_device *hid)
@@ -81,8 +91,9 @@ static int hid_start_in(struct hid_devic
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	spin_lock_irqsave(&usbhid->inlock, flags);
-	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+	if (hid->open > 0 &&
 			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
+			!test_bit(HID_REPORTED_IDLE, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
@@ -186,6 +197,50 @@ done:
 	spin_unlock_irqrestore(&usbhid->inlock, flags);
 }
 
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
+}
+
 /*
  * Input interrupt completion handler.
  */
@@ -198,12 +253,19 @@ static void hid_irq_in(struct urb *urb)
 
 	switch (urb->status) {
 		case 0:			/* success */
+			usbhid_mark_busy(usbhid);	
 			usbhid->retry_delay = 0;
 			hid_input_report(urb->context, HID_INPUT_REPORT,
 					 urb->transfer_buffer,
 					 urb->actual_length, 1);
+			/* autosuspend refused while keys are pressed*/
+			if (hid_check_keys_pressed(hid))
+				set_bit(HID_KEYS_PRESSED, &usbhid->iofl);
+			else
+				clear_bit(HID_KEYS_PRESSED, &usbhid->iofl);
 			break;
 		case -EPIPE:		/* stall */
+			usbhid_mark_busy(usbhid);
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 			set_bit(HID_CLEAR_HALT, &usbhid->iofl);
 			schedule_work(&usbhid->reset_work);
@@ -217,6 +279,7 @@ static void hid_irq_in(struct urb *urb)
 		case -EPROTO:		/* protocol error or unplug */
 		case -ETIME:		/* protocol error or unplug */
 		case -ETIMEDOUT:	/* Should never happen, but... */
+			usbhid_mark_busy(usbhid);
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 			hid_io_error(hid);
 			return;
@@ -242,9 +305,11 @@ static int hid_submit_out(struct hid_dev
 	struct hid_report *report;
 	struct usbhid_device *usbhid = hid->driver_data;
 
+	WARN_ON(usbhid == NULL);
 	report = usbhid->out[usbhid->outtail];
-
+	WARN_ON(report == NULL);
 	hid_output_report(report, usbhid->outbuf);
+	BUG_ON(usbhid->urbout == NULL);
 	usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 	usbhid->urbout->dev = hid_to_usb_dev(hid);
 
@@ -332,24 +397,20 @@ static void hid_irq_out(struct urb *urb)
 			warn("output irq status %d received", urb->status);
 	}
 
-	spin_lock_irqsave(&usbhid->outlock, flags);
+	spin_lock_irqsave(&usbhid->outputlock, flags);
 
 	if (unplug)
 		usbhid->outtail = usbhid->outhead;
 	else
 		usbhid->outtail = (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
-	if (usbhid->outhead != usbhid->outtail) {
-		if (hid_submit_out(hid)) {
-			clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-			wake_up(&usbhid->wait);
-		}
-		spin_unlock_irqrestore(&usbhid->outlock, flags);
+	if (usbhid_restart_out_queue(usbhid)) {
+		spin_unlock_irqrestore(&usbhid->outputlock, flags);
 		return;
 	}
 
 	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->outlock, flags);
+	spin_unlock_irqrestore(&usbhid->outputlock, flags);
 	wake_up(&usbhid->wait);
 }
 
@@ -364,7 +425,7 @@ static void hid_ctrl(struct urb *urb)
 	unsigned long flags;
 	int unplug = 0;
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
+	spin_lock_irqsave(&usbhid->outputlock, flags);
 
 	switch (urb->status) {
 		case 0:			/* success */
@@ -389,73 +450,98 @@ static void hid_ctrl(struct urb *urb)
 	else
 		usbhid->ctrltail = (usbhid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
-	if (usbhid->ctrlhead != usbhid->ctrltail) {
-		if (hid_submit_ctrl(hid)) {
-			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-			wake_up(&usbhid->wait);
-		}
-		spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+	if (usbhid_restart_ctrl_queue(usbhid)) {
+		spin_unlock_irqrestore(&usbhid->outputlock, flags);
 		return;
 	}
 
 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+	spin_unlock_irqrestore(&usbhid->outputlock, flags);
 	wake_up(&usbhid->wait);
 }
 
-void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+static void usbhid_queue_report_out(struct hid_device *hid, struct hid_report *report)
 {
-	int head;
-	unsigned long flags;
 	struct usbhid_device *usbhid = hid->driver_data;
+	int head;
 
-	if ((hid->quirks & HID_QUIRK_NOGET) && dir == USB_DIR_IN)
+	if ((head = (usbhid->outhead + 1) & (HID_OUTPUT_FIFO_SIZE - 1)) == usbhid->outtail) {
+		warn("output queue full");
 		return;
+	}
 
-	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT) {
+	usbhid->out[usbhid->outhead] = report;
+	usbhid->outhead = head;
+}
 
-		spin_lock_irqsave(&usbhid->outlock, flags);
+static void usbhid_queue_report_ctrl
+(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+	int head;
 
-		if ((head = (usbhid->outhead + 1) & (HID_OUTPUT_FIFO_SIZE - 1)) == usbhid->outtail) {
-			spin_unlock_irqrestore(&usbhid->outlock, flags);
-			warn("output queue full");
-			return;
-		}
+	if ((head = (usbhid->ctrlhead + 1) & (HID_CONTROL_FIFO_SIZE - 1)) == usbhid->ctrltail) {
+		warn("control queue full");
+		return;
+	}
+ 
+	usbhid->ctrl[usbhid->ctrlhead].report = report;
+	usbhid->ctrl[usbhid->ctrlhead].dir = dir;
+	usbhid->ctrlhead = head;
+}
+
+static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
 
-		usbhid->out[usbhid->outhead] = report;
-		usbhid->outhead = head;
+	if ((hid->quirks & HID_QUIRK_NOGET) && dir == USB_DIR_IN)
+		return;
+
+	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT) {
+		usbhid_queue_report_out(hid, report);
 
 		if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl))
 			if (hid_submit_out(hid))
 				clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
+	} else {
 
-		spin_unlock_irqrestore(&usbhid->outlock, flags);
-		return;
-	}
+		usbhid_queue_report_ctrl(hid, report, dir);
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
+		if (!test_and_set_bit(HID_CTRL_RUNNING, &usbhid->iofl))
+			if (hid_submit_ctrl(hid))
+				clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
 
-	if ((head = (usbhid->ctrlhead + 1) & (HID_CONTROL_FIFO_SIZE - 1)) == usbhid->ctrltail) {
-		spin_unlock_irqrestore(&usbhid->ctrllock, flags);
-		warn("control queue full");
-		return;
 	}
+}
 
-	usbhid->ctrl[usbhid->ctrlhead].report = report;
-	usbhid->ctrl[usbhid->ctrlhead].dir = dir;
-	usbhid->ctrlhead = head;
+void usbhid_submit_report
+(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+	unsigned long flags;
 
-	if (!test_and_set_bit(HID_CTRL_RUNNING, &usbhid->iofl))
-		if (hid_submit_ctrl(hid))
-			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
+	spin_lock_irqsave(&usbhid->outputlock, flags);
+	__usbhid_submit_report(hid, report, dir);
+	spin_unlock_irqrestore(&usbhid->outputlock, flags);
+}
+
+static void usbhid_queue_report
+(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
 
-	spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT)
+		usbhid_queue_report_out(hid, report);
+	else
+		usbhid_queue_report_ctrl(hid, report, dir);
 }
 
 static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
+	struct usbhid_device *usbhid = hid->driver_data;
 	struct hid_field *field;
+	unsigned long flags;
 	int offset;
 
 	if (type == EV_FF)
@@ -469,9 +555,27 @@ static int usb_hidinput_input_event(stru
 		return -1;
 	}
 
+	spin_lock_irqsave(&usbhid->outputlock, flags);
+	/* suspension will switch off LEDs, so count them */
+	if (value) {
+		set_bit(HID_LED_ON, &usbhid->iofl);
+	} else {
+		clear_bit(HID_LED_ON, &usbhid->iofl);
+	}
 	hid_set_field(field, offset, value);
-	usbhid_submit_report(hid, field->report, USB_DIR_OUT);
+	if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
+		/* the device isn't idle, we do the output now*/
+		__usbhid_submit_report(hid, field->report, USB_DIR_OUT);
+	} else {
+		/* the device is idle, queue the request */
+		usbhid_queue_report(hid, field->report, USB_DIR_OUT);
+		/* queue work to wake up the device.
+		 * as the work queue is freezeable, this is safe
+		 * with respect to hibernation and system suspend */
+		queue_work(resumption_waker, &usbhid->restart_work);
 
+	}
+	spin_unlock_irqrestore(&usbhid->outputlock, flags);
 	return 0;
 }
 
@@ -518,15 +622,22 @@ int usbhid_open(struct hid_device *hid)
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
 
@@ -534,10 +645,22 @@ void usbhid_close(struct hid_device *hid
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
+	mutex_lock(&hid_open_mut);
+
+	/* protecting hid->open to make sure we don't restart
+	 * data acquistion due to a resumption we no longer
+	 * care about
+	 */
+	spin_lock_irq(&usbhid->inlock);
 	if (!--hid->open) {
+		spin_unlock_irq(&usbhid->inlock);
 		usb_kill_urb(usbhid->urbin);
-		usb_autopm_put_interface(usbhid->intf);
+		flush_scheduled_work();
+		usbhid->intf->needs_remote_wakeup = 0;
+	} else {
+		spin_unlock_irq(&usbhid->inlock);
 	}
+	mutex_unlock(&hid_open_mut);
 }
 
 /*
@@ -547,14 +670,21 @@ void usbhid_close(struct hid_device *hid
 void usbhid_init_reports(struct hid_device *hid)
 {
 	struct hid_report *report;
-	struct usbhid_device *usbhid = hid->driver_data;
+	unsigned long flags;
 	int err, ret;
+	struct usbhid_device *usbhid = hid->driver_data;
 
-	list_for_each_entry(report, &hid->report_enum[HID_INPUT_REPORT].report_list, list)
-		usbhid_submit_report(hid, report, USB_DIR_IN);
+	list_for_each_entry(report, &hid->report_enum[HID_INPUT_REPORT].report_list, list) {
+		spin_lock_irqsave(&usbhid->outputlock, flags);
+		__usbhid_submit_report(hid, report, USB_DIR_IN);
+		spin_unlock_irqrestore(&usbhid->outputlock, flags);
+	}
 
-	list_for_each_entry(report, &hid->report_enum[HID_FEATURE_REPORT].report_list, list)
-		usbhid_submit_report(hid, report, USB_DIR_IN);
+	list_for_each_entry(report, &hid->report_enum[HID_FEATURE_REPORT].report_list, list) {
+		spin_lock_irqsave(&usbhid->outputlock, flags);
+		__usbhid_submit_report(hid, report, USB_DIR_IN);
+		spin_unlock_irqrestore(&usbhid->outputlock, flags);
+	}
 
 	err = 0;
 	ret = usbhid_wait_io(hid);
@@ -665,6 +795,23 @@ static int usbhid_output_raw_report(stru
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
+
+	usb_autopm_get_interface(usbhid->intf);
+	usbhid_restart_queues(usbhid);
+	usb_autopm_put_interface(usbhid->intf);
+}
+
 static void hid_free_buffers(struct usb_device *dev, struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
@@ -873,11 +1020,11 @@ static struct hid_device *usb_hid_config
 
 	init_waitqueue_head(&usbhid->wait);
 	INIT_WORK(&usbhid->reset_work, hid_reset);
+	INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
 
 	spin_lock_init(&usbhid->inlock);
-	spin_lock_init(&usbhid->outlock);
-	spin_lock_init(&usbhid->ctrllock);
+	spin_lock_init(&usbhid->outputlock);
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);
 	hid->country = hdesc->bCountryCode;
@@ -949,6 +1096,7 @@ static void hid_disconnect(struct usb_in
 	usb_kill_urb(usbhid->urbctrl);
 
 	del_timer_sync(&usbhid->io_retry);
+	cancel_work_sync(&usbhid->restart_work);
 	cancel_work_sync(&usbhid->reset_work);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
@@ -980,6 +1128,8 @@ static int hid_probe(struct usb_interfac
 	if (!(hid = usb_hid_configure(intf)))
 		return -ENODEV;
 
+	usb_set_intfdata(intf, hid);
+
 	usbhid_init_reports(hid);
 	hid_dump_device(hid);
 	if (hid->quirks & HID_QUIRK_RESET_LEDS)
@@ -992,7 +1142,6 @@ static int hid_probe(struct usb_interfac
 	if (!hidraw_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDRAW;
 
-	usb_set_intfdata(intf, hid);
 
 	if (!hid->claimed) {
 		printk ("HID device claimed by neither input, hiddev nor hidraw\n");
@@ -1040,16 +1189,66 @@ static int hid_probe(struct usb_interfac
 	return 0;
 }
 
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
 
-	spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
-	set_bit(HID_SUSPENDED, &usbhid->iofl);
-	spin_unlock_irq(&usbhid->inlock);
-	del_timer(&usbhid->io_retry);
-	usb_kill_urb(usbhid->urbin);
+	if (udev->auto_pm) {
+		spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
+		if (!test_bit(HID_RESET_PENDING, &usbhid->iofl)
+		    && !test_bit(HID_CLEAR_HALT, &usbhid->iofl)
+		    && !test_bit(HID_OUT_RUNNING, &usbhid->iofl)
+		    && !test_bit(HID_CTRL_RUNNING, &usbhid->iofl)
+		    && !test_bit(HID_KEYS_PRESSED, &usbhid->iofl))
+		{
+			set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+			spin_unlock_irq(&usbhid->inlock);
+		} else {
+			usbhid_mark_busy(usbhid);
+			spin_unlock_irq(&usbhid->inlock);
+			return -EBUSY;
+		}
+		
+	} else {
+		spin_lock_irq(&usbhid->inlock);
+		set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+		spin_unlock_irq(&usbhid->inlock);
+		if (usbhid_wait_io(hid) < 0)
+			return -EIO;
+	}
+
+	if (!ignoreled && udev->auto_pm) {
+		spin_lock_irq(&usbhid->outputlock);
+		if (test_bit(HID_LED_ON, &usbhid->iofl)) {
+			spin_unlock_irq(&usbhid->outputlock);
+			usbhid_mark_busy(usbhid);
+			return -EBUSY;
+		}
+		spin_unlock_irq(&usbhid->outputlock);
+	}
+
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
@@ -1060,18 +1259,30 @@ static int hid_resume(struct usb_interfa
 	struct usbhid_device *usbhid = hid->driver_data;
 	int status;
 
-	clear_bit(HID_SUSPENDED, &usbhid->iofl);
+	clear_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+	usbhid_mark_busy(usbhid);
+	
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
+	spin_lock_irq(&usbhid->inlock);
+	set_bit(HID_RESET_PENDING, &usbhid->iofl);
+	spin_unlock_irq(&usbhid->inlock);
+	hid_cease_io(usbhid);
+
 	return 0;
 }
 
@@ -1079,11 +1290,35 @@ static int hid_pre_reset(struct usb_inte
 static int hid_post_reset(struct usb_interface *intf)
 {
 	struct usb_device *dev = interface_to_usbdev (intf);
-
+	struct hid_device *hid = usb_get_intfdata(intf);
+	struct usbhid_device *usbhid = hid->driver_data;
+	int status;
+ 
+	spin_lock_irq(&usbhid->inlock);
+	clear_bit(HID_RESET_PENDING, &usbhid->iofl);
+	spin_unlock_irq(&usbhid->inlock);
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
@@ -1109,7 +1344,11 @@ static struct usb_driver hid_driver = {
 
 static int __init hid_init(void)
 {
-	int retval;
+	int retval = -ENOMEM;
+
+	resumption_waker = create_freezeable_workqueue("usbhid_resumer");
+	if (!resumption_waker)
+		goto no_queue;
 	retval = usbhid_quirks_init(quirks_param);
 	if (retval)
 		goto usbhid_quirks_init_fail;
@@ -1127,6 +1366,8 @@ usb_register_fail:
 hiddev_init_fail:
 	usbhid_quirks_exit();
 usbhid_quirks_init_fail:
+	destroy_workqueue(resumption_waker);
+no_queue:
 	return retval;
 }
 
@@ -1135,6 +1376,7 @@ static void __exit hid_exit(void)
 	usb_deregister(&hid_driver);
 	hiddev_exit();
 	usbhid_quirks_exit();
+	destroy_workqueue(resumption_waker);
 }
 
 module_init(hid_init);
