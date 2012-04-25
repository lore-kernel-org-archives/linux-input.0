From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 12:52:55 +0200
Message-ID: <201204251252.55901.oneukum@suse.de>
References: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org> <201204251006.16272.oneukum@suse.de> <CACVXFVM6KMeMcXy549x9XqhqvCzq73pXvhLki363=KjQu2Nfsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVM6KMeMcXy549x9XqhqvCzq73pXvhLki363=KjQu2Nfsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 25. April 2012, 11:14:19 schrieb Ming Lei:
> > -                       if (time_after(jiffies, usbhid->last_out + HZ * 5))
> > +                       if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
> > +                               usb_block_urb(usbhid->urbout);
> > +                               /* drop lock to not deadlock if the callback is called */
> > +                               spin_unlock(&usbhid->lock);
> >                                usb_unlink_urb(usbhid->urbout);
> > +                               spin_lock(&usbhid->lock);
> > +                               usb_unblock_urb(usbhid->urbout);
> > +                               /*
> > +                                * if the unlinking has already completed
> > +                                * the pump will have been stopped
> > +                                * it must be restarted now
> > +                                */
> > +                               if (!test_bit(HID_OUT_RUNNING, &usbhid->iofl))
> > +                                       if (!hid_submit_out(hid))
> 
> You need to add check of "usbhid->outtail != usbhid->outhead" above.

Done. Could you test?

	Regards
		Oliver
>From 9ff6b78dc59c98b9844dc9922549fd338828a889 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Wed, 25 Apr 2012 12:50:37 +0200
Subject: [PATCH] usbhid: prevent deadlock during timeout

On some HCDs usb_unlink_urb() can directly call the
completion handler. That limits the spinlocks that can
be taken in the handler to locks not held while calling
usb_unlink_urb()
To prevent a race with resubmission, this patch exposes
usbcore's infrastructure for blocking submission, uses it
and so drops the lock without causing a race in usbhid.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 drivers/hid/usbhid/hid-core.c |   61 +++++++++++++++++++++++++++++++++++++----
 drivers/usb/core/urb.c        |   30 ++++++++++++++++++++
 include/linux/usb.h           |    2 +
 3 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 5bf91db..c8eab8d 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -399,6 +399,16 @@ static int hid_submit_ctrl(struct hid_device *hid)
  * Output interrupt completion handler.
  */
 
+static int irq_out_pump_restart(struct hid_device *hid)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+
+	if (usbhid->outhead != usbhid->outtail)
+		return hid_submit_out(hid);
+	else
+		return -1;
+}
+
 static void hid_irq_out(struct urb *urb)
 {
 	struct hid_device *hid = urb->context;
@@ -428,7 +438,7 @@ static void hid_irq_out(struct urb *urb)
 	else
 		usbhid->outtail = (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
-	if (usbhid->outhead != usbhid->outtail && !hid_submit_out(hid)) {
+	if (!irq_out_pump_restart(hid)) {
 		/* Successfully submitted next urb in queue */
 		spin_unlock_irqrestore(&usbhid->lock, flags);
 		return;
@@ -443,6 +453,15 @@ static void hid_irq_out(struct urb *urb)
 /*
  * Control pipe completion handler.
  */
+static int ctrl_pump_restart(struct hid_device *hid)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+
+        if (usbhid->ctrlhead != usbhid->ctrltail)
+		return hid_submit_ctrl(hid);
+	else
+		return -1;
+}
 
 static void hid_ctrl(struct urb *urb)
 {
@@ -476,7 +495,7 @@ static void hid_ctrl(struct urb *urb)
 	else
 		usbhid->ctrltail = (usbhid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
-	if (usbhid->ctrlhead != usbhid->ctrltail && !hid_submit_ctrl(hid)) {
+	if (!ctrl_pump_restart(hid)) {
 		/* Successfully submitted next urb in queue */
 		spin_unlock(&usbhid->lock);
 		return;
@@ -535,11 +554,27 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
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
+					if (!irq_out_pump_restart(hid))
+						set_bit(HID_OUT_RUNNING, &usbhid->iofl);
+					
+
+			}
 		}
 		return;
 	}
@@ -583,11 +618,25 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
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
+				if (!ctrl_pump_restart(hid))
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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
