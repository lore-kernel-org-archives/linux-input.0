From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 10:10:09 +0800
Message-ID: <CACVXFVPZQNNvGk0cn4XWDTKd_s71V0Yd9nZJ3nkEg1Qh7W+B5g@mail.gmail.com>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
	<201204191811.33994.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57861 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab2DTCKN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Apr 2012 22:10:13 -0400
In-Reply-To: <201204191811.33994.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Fri, Apr 20, 2012 at 12:11 AM, Oliver Neukum <oneukum@suse.de> wrote=
:
> Am Donnerstag, 19. April 2012, 15:51:04 schrieb Ming Lei:
>> The URB complete handler may be called by usb_unlink_urb directly,
>> so deadlock will be triggered in __usbhid_submit_report since
>> usbhid->lock is to be acquired in ctrl/out URB complete handler
>> but it is hold before calling usb_unlink_urb.
>>
>> This patch avoids the deadlock by releasing the lock before
>> calling usb_unlink_urb.
>>
>> CC: <stable@vger.kernel.org>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0drivers/hid/usbhid/hid-core.c | =A0 16 ++++++++++------
>> =A01 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-=
core.c
>> index aa1c503..b5d07da 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -543,11 +543,13 @@ static void __usbhid_submit_report(struct hid_=
device *hid, struct hid_report *re
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the queue is known =
to run
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* but an earlier requ=
est may be stuck
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we may need to time=
 out
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because this =
is called under
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* spinlock
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* release spinlock to a=
void deadlock.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, us=
bhid->last_out + HZ * 5))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, us=
bhid->last_out + HZ * 5)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unloc=
k(&usbhid->lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_unli=
nk_urb(usbhid->urbout);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(=
&usbhid->lock);
>
> The problem indeed exists on some HCDs.
> I am afraid if you drop the lock there you introduce a race whereby
> you might unlink the wrong request.

The complete handler is called just one time per one submit in either
irq path or unlink path. Secondly, usb_unlink_urb itself is race free.
=46inally, usb_unlink_urb was always the last function called inside
__usbhid_submit_report.

So I don't see any races can be introduced by the patch.


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
