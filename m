From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 20:53:24 +0800
Message-ID: <CACVXFVPzFeC8xbsVfYeYKsZXwQ05437EY4-H49PAiajyvdG91A@mail.gmail.com>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
	<201204200957.34154.oneukum@suse.de>
	<CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
	<201204201245.44981.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59850 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab2DTMx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 08:53:27 -0400
In-Reply-To: <201204201245.44981.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Fri, Apr 20, 2012 at 6:45 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Freitag, 20. April 2012, 12:17:51 schrieb Ming Lei:
>> On Fri, Apr 20, 2012 at 3:57 PM, Oliver Neukum <oneukum@suse.de> wro=
te:
>> >
>> > You are racing with hid_irq_out(). It calls hid_submit_out()
>> > under lock. So if hid_irq_out() is running between dropping
>> > the lock and usb_unlink_urb() you may kill the newly submitted
>> > urb, not the old urb that has timed out.
>>
>> Yes, it is the race I missed, :-(
>>
>> > You must make sure that between the times you check usbhid->last_o=
ut
>> > and calling unlink hid_submit_out() cannot be called.
>> > You can't just drop the lock (at least on SMP)
>>
>> Looks it is not easy to avoid the race if the lock is to be dropped.
>>
>> So how about not acquiring the lock during unlinking as below?
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-=
core.c
>> index aa1c503..b437223 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -429,7 +429,8 @@ static void hid_irq_out(struct urb *urb)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urb->status);
>> =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 spin_lock_irqsave(&usbhid->lock, flags);
>> + =A0 =A0 =A0 if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&usbhid->lock, flags=
);
>>
>> =A0 =A0 =A0 =A0 if (unplug)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbhid->outtail =3D usbhid->outhead;
>> @@ -438,12 +439,14 @@ static void hid_irq_out(struct urb *urb)
>>
>> =A0 =A0 =A0 =A0 if (usbhid->outhead !=3D usbhid->outtail && !hid_sub=
mit_out(hid)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Successfully submitted next urb i=
n queue */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&usbhid->lock, =
flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_cpu_bit(HID_PCPU_TIMEOUT, us=
bhid->cpuiofl))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore=
(&usbhid->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 =A0 }
>
> No. This introduces a race where you can drop a lock you've not taken
> and vice versa.

The flag is defined as per cpu variable, so it can't changed during the=
 two
test_cpu_bit in complete handler and can't cause the races you mentione=
d.

> And why are you using per cpu structures here?

If we want to introduce flag to address the issue, I think it has to be=
 defined
per CPU because we can't acquire the lock in complete handler triggered
by unlink path, but at the same time we must spin on the lock in comple=
te
handler from other CPUs(non unlinking, irq context)  to avoid races.

IMO, the patch can fix the deadlock problem.

>
> To be blunt, I'd prefer a guarantee that allows usb_unlink_urb() to b=
e
> called with spinlocks held.

I'd prefer it to, but looks it is not practical because quite a few
host controller
drivers need to be modified.

>
> Well, if we can't get a good usb_unlink_urb() then the lock must be d=
ropped.
> Your idea of setting a flag is good.
>
> You'd do in hid_irq_out():
>
> if (usbhid->outhead !=3D usbhid->outtail && !usbhid->timeout_detected=
 && !hid_submit_out(hid))
>
> and you set usbhid->timeout_detected under lock. That way we can neve=
r
> accidentally kill a new urb. This however means that then we need to =
kill the
> urb and restart the queue preferably from a workqueue and this must b=
e handled
> in suspend/resume/close/pre-/postreset/disconnect

It is a solution, but looks far more complicated than the per cpu flag =
patch.

Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
