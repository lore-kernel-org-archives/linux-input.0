From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] hid: usbhid: hid-core: fix recursive deadlock
Date: Wed, 20 Jan 2016 17:28:53 -0800
Message-ID: <CANRwn3SU4zsxLAHUh4EP=LsGj1d_0-YV=je-Jfut4VXX3faBZQ@mail.gmail.com>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
	<1448050742-10777-1-git-send-email-adi@adirat.com>
	<20151129122915.66ead7c2@adipc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35528 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbcAUB2y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2016 20:28:54 -0500
In-Reply-To: <20151129122915.66ead7c2@adipc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, linux-usb@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, joshc@ni.com, Ioan-Adrian Ratiu <adi@adirat.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Sun, Nov 29, 2015 at 2:29 AM, Ioan-Adrian Ratiu <adi@adirat.com> wro=
te:
> On Fri, 20 Nov 2015 22:19:02 +0200
> Ioan-Adrian Ratiu <adi@adirat.com> wrote:
>
>> The critical section protected by usbhid->lock in hid_ctrl() is too
>> big and because of this it causes a recursive deadlock. "Too big" me=
ans
>> the case statement and the call to hid_input_report() do not need to=
 be
>> protected by the spinlock (no URB operations are done inside them).
>>
>> The deadlock happens because in certain rare cases drivers try to gr=
ab
>> the lock while handling the ctrl irq which grabs the lock before the=
m
>> as described above. For example newer wacom tablets like 056a:033c t=
ry
>> to reschedule proximity reads from wacom_intuos_schedule_prox_event(=
)
>> calling hid_hw_request() -> usbhid_request() -> usbhid_submit_report=
()
>> which tries to grab the usbhid lock already held by hid_ctrl().
>>
>> There are two ways to get out of this deadlock:
>>     1. Make the drivers work "around" the ctrl critical region, in t=
he
>>     wacom case for ex. by delaying the scheduling of the proximity r=
ead
>>     request itself to a workqueue.
>>     2. Shrink the critical region so the usbhid lock protects only t=
he
>>     instructions which modify usbhid state, calling hid_input_report=
()
>>     with the spinlock unlocked, allowing the device driver to grab t=
he
>>     lock first, finish and then grab the lock afterwards in hid_ctrl=
().
>>
>> This patch implements the 2nd solution.
>>
>> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
>> ---
>>  drivers/hid/usbhid/hid-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-=
core.c
>> index 36712e9..5dd426f 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -477,8 +477,6 @@ static void hid_ctrl(struct urb *urb)
>>       struct usbhid_device *usbhid =3D hid->driver_data;
>>       int unplug =3D 0, status =3D urb->status;
>>
>> -     spin_lock(&usbhid->lock);
>> -
>>       switch (status) {
>>       case 0:                 /* success */
>>               if (usbhid->ctrl[usbhid->ctrltail].dir =3D=3D USB_DIR_=
IN)
>> @@ -498,6 +496,8 @@ static void hid_ctrl(struct urb *urb)
>>               hid_warn(urb->dev, "ctrl urb status %d received\n", st=
atus);
>>       }
>>
>> +     spin_lock(&usbhid->lock);
>> +
>>       if (unplug) {
>>               usbhid->ctrltail =3D usbhid->ctrlhead;
>>       } else {
>
> Hello again
>
> Can this please be merged in the 4.4? There are quite a few people wh=
o have
> their tablets deadlock and don't know how to patch their kernels so a=
re stuck
> waiting for a new release.
>
> The severity of this issue is much bigger than I initially thought. S=
ince I've
> posted on the wacom mailing list that I have a fix for this deadlock =
I've
> recived lots of email from people complaining of the same problem on =
a wide
> range of tablets.
>
> Some of those people know how to patch a kernel, some found this patc=
h on the
> mailing list and tested it and confirmed that it works on the wacom m=
ailing
> list (you can verify the deadlock + fix on that mailing list).
>
> Thank you,
> Adrian


On Tue, Dec 1, 2015 at 4:00 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Hi Jiri,
>
> Since wacom_intuos_schedule_prox_event() was introduced on March 5,
> 2015, the call was first used in kernel 3.19. Shouldn't we back-port
> this patch to other stable versions?
>
> Thank you.
>
> Ping

I've been prompted to resurrect this question after fielding yet
another question from a user encountering a locked-up system. We
received a surprising number of reports of people encountering this
issue in the past several weeks and that's only going to get worse as
4.4 works its way into distros. Integrating back even just to 4.4
instead of 3.19 would be appreciated since this issue has (so far)
only ever been encountered with the new Intuos tablets that were added
in 4.4...

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
