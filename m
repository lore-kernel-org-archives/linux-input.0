From: David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Mon, 8 Feb 2010 20:35:08 -0600
Message-ID: <20100209023508.GB22311@spacedout.fries.net>
References: <20100206172051.GA22311@spacedout.fries.net> <201002081256.01614.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201002081256.01614.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 08, 2010 at 12:56:01PM +0100, Oliver Neukum wrote:
> Am Samstag, 6. Februar 2010 18:20:52 schrieb David Fries:
> > resubmit it.  While it does work, I don't consider this the right
> > solution and it still leaves the UPS unmonitored for the nearly hour
> > that it takes the control queue to fill up and trigger my routine.  The
> > usb monitor doesn't say why the control request doesn't complete, just
> > that it was submitted and didn't complete.
> > 
> > Any ideas?  I can try changes or enable other debugging, just keep in
> > mind the time for this to reproduce, which could be a week or a month
> > between stuck control requests.
> 
> Hi,
> 
> it seems we need to implement a timeout. Does this patch help?
> Comments?
> 
> 	Regards
> 		Oliver

Good solution, only it's urbctrl failing on me not urbout, no reason
not to do both of them.  Feel free to merge the patches into one.

I've added some additional print messages to tell me when the timeout
happens, and I'll watch for that.  Unfortunately it's a rare event and
might take a week or a month to happen.  I'll provide feedback again
when it happens, I don't know if you want to wait that long to submit
it upstream or not.

This does look good for my situation.  It's apcupsd polling the UPS
for battery, power status, etc.  A few seconds of missed reads doesn't
much matter, it is only looking for the latest data anyway.  I do
wonder for the control out or urb out cases if the current urb should
be retried instead of just silently dropped, again for other devices
that might depend on packets being complete and in order.

-- 
David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
http://fries.net/~david/ (PGP encryption key available)

>From 4bf8e5d6d42891a6d01fee1b8f3bb674d8364843 Mon Sep 17 00:00:00 2001
From: David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
Date: Mon, 8 Feb 2010 19:30:56 -0600
Subject: [PATCH] HID: usbhid: implement a timeout for control requests

Some devices do not react to a control request.
Therefore request need a timeout (control instead of output request).

Signed-off-by: David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
---
 drivers/hid/usbhid/hid-core.c |   14 +++++++++++++-
 drivers/hid/usbhid/usbhid.h   |    3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b326edd..076a29a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -380,6 +380,7 @@ static int hid_submit_ctrl(struct hid_device *hid)
 			err_hid("usb_submit_urb(ctrl) failed");
 			return -1;
 		}
+		usbhid->last_ctrl = jiffies;
 	} else {
 		/*
 		 * queue work to wake up the device.
@@ -548,9 +549,20 @@ void __usbhid_submit_report(struct hid_device *hid, struct hid_report *report, u
 	usbhid->ctrl[usbhid->ctrlhead].dir = dir;
 	usbhid->ctrlhead = head;
 
-	if (!test_and_set_bit(HID_CTRL_RUNNING, &usbhid->iofl))
+	if (!test_and_set_bit(HID_CTRL_RUNNING, &usbhid->iofl)) {
 		if (hid_submit_ctrl(hid))
 			clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
+	} else {
+		/*
+		 * the queue is known to run
+		 * but an earlier request may be stuck
+		 * we may need to time out
+		 * no race because this is called under
+		 * spinlock
+		 */
+		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5))
+			usb_unlink_urb(usbhid->urbctrl);
+	}
 }
 
 void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 09831f9..ec20400 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -80,12 +80,14 @@ struct usbhid_device {
 	unsigned char ctrlhead, ctrltail;                               /* Control fifo head & tail */
 	char *ctrlbuf;                                                  /* Control buffer */
 	dma_addr_t ctrlbuf_dma;                                         /* Control buffer dma */
+	unsigned long last_ctrl;						/* record of last output for timeouts */
 
 	struct urb *urbout;                                             /* Output URB */
 	struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Output pipe fifo */
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
+	unsigned long last_out;							/* record of last output for timeouts */
 
 	spinlock_t lock;						/* fifo spinlock */
 	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
@@ -96,7 +98,6 @@ struct usbhid_device {
 	struct work_struct restart_work;				/* waking up for output to be done in a task */
 	wait_queue_head_t wait;						/* For sleeping */
 	int ledcount;							/* counting the number of active leds */
-	unsigned long last_out;							/* record of last output for timeouts */
 };
 
 #define	hid_to_usb_dev(hid_dev) \
-- 
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
