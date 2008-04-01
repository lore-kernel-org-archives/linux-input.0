From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: full usbhid autosuspend
Date: Tue, 1 Apr 2008 16:03:05 +0200
Message-ID: <200804011603.05998.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZCk8HI6a61NOQVT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--Boundary-00=_ZCk8HI6a61NOQVT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

this is a full implementation of autosuspend for USB HID devices. Contrary
to the current implementation it tries to safe power even for open devices,
like keyboards and mice. Please test.

It is against 2.6.25-rc7 plus the patch closing the disconnect/open race
which I've attached for your convinience.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

---

--- linux-2.6.25-rc7-vanilla/drivers/hid/hid-core.c	2008-03-31 15:20:58.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/hid-core.c	2008-04-01 11:48:52.000000000 +0200
@@ -1001,6 +1001,24 @@ int hid_input_report(struct hid_device *
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
+#define NBITS(x) ((((x)-1)/BITS_PER_LONG)+1)
+
+int hid_check_keys_pressed(struct hid_device *hid)
+{
+	struct hid_input *hidinput;
+	int i;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		for (i = 0; i < NBITS(KEY_MAX); i++)
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
--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/hid-core.c	2008-04-01 15:52:10.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/hid-core.c	2008-04-01 11:21:07.000000000 +0200
@@ -5,6 +5,7 @@
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
  *  Copyright (c) 2005 Michael Haboustak <mike--vDbLwGUA7lNWk0Htik3J/w@public.gmane.org> for Concept2, Inc
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
 
@@ -70,8 +72,12 @@ MODULE_PARM_DESC(rdesc_quirks, "Add/modi
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
@@ -81,8 +87,9 @@ static int hid_start_in(struct hid_devic
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	spin_lock_irqsave(&usbhid->inlock, flags);
-	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+	if (hid->open > 0 &&
 			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
+			!test_bit(HID_REPORTED_IDLE, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
@@ -186,6 +193,50 @@ done:
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
+			wake_up(&hid->wait);
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
+			wake_up(&hid->wait);
+		}
+	}
+	return kicked;
+}
+
 /*
  * Input interrupt completion handler.
  */
@@ -198,12 +249,19 @@ static void hid_irq_in(struct urb *urb)
 
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
@@ -217,6 +275,7 @@ static void hid_irq_in(struct urb *urb)
 		case -EPROTO:		/* protocol error or unplug */
 		case -ETIME:		/* protocol error or unplug */
 		case -ETIMEDOUT:	/* Should never happen, but... */
+			usbhid_mark_busy(usbhid);
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 			hid_io_error(hid);
 			return;
@@ -242,9 +301,11 @@ static int hid_submit_out(struct hid_dev
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
 
@@ -332,24 +393,20 @@ static void hid_irq_out(struct urb *urb)
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
-			wake_up(&hid->wait);
-		}
-		spin_unlock_irqrestore(&usbhid->outlock, flags);
+	if (usbhid_restart_out_queue(usbhid)) {
+		spin_unlock_irqrestore(&usbhid->outputlock, flags);
 		return;
 	}
 
 	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->outlock, flags);
+	spin_unlock_irqrestore(&usbhid->outputlock, flags);
 	wake_up(&hid->wait);
 }
 
@@ -364,7 +421,7 @@ static void hid_ctrl(struct urb *urb)
 	unsigned long flags;
 	int unplug = 0;
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
+	spin_lock_irqsave(&usbhid->outputlock, flags);
 
 	switch (urb->status) {
 		case 0:			/* success */
@@ -389,73 +446,101 @@ static void hid_ctrl(struct urb *urb)
 	else
 		usbhid->ctrltail = (usbhid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
-	if (usbhid->ctrlhead != usbhid->ctrltail) {
-		if (hid_submit_ctrl(hid)) {
-			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-			wake_up(&hid->wait);
-		}
-		spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+	if (usbhid_restart_ctrl_queue(usbhid)) {
+		spin_unlock_irqrestore(&usbhid->outputlock, flags);
 		return;
 	}
 
 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+	spin_unlock_irqrestore(&usbhid->outputlock, flags);
 	wake_up(&hid->wait);
 }
 
-void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+static void usbhid_queue_report_out(struct hid_device *hid, struct hid_report *report)
 {
+	struct usbhid_device *usbhid = hid->driver_data;
 	int head;
-	unsigned long flags;
+
+	if ((head = (usbhid->outhead + 1) & (HID_OUTPUT_FIFO_SIZE - 1)) == usbhid->outtail) {
+		warn("output queue full");
+		return;
+	}
+
+	usbhid->out[usbhid->outhead] = report;
+	usbhid->outhead = head;
+}
+
+static void usbhid_queue_report_ctrl
+(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
 	struct usbhid_device *usbhid = hid->driver_data;
+	int head;
 
-	if ((hid->quirks & HID_QUIRK_NOGET) && dir == USB_DIR_IN)
+	if ((head = (usbhid->ctrlhead + 1) & (HID_CONTROL_FIFO_SIZE - 1)) == usbhid->ctrltail) {
+		warn("control queue full");
 		return;
+	}
 
-	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT) {
+	usbhid->ctrl[usbhid->ctrlhead].report = report;
+	usbhid->ctrl[usbhid->ctrlhead].dir = dir;
+	usbhid->ctrlhead = head;
+}
 
-		spin_lock_irqsave(&usbhid->outlock, flags);
+static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
 
-		if ((head = (usbhid->outhead + 1) & (HID_OUTPUT_FIFO_SIZE - 1)) == usbhid->outtail) {
-			spin_unlock_irqrestore(&usbhid->outlock, flags);
-			warn("output queue full");
-			return;
-		}
+	if ((hid->quirks & HID_QUIRK_NOGET) && dir == USB_DIR_IN)
+		return;
+
+	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT) {
 
-		usbhid->out[usbhid->outhead] = report;
-		usbhid->outhead = head;
+		usbhid_queue_report_out(hid, report);
 
 		if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl))
 			if (hid_submit_out(hid))
 				clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
 
-		spin_unlock_irqrestore(&usbhid->outlock, flags);
-		return;
-	}
+	} else {
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
+		usbhid_queue_report_ctrl(hid, report, dir);
+
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
 
-	spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+static void usbhid_queue_report
+(struct hid_device *hid, struct hid_report *report, unsigned char dir)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+
+	if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT)
+		usbhid_queue_report_out(hid, report);
+	else
+		usbhid_queue_report_ctrl(hid, report, dir);
 }
 
-static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+static int usb_hidinput_input_event
+(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
+	struct usbhid_device *usbhid = hid->driver_data;
 	struct hid_field *field;
+	unsigned long flags;
 	int offset;
 
 	if (type == EV_FF)
@@ -469,9 +554,27 @@ static int usb_hidinput_input_event(stru
 		return -1;
 	}
 
+	spin_lock_irqsave(&usbhid->outputlock, flags);
+	/* suspension will switch off LEDs, so count them */
+	if (value) {
+		/* increase pm counter */
+	} else {
+		usb_autopm_put_interface(usbhid->intf);
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
 
@@ -517,15 +620,22 @@ int usbhid_open(struct hid_device *hid)
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
 
@@ -533,10 +643,22 @@ void usbhid_close(struct hid_device *hid
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
@@ -546,14 +668,21 @@ void usbhid_close(struct hid_device *hid
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
@@ -663,6 +792,23 @@ static int usbhid_output_raw_report(stru
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
@@ -848,11 +994,11 @@ static struct hid_device *usb_hid_config
 	init_waitqueue_head(&hid->wait);
 
 	INIT_WORK(&usbhid->reset_work, hid_reset);
+	INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
 
 	spin_lock_init(&usbhid->inlock);
-	spin_lock_init(&usbhid->outlock);
-	spin_lock_init(&usbhid->ctrllock);
+	spin_lock_init(&usbhid->outputlock);
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);
 	hid->country = hdesc->bCountryCode;
@@ -940,6 +1086,7 @@ static void hid_disconnect(struct usb_in
 	usb_kill_urb(usbhid->urbctrl);
 
 	del_timer_sync(&usbhid->io_retry);
+	cancel_work_sync(&usbhid->restart_work);
 	cancel_work_sync(&usbhid->reset_work);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
@@ -971,6 +1118,8 @@ static int hid_probe(struct usb_interfac
 	if (!(hid = usb_hid_configure(intf)))
 		return -ENODEV;
 
+	usb_set_intfdata(intf, hid);
+
 	usbhid_init_reports(hid);
 	hid_dump_device(hid);
 	if (hid->quirks & HID_QUIRK_RESET_LEDS)
@@ -983,7 +1132,6 @@ static int hid_probe(struct usb_interfac
 	if (!hidraw_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDRAW;
 
-	usb_set_intfdata(intf, hid);
 
 	if (!hid->claimed) {
 		printk ("HID device claimed by neither input, hiddev nor hidraw\n");
@@ -1031,16 +1179,55 @@ static int hid_probe(struct usb_interfac
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
+	} else {
+		spin_lock_irq(&usbhid->inlock);
+		set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+		spin_unlock_irq(&usbhid->inlock);
+		if (usbhid_wait_io(hid) < 0)
+			return -EIO;
+	}
+
+	hid_cease_io(usbhid);
+	if (udev->auto_pm && test_bit(HID_KEYS_PRESSED, &usbhid->iofl)) {
+		/* lost race against keypresses */
+printk(KERN_ERR"lost race against keypresses.\n");
+		status = hid_start_in(hid);
+		if (status < 0)
+			hid_io_error(hid);
+		usbhid_mark_busy(usbhid);
+		return -EBUSY;
+	}
 	dev_dbg(&intf->dev, "suspend\n");
 	return 0;
 }
@@ -1051,18 +1238,30 @@ static int hid_resume(struct usb_interfa
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
 
@@ -1070,11 +1269,35 @@ static int hid_pre_reset(struct usb_inte
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
@@ -1100,7 +1323,11 @@ static struct usb_driver hid_driver = {
 
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
@@ -1118,6 +1345,8 @@ usb_register_fail:
 hiddev_init_fail:
 	usbhid_quirks_exit();
 usbhid_quirks_init_fail:
+	destroy_workqueue(resumption_waker);
+no_queue:
 	return retval;
 }
 
@@ -1126,6 +1355,7 @@ static void __exit hid_exit(void)
 	usb_deregister(&hid_driver);
 	hiddev_exit();
 	usbhid_quirks_exit();
+	destroy_workqueue(resumption_waker);
 }
 
 module_init(hid_init);
--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/hiddev.c	2008-03-31 15:16:39.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/hiddev.c	2008-04-01 11:09:12.000000000 +0200
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
--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/usbhid.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/usbhid.h	2008-04-01 13:51:04.000000000 +0200
@@ -36,7 +36,10 @@ int usbhid_wait_io(struct hid_device* hi
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
@@ -70,14 +73,14 @@ struct usbhid_device {
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
-	spinlock_t outlock;                                             /* Output fifo spinlock */
+	spinlock_t outputlock;						/* Output fifo spinlock */
 
 	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /* Retry timer */
 	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
 	unsigned int retry_delay;                                       /* Delay length in ms */
 	struct work_struct reset_work;                                  /* Task context for resets */
-
+	struct work_struct restart_work;				/* waking up for output to be done in a task */
 };
 
 #define	hid_to_usb_dev(hid_dev) \
--- linux-2.6.25-rc7-vanilla/include/linux/hid.h	2008-04-01 15:52:10.000000000 +0200
+++ linux-2.6.25-rc7-work/include/linux/hid.h	2008-04-01 11:24:43.000000000 +0200
@@ -422,6 +422,8 @@ struct hid_control_fifo {
 #define HID_SUSPENDED		5
 #define HID_CLEAR_HALT		6
 #define HID_DISCONNECTED	7
+#define HID_REPORTED_IDLE	8
+#define HID_KEYS_PRESSED	9
 
 struct hid_input {
 	struct list_head list;
@@ -535,6 +537,7 @@ void hid_input_field(struct hid_device *
 void hid_output_report(struct hid_report *report, __u8 *data);
 void hid_free_device(struct hid_device *device);
 struct hid_device *hid_parse_report(__u8 *start, unsigned size);
+int hid_check_keys_pressed(struct hid_device *hid);
 
 /* HID quirks API */
 u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);

--Boundary-00=_ZCk8HI6a61NOQVT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="usbhid20080331_2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbhid20080331_2.diff"

--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/hid-core.c	2008-03-31 15:20:58.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/hid-core.c	2008-03-31 16:02:49.000000000 +0200
@@ -82,6 +82,7 @@
 
 	spin_lock_irqsave(&usbhid->inlock, flags);
 	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
@@ -155,7 +156,7 @@
 	spin_lock_irqsave(&usbhid->inlock, flags);
 
 	/* Stop when disconnected */
-	if (usb_get_intfdata(usbhid->intf) == NULL)
+	if (test_bit(HID_DISCONNECTED, &usbhid->iofl))
 		goto done;
 
 	/* If it has been a while since the last error, we'll assume
@@ -932,6 +933,7 @@
 
 	spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
 	usb_set_intfdata(intf, NULL);
+	set_bit(HID_DISCONNECTED, &usbhid->iofl);
 	spin_unlock_irq(&usbhid->inlock);
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbout);
--- linux-2.6.25-rc7-vanilla/include/linux/hid.h	2008-03-31 15:21:24.000000000 +0200
+++ linux-2.6.25-rc7-work/include/linux/hid.h	2008-03-31 15:58:43.000000000 +0200
@@ -421,6 +421,7 @@
 #define HID_RESET_PENDING	4
 #define HID_SUSPENDED		5
 #define HID_CLEAR_HALT		6
+#define HID_DISCONNECTED	7
 
 struct hid_input {
 	struct list_head list;

--Boundary-00=_ZCk8HI6a61NOQVT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
