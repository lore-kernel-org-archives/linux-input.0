From: Oliver Neukum <oliver@neukum.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Mon, 8 Feb 2010 12:56:01 +0100
Message-ID: <201002081256.01614.oliver@neukum.org>
References: <20100206172051.GA22311@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54051 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0BHL4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 06:56:05 -0500
In-Reply-To: <20100206172051.GA22311@spacedout.fries.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Fries <david@fries.net>
Cc: USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

Am Samstag, 6. Februar 2010 18:20:52 schrieb David Fries:
> resubmit it.  While it does work, I don't consider this the right
> solution and it still leaves the UPS unmonitored for the nearly hour
> that it takes the control queue to fill up and trigger my routine.  The
> usb monitor doesn't say why the control request doesn't complete, just
> that it was submitted and didn't complete.
> 
> Any ideas?  I can try changes or enable other debugging, just keep in
> mind the time for this to reproduce, which could be a week or a month
> between stuck control requests.

Hi,

it seems we need to implement a timeout. Does this patch help?
Comments?

	Regards
		Oliver

>From 7b10f302c6caa940ea5ad67efb8a517923abfcc7 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Mon, 8 Feb 2010 12:44:14 +0100
Subject: [PATCH] HID: usbhid: implement a timeout for control requests

Some devices do not react to a control request.
Therefore request need a timeout.

Signed-off-by: Oliver Neukum <oliver@neukum.org>
---
 drivers/hid/usbhid/hid-core.c |   14 +++++++++++++-
 drivers/hid/usbhid/usbhid.h   |    1 +
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index e2997a8..2f12a5a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -316,6 +316,7 @@ static int hid_submit_out(struct hid_device *hid)
 			err_hid("usb_submit_urb(out) failed");
 			return -1;
 		}
+		usbhid->last_out = jiffies;
 	} else {
 		/*
 		 * queue work to wake up the device.
@@ -512,9 +513,20 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 		usbhid->out[usbhid->outhead].report = report;
 		usbhid->outhead = head;
 
-		if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl))
+		if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl)) {
 			if (hid_submit_out(hid))
 				clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
+		} else {
+			/*
+			 * the queue is known to run
+			 * but an earlier request may be stuck
+			 * we may need to time out
+			 * no race because this is called under
+			 * spinlock
+			 */
+			if (time_after(jiffies, usbhid->last_out + HZ * 5))
+				usb_unlink_urb(usbhid->urbout);
+		}
 		return;
 	}
 
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 08f505c..09831f9 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -96,6 +96,7 @@ struct usbhid_device {
 	struct work_struct restart_work;				/* waking up for output to be done in a task */
 	wait_queue_head_t wait;						/* For sleeping */
 	int ledcount;							/* counting the number of active leds */
+	unsigned long last_out;							/* record of last output for timeouts */
 };
 
 #define	hid_to_usb_dev(hid_dev) \
-- 
1.6.4.2

