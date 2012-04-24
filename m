From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Tue, 24 Apr 2012 12:19:00 +0800
Message-ID: <CACVXFVNhPKbFZN5AjT3BNdNP+3bZP7miJZrBEER97scMR5nNAQ@mail.gmail.com>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
	<Pine.LNX.4.44L0.1204231121200.1612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43915 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab2DXETF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 00:19:05 -0400
In-Reply-To: <Pine.LNX.4.44L0.1204231121200.1612-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Mon, Apr 23, 2012 at 11:42 PM, Alan Stern <stern@rowland.harvard.edu=
> wrote:
> On Sun, 22 Apr 2012, Ming Lei wrote:

>> If the lock which is to be acquired in the URB complete handler is d=
ropped
>> before calling usb_unlink_urb, one new submitted URB in complete han=
dler
>> may be unlinked, as mentioned by Oliver already.
>
> We are now talking about two locks. =A0One of them is held during the
> call to usb_unlink_urb; the completion handler does not acquire that
> lock if the URB's status is -ECONNRESET. =A0The other lock is dropped
> before usb_unlink_urb is called, so the completion handler can safely
> grab it.

Yes, adding a new unlink lock plus  -ECONNRESET status can
fix the problem, and it is a very simple solution, just like below:

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
index aa1c503..a1adb81 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -430,6 +430,8 @@ static void hid_irq_out(struct urb *urb)
 	}

 	spin_lock_irqsave(&usbhid->lock, flags);
+	if (status !=3D -ECONNRESET)
+		spin_lock(&usbhid->unlink_lock);

 	if (unplug)
 		usbhid->outtail =3D usbhid->outhead;
@@ -438,11 +440,15 @@ static void hid_irq_out(struct urb *urb)

 	if (usbhid->outhead !=3D usbhid->outtail && !hid_submit_out(hid)) {
 		/* Successfully submitted next urb in queue */
+		if (status !=3D -ECONNRESET)
+			spin_unlock(&usbhid->unlink_lock);
 		spin_unlock_irqrestore(&usbhid->lock, flags);
 		return;
 	}

 	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
+	if (status !=3D -ECONNRESET)
+		spin_unlock(&usbhid->unlink_lock);
 	spin_unlock_irqrestore(&usbhid->lock, flags);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
@@ -459,6 +465,8 @@ static void hid_ctrl(struct urb *urb)
 	int unplug =3D 0, status =3D urb->status;

 	spin_lock(&usbhid->lock);
+	if (status !=3D -ECONNRESET)
+		spin_lock(&usbhid->unlink_lock);

 	switch (status) {
 	case 0:			/* success */
@@ -486,11 +494,15 @@ static void hid_ctrl(struct urb *urb)

 	if (usbhid->ctrlhead !=3D usbhid->ctrltail && !hid_submit_ctrl(hid)) =
{
 		/* Successfully submitted next urb in queue */
+		if (status !=3D -ECONNRESET)
+			spin_unlock(&usbhid->unlink_lock);
 		spin_unlock(&usbhid->lock);
 		return;
 	}

 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
+	if (status !=3D -ECONNRESET)
+		spin_unlock(&usbhid->unlink_lock);
 	spin_unlock(&usbhid->lock);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
@@ -546,8 +558,13 @@ static void __usbhid_submit_report(struct
hid_device *hid, struct hid_report *re
 			 * no race because this is called under
 			 * spinlock
 			 */
-			if (time_after(jiffies, usbhid->last_out + HZ * 5))
+			spin_lock(&usbhid->unlink_lock);
+			if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
+				spin_unlock(&usbhid->lock);
 				usb_unlink_urb(usbhid->urbout);
+				spin_lock(&usbhid->lock);
+			}
+			spin_unlock(&usbhid->unlink_lock);
 		}
 		return;
 	}
@@ -594,8 +611,13 @@ static void __usbhid_submit_report(struct
hid_device *hid, struct hid_report *re
 		 * no race because this is called under
 		 * spinlock
 		 */
-		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5))
+		spin_lock(&usbhid->unlink_lock);
+		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5)) {
+			spin_unlock(&usbhid->lock);
 			usb_unlink_urb(usbhid->urbctrl);
+			spin_lock(&usbhid->lock);
+		}
+		spin_unlock(&usbhid->unlink_lock);
 	}
 }

@@ -1299,6 +1321,7 @@ static int usbhid_probe(struct usb_interface
*intf, const struct usb_device_id *
 	INIT_WORK(&usbhid->reset_work, hid_reset);
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid=
);
 	spin_lock_init(&usbhid->lock);
+	spin_lock_init(&usbhid->unlink_lock);

 	INIT_WORK(&usbhid->led_work, hid_led);

diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 1883d7b..69af387 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -90,6 +90,7 @@ struct usbhid_device {
 	unsigned long last_out;							/* record of last output for timeouts *=
/

 	spinlock_t lock;						/* fifo spinlock */
+	spinlock_t unlink_lock;						/* unlink spinlock */
 	unsigned long iofl;                                             /*
I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /*
Retry timer */
 	unsigned long stop_retry;                                       /*
Time to give up, in jiffies */


>
> On Mon, 23 Apr 2012, Oliver Neukum wrote:
>
>> > If the URB completes asynchronously after unlinking, its status is=
 still
>> > =A0-ECONNRESET, so extra race may be caused without holding the lo=
ck
>> > because complete handler will access some global data.
>>
>> That is the race. And you need not invoke global data. The original
>> race opens again if you are submitting a new URB without the lock
>> held.
>> This is because we cannot be sure that the same URB is unlinked
>> only once. A subsequent timeout may kill the wrong URB if the
>> first is unlinked so that the callback really comes in interrupt.
>>
>> But the basic idea is brilliant. It's just that the one way logical =
implication:
>> recursive direct call of the callback -> status =3D=3D -ECONNRESET
>> is not strong enough. But that is very easy to fix. As we know wheth=
er
>> the callback is directly called or not, all we need to do is differe=
ntiate
>> the cases in urb->status, by introducing a new error code.
>
> I don't like the idea of changing the status codes. =A0It would mean
> changing usb_kill_urb too.
>
> Instead of changing return codes or adding locks, how about
> implementing a small state machine for each URB?
>
> =A0 =A0 =A0 =A0Initially the state is ACTIVE.
>
> =A0 =A0 =A0 =A0When the URB times out, acquire the lock. =A0If the st=
ate is not
> =A0 =A0 =A0 =A0equal to ACTIVE, drop the lock and return immediately =
(the URB
> =A0 =A0 =A0 =A0is being unlinked concurrently). =A0Otherwise set the =
state to
> =A0 =A0 =A0 =A0UNLINK_STARTED, drop the lock, call usb_unlink_urb, an=
d
> =A0 =A0 =A0 =A0reacquire the lock. =A0If the state hasn't changed, se=
t it back
> =A0 =A0 =A0 =A0to ACTIVE. =A0But if the state has changed to UNLINK_F=
INISHED,
> =A0 =A0 =A0 =A0set it to ACTIVE and resubmit.
>
> =A0 =A0 =A0 =A0In the completion handler, grab the lock. =A0If the st=
ate
> =A0 =A0 =A0 =A0is ACTIVE, resubmit. =A0But if the state is UNLINK_STA=
RTED,
> =A0 =A0 =A0 =A0change it to UNLINK_FINISHED and don't resubmit.

Sounds a smart solution, but extra care should be put on submit urb
in other context, maybe the lock is to be held to check URB state befor=
e
submitting it because the lock is released during usb_unlink_urb.

Also basically the URB state is maintained by device driver, so looks
better to add the state into specific device driver instead of struct U=
RB to
save each URB storage, but if so, the solution will become more
complicated than the way of adding lock.

> This is a better approach, in that it doesn't make any assumptions
> regarding synchronous vs. asynchronous unlinks. =A0If you want, you c=
ould
> have two different ACTIVE substates, one for URBs which haven't yet
> been unlinked and one for URBs which have been. =A0Then you could avo=
id
> unlinking the same URB twice.


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
