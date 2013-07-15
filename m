From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 4/8] HID: usbhid: use generic hidinput_input_event()
Date: Mon, 15 Jul 2013 19:10:13 +0200
Message-ID: <1373908217-16748-5-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:33226 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3GORKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:42 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so8023001eak.28
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:41 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

HID core provides the same functionality as we do, so drop the custom
hidinput_input_event() handler.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 74 ++-----------------------------------------
 drivers/hid/usbhid/usbhid.h   |  3 --
 2 files changed, 3 insertions(+), 74 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 62b5131..8c32357 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -649,72 +649,6 @@ static void usbhid_submit_report(struct hid_device *hid, struct hid_report *repo
 	spin_unlock_irqrestore(&usbhid->lock, flags);
 }
 
-/* Workqueue routine to send requests to change LEDs */
-static void hid_led(struct work_struct *work)
-{
-	struct usbhid_device *usbhid =
-		container_of(work, struct usbhid_device, led_work);
-	struct hid_device *hid = usbhid->hid;
-	struct hid_field *field;
-	unsigned long flags;
-
-	field = hidinput_get_led_field(hid);
-	if (!field) {
-		hid_warn(hid, "LED event field not found\n");
-		return;
-	}
-
-	/*
-	 * field->report is accessed unlocked regarding HID core. So there might
-	 * be another incoming SET-LED request from user-space, which changes
-	 * the LED state while we assemble our outgoing buffer. However, this
-	 * doesn't matter as hid_output_report() correctly converts it into a
-	 * boolean value no matter what information is currently set on the LED
-	 * field (even garbage). So the remote device will always get a valid
-	 * request.
-	 * And in case we send a wrong value, a next hid_led() worker is spawned
-	 * for every SET-LED request so the following hid_led() worker will send
-	 * the correct value, guaranteed!
-	 */
-
-	spin_lock_irqsave(&usbhid->lock, flags);
-	if (!test_bit(HID_DISCONNECTED, &usbhid->iofl)) {
-		usbhid->ledcount = hidinput_count_leds(hid);
-		hid_dbg(usbhid->hid, "New ledcount = %u\n", usbhid->ledcount);
-		__usbhid_submit_report(hid, field->report, USB_DIR_OUT);
-	}
-	spin_unlock_irqrestore(&usbhid->lock, flags);
-}
-
-static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-	struct usbhid_device *usbhid = hid->driver_data;
-	struct hid_field *field;
-	int offset;
-
-	if (type == EV_FF)
-		return input_ff_event(dev, type, code, value);
-
-	if (type != EV_LED)
-		return -1;
-
-	if ((offset = hidinput_find_field(hid, type, code, &field)) == -1) {
-		hid_warn(dev, "event field not found\n");
-		return -1;
-	}
-
-	hid_set_field(field, offset, value);
-
-	/*
-	 * Defer performing requested LED action.
-	 * This is more likely gather all LED changes into a single URB.
-	 */
-	schedule_work(&usbhid->led_work);
-
-	return 0;
-}
-
 static int usbhid_wait_io(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
@@ -1283,7 +1217,6 @@ static struct hid_ll_driver usb_hid_driver = {
 	.open = usbhid_open,
 	.close = usbhid_close,
 	.power = usbhid_power,
-	.hidinput_input_event = usb_hidinput_input_event,
 	.request = usbhid_request,
 	.wait = usbhid_wait_io,
 	.idle = usbhid_idle,
@@ -1377,8 +1310,6 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
 	spin_lock_init(&usbhid->lock);
 
-	INIT_WORK(&usbhid->led_work, hid_led);
-
 	ret = hid_add_device(hid);
 	if (ret) {
 		if (ret != -ENODEV)
@@ -1411,7 +1342,6 @@ static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
 {
 	del_timer_sync(&usbhid->io_retry);
 	cancel_work_sync(&usbhid->reset_work);
-	cancel_work_sync(&usbhid->led_work);
 }
 
 static void hid_cease_io(struct usbhid_device *usbhid)
@@ -1531,15 +1461,17 @@ static int hid_suspend(struct usb_interface *intf, pm_message_t message)
 	struct usbhid_device *usbhid = hid->driver_data;
 	int status = 0;
 	bool driver_suspended = false;
+	unsigned int ledcount;
 
 	if (PMSG_IS_AUTO(message)) {
+		ledcount = hidinput_count_leds(hid);
 		spin_lock_irq(&usbhid->lock);	/* Sync with error handler */
 		if (!test_bit(HID_RESET_PENDING, &usbhid->iofl)
 		    && !test_bit(HID_CLEAR_HALT, &usbhid->iofl)
 		    && !test_bit(HID_OUT_RUNNING, &usbhid->iofl)
 		    && !test_bit(HID_CTRL_RUNNING, &usbhid->iofl)
 		    && !test_bit(HID_KEYS_PRESSED, &usbhid->iofl)
-		    && (!usbhid->ledcount || ignoreled))
+		    && (!ledcount || ignoreled))
 		{
 			set_bit(HID_SUSPENDED, &usbhid->iofl);
 			spin_unlock_irq(&usbhid->lock);
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index dbb6af6..f633c24 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -92,9 +92,6 @@ struct usbhid_device {
 	unsigned int retry_delay;                                       /* Delay length in ms */
 	struct work_struct reset_work;                                  /* Task context for resets */
 	wait_queue_head_t wait;						/* For sleeping */
-	int ledcount;							/* counting the number of active leds */
-
-	struct work_struct led_work;					/* Task context for setting LEDs */
 };
 
 #define	hid_to_usb_dev(hid_dev) \
-- 
1.8.3.2

