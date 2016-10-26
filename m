From: Simon Wood <gitsend@mungewell.org>
Subject: [RFC] HID:hid-lg4ff: Delay to allow wheels to center after plug-in
Date: Tue, 25 Oct 2016 19:26:12 -0600
Message-ID: <1477445172-2682-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:40974 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbcJZB0b (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Oct 2016 21:26:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

A number of wheels (G27/etc) do a little full right/full left 'dance'
when first plugged in. This patch inserts a delay so that this 'dance'
is completed before we disable (set to zero) the autocenter spring.

A side benefit is that the DFGT was confused without the delay, and is
now correctly being set to 900' rotation mode.

Side Effect - and the reason I am sending as RFC. This 8s delay seems
to have an effect on other wheels connected at the same time.

With 3 wheels on a hub, and then the hub connected to PC. The wheel
on the right in video below waits for G27 to complete this 8s, before
it will do it's 'dance' and register with the system.

https://www.youtube.com/watch?v=xCVpCw_yGgA

I don't know if this is a problem, or if someone here has suggestions
on a better way to implement the delay...
---
 drivers/hid/hid-lg4ff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index af3a8ec..3eee920 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1248,6 +1248,8 @@ int lg4ff_init(struct hid_device *hid)
 	/* Check if autocentering is available and
 	 * set the centering force to zero by default */
 	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
+		wait_queue_head_t wait;
+
 		/* Formula Force EX expects different autocentering command */
 		if ((bcdDevice >> 8) == LG4FF_FFEX_REV_MAJ &&
 		    (bcdDevice & 0xff) == LG4FF_FFEX_REV_MIN)
@@ -1255,6 +1257,14 @@ int lg4ff_init(struct hid_device *hid)
 		else
 			dev->ff->set_autocenter = lg4ff_set_autocenter_default;
 
+		/* insert a 8s delay to allow DFGT/G25/G27/G29 wheels to return to center position*/
+		if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_DFGT_WHEEL ||
+				lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G25_WHEEL ||
+				lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL ||
+				lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G29_WHEEL) {
+			init_waitqueue_head (&wait);
+			wait_event_interruptible_timeout(wait, 0, msecs_to_jiffies(8000));
+		}
 		dev->ff->set_autocenter(dev, 0);
 	}
 
-- 
2.7.4

