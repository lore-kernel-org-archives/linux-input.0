From: Huajun Li <huajun.li.lee@gmail.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 19:24:14 +0800
Message-ID: <CA+v9cxYi-LC-gXMbP7J81ArCjwQJZQ=9ceu66W0QQe+6UD_LvQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1204241100210.1511-100000@iolanthe.rowland.org>
	<201204251006.16272.oneukum@suse.de>
	<CACVXFVM6KMeMcXy549x9XqhqvCzq73pXvhLki363=KjQu2Nfsg@mail.gmail.com>
	<201204251252.55901.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42734 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab2DYLYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 07:24:16 -0400
In-Reply-To: <201204251252.55901.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Ming Lei <ming.lei@canonical.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 25, 2012 at 6:52 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Mittwoch, 25. April 2012, 11:14:19 schrieb Ming Lei:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffi=
es, usbhid->last_out + HZ * 5))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffi=
es, usbhid->last_out + HZ * 5)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_=
block_urb(usbhid->urbout);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* d=
rop lock to not deadlock if the callback is called */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin=
_unlock(&usbhid->lock);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb=
_unlink_urb(usbhid->urbout);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin=
_lock(&usbhid->lock);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_=
unblock_urb(usbhid->urbout);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 if the unlinking has already completed
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 the pump will have been stopped
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
 it must be restarted now
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
!test_bit(HID_OUT_RUNNING, &usbhid->iofl))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 if (!hid_submit_out(hid))
>>
>> You need to add check of "usbhid->outtail !=3D usbhid->outhead" abov=
e.
>
> Done. Could you test?
>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
> From 9ff6b78dc59c98b9844dc9922549fd338828a889 Mon Sep 17 00:00:00 200=
1
> From: Oliver Neukum <oliver@neukum.org>
> Date: Wed, 25 Apr 2012 12:50:37 +0200
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
> =A0drivers/hid/usbhid/hid-core.c | =A0 61 +++++++++++++++++++++++++++=
++++++++++----
> =A0drivers/usb/core/urb.c =A0 =A0 =A0 =A0| =A0 30 +++++++++++++++++++=
+
> =A0include/linux/usb.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A03 files changed, 87 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index 5bf91db..c8eab8d 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -399,6 +399,16 @@ static int hid_submit_ctrl(struct hid_device *hi=
d)
> =A0* Output interrupt completion handler.
> =A0*/
>
> +static int irq_out_pump_restart(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct usbhid_device *usbhid =3D hid->driver_data;
> +
> + =A0 =A0 =A0 if (usbhid->outhead !=3D usbhid->outtail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return hid_submit_out(hid);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +}
> +
> =A0static void hid_irq_out(struct urb *urb)
> =A0{
> =A0 =A0 =A0 =A0struct hid_device *hid =3D urb->context;
> @@ -428,7 +438,7 @@ static void hid_irq_out(struct urb *urb)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbhid->outtail =3D (usbhid->outtail +=
 1) & (HID_OUTPUT_FIFO_SIZE - 1);
>
> - =A0 =A0 =A0 if (usbhid->outhead !=3D usbhid->outtail && !hid_submit=
_out(hid)) {
> + =A0 =A0 =A0 if (!irq_out_pump_restart(hid)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Successfully submitted next urb in =
queue */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&usbhid->lock, =
flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -443,6 +453,15 @@ static void hid_irq_out(struct urb *urb)
> =A0/*
> =A0* Control pipe completion handler.
> =A0*/
> +static int ctrl_pump_restart(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct usbhid_device *usbhid =3D hid->driver_data;
> +
> + =A0 =A0 =A0 =A0if (usbhid->ctrlhead !=3D usbhid->ctrltail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return hid_submit_ctrl(hid);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +}
>
> =A0static void hid_ctrl(struct urb *urb)
> =A0{
> @@ -476,7 +495,7 @@ static void hid_ctrl(struct urb *urb)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbhid->ctrltail =3D (usbhid->ctrltail=
 + 1) & (HID_CONTROL_FIFO_SIZE - 1);
>
> - =A0 =A0 =A0 if (usbhid->ctrlhead !=3D usbhid->ctrltail && !hid_subm=
it_ctrl(hid)) {
> + =A0 =A0 =A0 if (!ctrl_pump_restart(hid)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Successfully submitted next urb in =
queue */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&usbhid->lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -535,11 +554,27 @@ static void __usbhid_submit_report(struct hid_d=
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
 =A0 =A0 if (!irq_out_pump_restart(hid))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(HID_OUT_RUNNING, &usbhid->iofl);
> +
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> @@ -583,11 +618,25 @@ static void __usbhid_submit_report(struct hid_d=
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ct=
rl_pump_restart(hid))
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

Hi,
  So far, usb_unblock_urb() does same thing as usb_unpoison_urb(), so
is it possible reusing it just by adding a macro define?

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
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
