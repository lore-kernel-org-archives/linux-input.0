From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 10:06:15 +0200
Message-ID: <201204251006.16272.oneukum@suse.de>
References: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60937 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab2DYIKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 04:10:19 -0400
In-Reply-To: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Dienstag, 24. April 2012, 17:10:04 schrieb Alan Stern:
> > and check for UNLINK_STARTED
> > also when a timeout begins.
> 
> That was part of my description above: "If the state is not equal to
> ACTIVE, drop the lock and return immediately (the URB is being unlinked
> concurrently)."
> 
> > But I wouldn't call that a simple solution.
> 
> Well, that's a matter of opinion.  It does have the advantage, unlike 
> lots of other proposals in this email thread, of being a correct 
> solution.

Indeed. Upon further thought it seems to me that we need to prevent
resubmission and all is well. And we almost have all the infrastructure.

So how about this, making it more reusable:

>From ce77d793252d1abf3a0ec6c67e4a7a05ac6d846a Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Wed, 25 Apr 2012 09:54:00 +0200
Subject: [PATCH] usbhid: prevent deadlock during timeout

On some HCDs usb_unlink_urb() can directly call the
completion handler. That limits the spinlocks that can
be taken in the handler to locks not held while calling
usb_unlink_urb()
To prevent a race with resubmission, this patch exposes
usbcore's infrastructure for blocking submission, uses it
and so drops the lock without causing a race in usbhid.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/hid/usbhid/hid-core.c |   38 ++++++++++++++++++++++++++++++++++----
 drivers/usb/core/urb.c        |   30 ++++++++++++++++++++++++++++++
 include/linux/usb.h           |    2 ++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 5bf91db..763257d 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -535,11 +535,27 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 			 * the queue is known to run
 			 * but an earlier request may be stuck
 			 * we may need to time out
-			 * no race because this is called under
+			 * no race because the URB is blocked under
 			 * spinlock
 			 */
-			if (time_after(jiffies, usbhid->last_out + HZ * 5))
+			if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
+				usb_block_urb(usbhid->urbout);
+				/* drop lock to not deadlock if the callback is called */
+				spin_unlock(&usbhid->lock);
 				usb_unlink_urb(usbhid->urbout);
+				spin_lock(&usbhid->lock);
+				usb_unblock_urb(usbhid->urbout);
+				/*
+				 * if the unlinking has already completed
+				 * the pump will have been stopped
+				 * it must be restarted now
+				 */
+				if (!test_bit(HID_OUT_RUNNING, &usbhid->iofl))
+					if (!hid_submit_out(hid))
+						set_bit(HID_OUT_RUNNING, &usbhid->iofl);
+					
+
+			}
 		}
 		return;
 	}
@@ -583,11 +599,25 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 		 * the queue is known to run
 		 * but an earlier request may be stuck
 		 * we may need to time out
-		 * no race because this is called under
+		 * no race because the URB is blocked under
 		 * spinlock
 		 */
-		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5))
+		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5)) {
+			usb_block_urb(usbhid->urbctrl);
+			/* drop lock to not deadlock if the callback is called */
+			spin_unlock(&usbhid->lock);
 			usb_unlink_urb(usbhid->urbctrl);
+			spin_lock(&usbhid->lock);
+			usb_unblock_urb(usbhid->urbctrl);
+			/*
+			 * if the unlinking has already completed
+			 * the pump will have been stopped
+			 * it must be restarted now
+			 */
+			if (!test_bit(HID_CTRL_RUNNING, &usbhid->iofl))
+				if (!hid_submit_ctrl(hid))
+					set_bit(HID_CTRL_RUNNING, &usbhid->iofl);
+		}
 	}
 }
 
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index cd9b3a2..1d1b010 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -681,6 +681,36 @@ void usb_unpoison_urb(struct urb *urb)
 EXPORT_SYMBOL_GPL(usb_unpoison_urb);
 
 /**
+ * usb_block_urb - reliably prevent further use of an URB
+ * @urb: pointer to URB to be blocked, may be NULL
+ *
+ * After the routine has run, attempts to resubmit the URB will fail
+ * with error -EPERM.  Thus even if the URB's completion handler always
+ * tries to resubmit, it will not succeed and the URB will become idle.
+ *
+ * The URB must not be deallocated while this routine is running.  In
+ * particular, when a driver calls this routine, it must insure that the
+ * completion handler cannot deallocate the URB.
+ */
+void usb_block_urb(struct urb *urb)
+{
+        if (!urb)
+                return;
+
+        atomic_inc(&urb->reject);
+}
+EXPORT_SYMBOL_GPL(usb_block_urb);
+
+void usb_unblock_urb(struct urb *urb)
+{
+        if (!urb)
+                return;
+
+        atomic_dec(&urb->reject);
+}
+EXPORT_SYMBOL_GPL(usb_unblock_urb);
+
+/**
  * usb_kill_anchored_urbs - cancel transfer requests en masse
  * @anchor: anchor the requests are bound to
  *
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 73b68d1..23df8ae 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1379,6 +1379,8 @@ extern int usb_unlink_urb(struct urb *urb);
 extern void usb_kill_urb(struct urb *urb);
 extern void usb_poison_urb(struct urb *urb);
 extern void usb_unpoison_urb(struct urb *urb);
+extern void usb_block_urb(struct urb *urb);
+extern void usb_unblock_urb(struct urb *urb);
 extern void usb_kill_anchored_urbs(struct usb_anchor *anchor);
 extern void usb_poison_anchored_urbs(struct usb_anchor *anchor);
 extern void usb_unpoison_anchored_urbs(struct usb_anchor *anchor);
-- 
1.7.1

	Regards
		Oliver
