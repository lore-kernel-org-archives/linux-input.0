From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 17:14:19 +0800
Message-ID: <CACVXFVM6KMeMcXy549x9XqhqvCzq73pXvhLki363=KjQu2Nfsg@mail.gmail.com>
References: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org>
	<201204251006.16272.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49855 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab2DYJOX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 05:14:23 -0400
In-Reply-To: <201204251006.16272.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 25, 2012 at 4:06 PM, Oliver Neukum <oneukum@suse.de> wrote:

>
> Indeed. Upon further thought it seems to me that we need to prevent
> resubmission and all is well. And we almost have all the infrastructu=
re.
>
> So how about this, making it more reusable:

Yes, this one is good, better than the adding lock.

>
> From ce77d793252d1abf3a0ec6c67e4a7a05ac6d846a Mon Sep 17 00:00:00 200=
1
> From: Oliver Neukum <oliver@neukum.org>
> Date: Wed, 25 Apr 2012 09:54:00 +0200
> Subject: [PATCH] usbhid: prevent deadlock during timeout
>
> On some HCDs usb_unlink_urb() can directly call the
> completion handler. That limits the spinlocks that can
> be taken in the handler to locks not held while calling
> usb_unlink_urb()
> To prevent a race with resubmission, this patch exposes
> usbcore's infrastructure for blocking submission, uses it
> and so drops the lock without causing a race in usbhid.
>
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
> =A0drivers/hid/usbhid/hid-core.c | =A0 38 +++++++++++++++++++++++++++=
+++++++----
> =A0drivers/usb/core/urb.c =A0 =A0 =A0 =A0| =A0 30 +++++++++++++++++++=
+++++++++++
> =A0include/linux/usb.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A03 files changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index 5bf91db..763257d 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -535,11 +535,27 @@ static void __usbhid_submit_report(struct hid_d=
evice *hid, struct hid_report *re
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the queue is known =
to run
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * but an earlier requ=
est may be stuck
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we may need to time=
 out
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because th=
is is called under
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because th=
e URB is blocked under
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * spinlock
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies,=
 usbhid->last_out + HZ * 5))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies,=
 usbhid->last_out + HZ * 5)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_blo=
ck_urb(usbhid->urbout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* drop=
 lock to not deadlock if the callback is called */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock(&usbhid->lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_un=
link_urb(usbhid->urbout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lo=
ck(&usbhid->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_unb=
lock_urb(usbhid->urbout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if=
 the unlinking has already completed
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* th=
e pump will have been stopped
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it=
 must be restarted now
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!te=
st_bit(HID_OUT_RUNNING, &usbhid->iofl))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (!hid_submit_out(hid))

You need to add check of "usbhid->outtail !=3D usbhid->outhead" above.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(HID_OUT_RUNNING, &usbhid->iofl);
> +
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> @@ -583,11 +599,25 @@ static void __usbhid_submit_report(struct hid_d=
evice *hid, struct hid_report *re
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the queue is known to run
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * but an earlier request may be stuck
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we may need to time out
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because this is called und=
er
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because the URB is blocked=
 under
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * spinlock
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, usbhid->last_ct=
rl + HZ * 5))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, usbhid->last_ct=
rl + HZ * 5)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_block_urb(usbhid->u=
rbctrl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* drop lock to not dea=
dlock if the callback is called */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&usbhid->lo=
ck);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_unlink_urb(usbhid-=
>urbctrl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&usbhid->lock=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_unblock_urb(usbhid-=
>urbctrl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if the unlinking h=
as already completed
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the pump will have=
 been stopped
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it must be restart=
ed now
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_bit(HID_CTRL_=
RUNNING, &usbhid->iofl))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hi=
d_submit_ctrl(hid))

Similar as above.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 set_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0}
>
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index cd9b3a2..1d1b010 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -681,6 +681,36 @@ void usb_unpoison_urb(struct urb *urb)
> =A0EXPORT_SYMBOL_GPL(usb_unpoison_urb);
>
> =A0/**
> + * usb_block_urb - reliably prevent further use of an URB
> + * @urb: pointer to URB to be blocked, may be NULL
> + *
> + * After the routine has run, attempts to resubmit the URB will fail
> + * with error -EPERM. =A0Thus even if the URB's completion handler a=
lways
> + * tries to resubmit, it will not succeed and the URB will become id=
le.
> + *
> + * The URB must not be deallocated while this routine is running. =A0=
In
> + * particular, when a driver calls this routine, it must insure that=
 the
> + * completion handler cannot deallocate the URB.
> + */
> +void usb_block_urb(struct urb *urb)
> +{
> + =A0 =A0 =A0 =A0if (!urb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> +
> + =A0 =A0 =A0 =A0atomic_inc(&urb->reject);
> +}
> +EXPORT_SYMBOL_GPL(usb_block_urb);
> +
> +void usb_unblock_urb(struct urb *urb)
> +{
> + =A0 =A0 =A0 =A0if (!urb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> +
> + =A0 =A0 =A0 =A0atomic_dec(&urb->reject);
> +}
> +EXPORT_SYMBOL_GPL(usb_unblock_urb);
> +
> +/**
> =A0* usb_kill_anchored_urbs - cancel transfer requests en masse
> =A0* @anchor: anchor the requests are bound to
> =A0*
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 73b68d1..23df8ae 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1379,6 +1379,8 @@ extern int usb_unlink_urb(struct urb *urb);
> =A0extern void usb_kill_urb(struct urb *urb);
> =A0extern void usb_poison_urb(struct urb *urb);
> =A0extern void usb_unpoison_urb(struct urb *urb);
> +extern void usb_block_urb(struct urb *urb);
> +extern void usb_unblock_urb(struct urb *urb);
> =A0extern void usb_kill_anchored_urbs(struct usb_anchor *anchor);
> =A0extern void usb_poison_anchored_urbs(struct usb_anchor *anchor);
> =A0extern void usb_unpoison_anchored_urbs(struct usb_anchor *anchor);


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
