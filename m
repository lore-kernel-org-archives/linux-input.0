From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 2/8] HID: usbhid: update LED fields unlocked
Date: Mon, 15 Jul 2013 19:10:11 +0200
Message-ID: <1373908217-16748-3-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:35487 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3GORKi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:38 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so7748607eei.41
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:36 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

Report fields can be updated from HID drivers unlocked via
hid_set_field(). It is protected by input_lock in HID core so only a
single input event is handled at a time. USBHID can thus update the field
unlocked and doesn't conflict with any HID vendor/device drivers. Note,
many HID drivers make heavy use of hid_set_field() in that way.

But usbhid also schedules a work to gather multiple LED changes in a
single report. Hence, we used to lock the LED field update so the work can
read a consistent state. However, hid_set_field() only writes a single
integer field, which is guaranteed to be allocated all the time. So the
worst possible race-condition is a garbage read on the LED field.

Therefore, there is no need to protect the update. In fact, the only thing
that is prevented by locking hid_set_field(), is an LED update while the
scheduled work currently writes an older LED update out. However, this
means, a new work is scheduled directly when the old one is done writing
the new state to the device. So we actually _win_ by not protecting the
write and allowing the write to be combined with the current write. A new
worker is still scheduled, but will not write any new state. So the LED
will not blink unnecessarily on the device.

Assume we have the LED set to 0. Two request come in which enable the LED
and immediately disable it. The current situation with two CPUs would be:

  usb_hidinput_input_event()       |      hid_led()
  ---------------------------------+----------------------------------
    spin_lock(&usbhid->lock);
    hid_set_field(1);
    spin_unlock(&usbhid->lock);
    schedule_work(...);
                                      spin_lock(&usbhid->lock);
                                      __usbhid_submit_report(..1..);
                                      spin_unlock(&usbhid->lock);
    spin_lock(&usbhid->lock);
    hid_set_field(0);
    spin_unlock(&usbhid->lock);
    schedule_work(...);
                                      spin_lock(&usbhid->lock);
                                      __usbhid_submit_report(..0..);
                                      spin_unlock(&usbhid->lock);

With the locking removed, we _might_ end up with (look at the changed
__usbhid_submit_report() parameters in the first try!):

  usb_hidinput_input_event()       |      hid_led()
  ---------------------------------+----------------------------------
    hid_set_field(1);
    schedule_work(...);
                                      spin_lock(&usbhid->lock);
    hid_set_field(0);
    schedule_work(...);
                                      __usbhid_submit_report(..0..);
                                      spin_unlock(&usbhid->lock);

                                      ... next work ...

                                      spin_lock(&usbhid->lock);
                                      __usbhid_submit_report(..0..);
                                      spin_unlock(&usbhid->lock);

As one can see, we no longer send the "LED ON" signal as it is disabled
immediately afterwards and the following "LED OFF" request overwrites the
pending "LED ON".

It is important to note that hid_set_field() is not atomic, so we might
also end up with any other value. But that doesn't matter either as we
_always_ schedule the next work with a correct value and schedule_work()
acts as memory barrier, anyways. So in the worst case, we run
__usbhid_submit_report(..<garbage>..) in the first case and the following
__usbhid_submit_report() will write the correct value. But LED states are
booleans so any garbage will be converted to either 0 or 1 and the remote
device will never see invalid requests.

Why all this? It avoids any custom locking around hid_set_field() in
usbhid and finally allows us to provide a generic hidinput_input_event()
handler for all HID transport drivers.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 5482bf4..62b5131 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -664,6 +664,19 @@ static void hid_led(struct work_struct *work)
 		return;
 	}
 
+	/*
+	 * field->report is accessed unlocked regarding HID core. So there might
+	 * be another incoming SET-LED request from user-space, which changes
+	 * the LED state while we assemble our outgoing buffer. However, this
+	 * doesn't matter as hid_output_report() correctly converts it into a
+	 * boolean value no matter what information is currently set on the LED
+	 * field (even garbage). So the remote device will always get a valid
+	 * request.
+	 * And in case we send a wrong value, a next hid_led() worker is spawned
+	 * for every SET-LED request so the following hid_led() worker will send
+	 * the correct value, guaranteed!
+	 */
+
 	spin_lock_irqsave(&usbhid->lock, flags);
 	if (!test_bit(HID_DISCONNECTED, &usbhid->iofl)) {
 		usbhid->ledcount = hidinput_count_leds(hid);
@@ -678,7 +691,6 @@ static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, un
 	struct hid_device *hid = input_get_drvdata(dev);
 	struct usbhid_device *usbhid = hid->driver_data;
 	struct hid_field *field;
-	unsigned long flags;
 	int offset;
 
 	if (type == EV_FF)
@@ -692,9 +704,7 @@ static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, un
 		return -1;
 	}
 
-	spin_lock_irqsave(&usbhid->lock, flags);
 	hid_set_field(field, offset, value);
-	spin_unlock_irqrestore(&usbhid->lock, flags);
 
 	/*
 	 * Defer performing requested LED action.
-- 
1.8.3.2

