From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Wed, 18 Nov 2015 21:25:55 +0200
Message-ID: <1447874755-8673-1-git-send-email-adi@adirat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38404 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781AbbKRT0A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2015 14:26:00 -0500
Received: by wmec201 with SMTP id c201so87803619wme.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2015 11:25:59 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The critical section protected by usbhid->lock in hid_ctrl() is too
big and in rare cases causes a recursive deadlock because of its call
to hid_input_report().

This deadlock reproduces on newer wacom tablets like 056a:033c because
the wacom driver in its irq handler ends up calling hid_hw_request()
from wacom_intuos_schedule_prox_event() in wacom_wac.c. What this means
is that it submits a report to reschedule a proximity read through a
sync ctrl call which grabs the lock in hid_ctrl(struct urb *urb)
before calling hid_input_report(). When the irq kicks in on the same
cpu, it also tries to grab the lock resulting in a recursive deadlock.

The proper fix is to shrink the critical section in hid_ctrl() to
protect only the instructions which modify usbhid, thus move the lock
after the hid_input_report() call and the deadlock dissapears.

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 drivers/hid/usbhid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 36712e9..5dd426f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -477,8 +477,6 @@ static void hid_ctrl(struct urb *urb)
 	struct usbhid_device *usbhid = hid->driver_data;
 	int unplug = 0, status = urb->status;
 
-	spin_lock(&usbhid->lock);
-
 	switch (status) {
 	case 0:			/* success */
 		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
@@ -498,6 +496,8 @@ static void hid_ctrl(struct urb *urb)
 		hid_warn(urb->dev, "ctrl urb status %d received\n", status);
 	}
 
+	spin_lock(&usbhid->lock);
+
 	if (unplug) {
 		usbhid->ctrltail = usbhid->ctrlhead;
 	} else {
-- 
2.6.3

