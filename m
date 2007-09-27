From: Oliver Neukum <oliver@neukum.org>
Subject: new version of usbhid autosuspend patch
Date: Thu, 27 Sep 2007 16:33:34 +0200
Message-ID: <200709271633.35098.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>
List-Id: linux-input@vger.kernel.org

Hi,

this version solves the "keyboard goes to sleep while keys are pressed"
problem. Any testers? Comments?

	Regards
		Oliver
----

diff -urp linux-2.6.23-rc6/drivers/hid/hid-core.c hid/drivers/hid/hid-core.c
--- linux-2.6.23-rc6/drivers/hid/hid-core.c	2007-09-25 08:46:15.000000000 +0200
+++ hid/drivers/hid/hid-core.c	2007-09-27 15:04:58.000000000 +0200
@@ -990,5 +990,21 @@ int hid_input_report(struct hid_device *
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
+int hid_check_keys_pressed(struct hid_device *hid)
+{
+	struct hid_input *hidinput, *next;
+	int i;
+
+	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
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
 MODULE_LICENSE(DRIVER_LICENSE);
 
diff -urp linux-2.6.23-rc6/drivers/hid/usbhid/hid-core.c hid/drivers/hid/usbhid/hid-core.c
--- linux-2.6.23-rc6/drivers/hid/usbhid/hid-core.c	2007-09-19 16:58:37.000000000 +0200
+++ hid/drivers/hid/usbhid/hid-core.c	2007-09-24 16:37:26.000000000 +0200
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
 
@@ -69,8 +71,14 @@ MODULE_PARM_DESC(rdesc_quirks, "Add/modi
 /*
  * Input submission and I/O error handler.
  */
+static DEFINE_MUTEX(hid_open_mut);
+static struct workqueue_struct *resumption_waker;
 
 static void hid_io_error(struct hid_device *hid);
+static int hid_submit_out(struct hid_device *hid);
+static int hid_submit_ctrl(struct hid_device *hid);
+
+extern int hid_check_keys_pressed(struct hid_device *hid);
 
 /* Start up the input URB */
 static int hid_start_in(struct hid_device *hid)
@@ -80,7 +88,7 @@ static int hid_start_in(struct hid_devic
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	spin_lock_irqsave(&usbhid->inlock, flags);
-	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+	if (hid->open > 0 && !test_bit(HID_REPORTED_IDLE, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
@@ -184,6 +192,50 @@ done:
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
@@ -196,12 +248,19 @@ static void hid_irq_in(struct urb *urb)
 
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
@@ -215,6 +274,7 @@ static void hid_irq_in(struct urb *urb)
 		case -EPROTO:		/* protocol error or unplug */
 		case -ETIME:		/* protocol error or unplug */
 		case -ETIMEDOUT:	/* Should never happen, but... */
+			usbhid_mark_busy(usbhid);
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 			hid_io_error(hid);
 			return;
@@ -240,9 +300,11 @@ static int hid_submit_out(struct hid_dev
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
 
@@ -330,24 +392,20 @@ static void hid_irq_out(struct urb *urb)
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
 
@@ -362,7 +420,7 @@ static void hid_ctrl(struct urb *urb)
 	unsigned long flags;
 	int unplug = 0;
 
-	spin_lock_irqsave(&usbhid->ctrllock, flags);
+	spin_lock_irqsave(&usbhid->outputlock, flags);
 
 	switch (urb->status) {
 		case 0:			/* success */
@@ -387,73 +445,101 @@ static void hid_ctrl(struct urb *urb)
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
@@ -467,9 +553,22 @@ static int usb_hidinput_input_event(stru
 		return -1;
 	}
 
+	spin_lock_irqsave(&usbhid->outputlock, flags);
+
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
 
@@ -512,9 +611,26 @@ static int hid_get_class_descriptor(stru
 
 int usbhid_open(struct hid_device *hid)
 {
-	++hid->open;
-	if (hid_start_in(hid))
-		hid_io_error(hid);
+	struct usbhid_device *usbhid = hid->driver_data;
+	int res;
+
+	mutex_lock(&hid_open_mut);
+	if (!hid->open++) {
+		res = usb_autopm_get_interface(usbhid->intf);
+		/* the device must be awake to reliable request remote wakeup */
+		if (res < 0) {
+			hid->open--;
+			mutex_unlock(&hid_open_mut);
+			return -EIO;
+		}
+		usbhid->intf->needs_remote_wakeup = 1;
+		if (hid_start_in(hid))
+			hid_io_error(hid);
+
+		usb_autopm_put_interface(usbhid->intf);
+	}
+	mutex_unlock(&hid_open_mut);
+
 	return 0;
 }
 
@@ -522,8 +638,22 @@ void usbhid_close(struct hid_device *hid
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	if (!--hid->open)
+	mutex_lock(&hid_open_mut);
+
+	/* protecting hid->open to make sure we don't restart
+	 * data acquistion due to a resumption we no longer
+	 * care about
+	 */
+	spin_lock_irq(&usbhid->inlock);
+	if (!--hid->open) {
+		spin_unlock_irq(&usbhid->inlock);
 		usb_kill_urb(usbhid->urbin);
+		flush_scheduled_work();
+		usbhid->intf->needs_remote_wakeup = 0;
+	} else {
+		spin_unlock_irq(&usbhid->inlock);
+	}
+	mutex_unlock(&hid_open_mut);
 }
 
 /*
@@ -533,14 +663,21 @@ void usbhid_close(struct hid_device *hid
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
@@ -628,6 +765,23 @@ static int hid_alloc_buffers(struct usb_
 	return 0;
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
@@ -813,11 +967,11 @@ static struct hid_device *usb_hid_config
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
@@ -903,6 +1057,7 @@ static void hid_disconnect(struct usb_in
 	usb_kill_urb(usbhid->urbctrl);
 
 	del_timer_sync(&usbhid->io_retry);
+	cancel_work_sync(&usbhid->restart_work);
 	cancel_work_sync(&usbhid->reset_work);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
@@ -932,6 +1087,8 @@ static int hid_probe(struct usb_interfac
 	if (!(hid = usb_hid_configure(intf)))
 		return -ENODEV;
 
+	usb_set_intfdata(intf, hid);
+
 	usbhid_init_reports(hid);
 	hid_dump_device(hid);
 	if (hid->quirks & HID_QUIRK_RESET_LEDS)
@@ -942,7 +1099,6 @@ static int hid_probe(struct usb_interfac
 	if (!hiddev_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDDEV;
 
-	usb_set_intfdata(intf, hid);
 
 	if (!hid->claimed) {
 		printk ("HID device not claimed by input or hiddev\n");
@@ -984,16 +1140,53 @@ static int hid_probe(struct usb_interfac
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
+		status = hid_start_in(hid);
+		if (status < 0)
+			hid_io_error(hid);
+		usbhid_mark_busy(usbhid);
+		return -EBUSY;
+	}
 	dev_dbg(&intf->dev, "suspend\n");
 	return 0;
 }
@@ -1004,18 +1197,30 @@ static int hid_resume(struct usb_interfa
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
 
@@ -1023,11 +1228,35 @@ static int hid_pre_reset(struct usb_inte
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
@@ -1048,11 +1277,16 @@ static struct usb_driver hid_driver = {
 	.pre_reset =	hid_pre_reset,
 	.post_reset =	hid_post_reset,
 	.id_table =	hid_usb_ids,
+	.supports_autosuspend = 1,
 };
 
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
@@ -1070,6 +1304,8 @@ usb_register_fail:
 hiddev_init_fail:
 	usbhid_quirks_exit();
 usbhid_quirks_init_fail:
+	destroy_workqueue(resumption_waker);
+no_queue:
 	return retval;
 }
 
@@ -1078,6 +1314,7 @@ static void __exit hid_exit(void)
 	usb_deregister(&hid_driver);
 	hiddev_exit();
 	usbhid_quirks_exit();
+	destroy_workqueue(resumption_waker);
 }
 
 module_init(hid_init);
diff -urp linux-2.6.23-rc6/drivers/hid/usbhid/hiddev.c hid/drivers/hid/usbhid/hiddev.c
--- linux-2.6.23-rc6/drivers/hid/usbhid/hiddev.c	2007-09-19 16:58:37.000000000 +0200
+++ hid/drivers/hid/usbhid/hiddev.c	2007-09-19 14:32:11.000000000 +0200
@@ -248,10 +248,12 @@ static int hiddev_release(struct inode *
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
@@ -266,6 +268,7 @@ static int hiddev_open(struct inode *ino
 {
 	struct hiddev_list *list;
 	unsigned long flags;
+	int res;
 
 	int i = iminor(inode) - HIDDEV_MINOR_BASE;
 
@@ -284,8 +287,13 @@ static int hiddev_open(struct inode *ino
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
 
diff -urp linux-2.6.23-rc6/drivers/hid/usbhid/usbhid.h hid/drivers/hid/usbhid/usbhid.h
--- linux-2.6.23-rc6/drivers/hid/usbhid/usbhid.h	2007-07-09 01:32:17.000000000 +0200
+++ hid/drivers/hid/usbhid/usbhid.h	2007-09-19 14:32:11.000000000 +0200
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
@@ -44,40 +47,69 @@ void usbhid_submit_report(struct hid_dev
  */
 
 struct usbhid_device {
-	struct hid_device *hid;						/* pointer to corresponding HID dev */
-
-	struct usb_interface *intf;                                     /* USB interface */
-	int ifnum;                                                      /* USB interface number */
-
-	unsigned int bufsize;                                           /* URB buffer size */
-
-	struct urb *urbin;                                              /* Input URB */
-	char *inbuf;                                                    /* Input buffer */
-	dma_addr_t inbuf_dma;                                           /* Input buffer dma */
-	spinlock_t inlock;                                              /* Input fifo spinlock */
-
-	struct urb *urbctrl;                                            /* Control URB */
-	struct usb_ctrlrequest *cr;                                     /* Control request struct */
-	dma_addr_t cr_dma;                                              /* Control request struct dma */
-	struct hid_control_fifo ctrl[HID_CONTROL_FIFO_SIZE];  		/* Control fifo */
-	unsigned char ctrlhead, ctrltail;                               /* Control fifo head & tail */
-	char *ctrlbuf;                                                  /* Control buffer */
-	dma_addr_t ctrlbuf_dma;                                         /* Control buffer dma */
-	spinlock_t ctrllock;                                            /* Control fifo spinlock */
-
-	struct urb *urbout;                                             /* Output URB */
-	struct hid_report *out[HID_CONTROL_FIFO_SIZE];                  /* Output pipe fifo */
-	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
-	char *outbuf;                                                   /* Output buffer */
-	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
-	spinlock_t outlock;                                             /* Output fifo spinlock */
-
-	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
-	struct timer_list io_retry;                                     /* Retry timer */
-	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
-	unsigned int retry_delay;                                       /* Delay length in ms */
-	struct work_struct reset_work;                                  /* Task context for resets */
+	/* pointer to corresponding HID dev */
+	struct hid_device *hid;
 
+	/* USB interface */
+	struct usb_interface *intf;
+	/* USB interface number */
+	int ifnum;
+
+	/* URB buffer size */
+	unsigned int bufsize;
+
+	/* Input URB */
+	struct urb *urbin;
+	/* Input buffer */
+	char *inbuf;
+	/* Input buffer dma */
+	dma_addr_t inbuf_dma;
+	/* Input fifo spinlock */
+	spinlock_t inlock;
+
+	/* Control URB */
+	struct urb *urbctrl;
+	/* Control request struct */
+	struct usb_ctrlrequest *cr;
+	/* Control request struct dma */
+	dma_addr_t cr_dma;
+	/* Control fifo */
+	struct hid_control_fifo ctrl[HID_CONTROL_FIFO_SIZE];
+	/* Control fifo head & tail */	
+	unsigned char ctrlhead, ctrltail;
+	/* Control buffer */
+	char *ctrlbuf;
+	/* Control buffer dma */
+	dma_addr_t ctrlbuf_dma;
+
+	/* Output URB */
+	struct urb *urbout;
+	/* Output pipe fifo */
+	struct hid_report *out[HID_CONTROL_FIFO_SIZE];
+	/* Output pipe fifo head & tail */
+	unsigned char outhead, outtail;
+	/* Output buffer */
+	char *outbuf;
+	/* Output buffer dma */
+	dma_addr_t outbuf_dma;
+
+	/* Output fifo spinlock */
+	spinlock_t outputlock;
+
+	/* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
+	unsigned long iofl;
+	/* Retry timer */
+	struct timer_list io_retry;
+	/* timer to determine idleness */
+	struct timer_list idle_timer;
+	/* Time to give up, in jiffies */
+	unsigned long stop_retry;
+	/* Delay length in ms */
+	unsigned int retry_delay;
+	/* Task context for resets */
+	struct work_struct reset_work;
+	/* waking up for output to be done in task context */
+	struct work_struct restart_work;
 };
 
 #define	hid_to_usb_dev(hid_dev) \
diff -urp linux-2.6.23-rc6/include/linux/hid.h hid/include/linux/hid.h
--- linux-2.6.23-rc6/include/linux/hid.h	2007-09-19 16:59:06.000000000 +0200
+++ hid/include/linux/hid.h	2007-09-24 16:04:27.000000000 +0200
@@ -410,6 +410,8 @@ struct hid_control_fifo {
 #define HID_RESET_PENDING	4
 #define HID_SUSPENDED		5
 #define HID_CLEAR_HALT		6
+#define HID_REPORTED_IDLE	7
+#define HID_KEYS_PRESSED	8
 
 struct hid_input {
 	struct list_head list;
@@ -514,6 +516,7 @@ void hid_input_field(struct hid_device *
 void hid_output_report(struct hid_report *report, __u8 *data);
 void hid_free_device(struct hid_device *device);
 struct hid_device *hid_parse_report(__u8 *start, unsigned size);
+int hid_check_keys_pressed(struct hid_device *hid);
 
 /* HID quirks API */
 u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);
