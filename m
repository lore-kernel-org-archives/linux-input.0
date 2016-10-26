From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] HID:hid-lg4ff: Delay to allow wheels to center after plug-in
Date: Wed, 26 Oct 2016 10:00:34 -0700
Message-ID: <CAKdAkRQN2Kv7CLrmXzEjfPatgkmzBexzsBYdhzOLjunDTD0APg@mail.gmail.com>
References: <1477445172-2682-1-git-send-email-simon@mungewell.org> <24625977.TfGNBbEdyA@thora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34577 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbcJZRAg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 13:00:36 -0400
In-Reply-To: <24625977.TfGNBbEdyA@thora>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@gmail.com>
Cc: Simon Wood <gitsend@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>

On Wed, Oct 26, 2016 at 12:36 AM, Michal Mal=C3=BD <madcatxster@gmail.com> =
wrote:
> Hi all,
>
> maybe instead of stalling the entire init() function it'd be better to pu=
t a
> request to disable autocentering on a workqueue and start a delayed work =
once
> the init() function is done setting the wheel up? There'd be a bit more c=
ode
> to write though...
>

Yeah, if device happens to be plugged at boot time it will wait that
long before even getting to mount rootfs if driver is built into the
kernel.

This is also interesting way to say "msleep(8000)".

> Michal
>
> On Tuesday, October 25, 2016 7:26:12 PM CEST Simon Wood wrote:
>> A number of wheels (G27/etc) do a little full right/full left 'dance'
>> when first plugged in. This patch inserts a delay so that this 'dance'
>> is completed before we disable (set to zero) the autocenter spring.
>>
>> A side benefit is that the DFGT was confused without the delay, and is
>> now correctly being set to 900' rotation mode.
>>
>> Side Effect - and the reason I am sending as RFC. This 8s delay seems
>> to have an effect on other wheels connected at the same time.
>>
>> With 3 wheels on a hub, and then the hub connected to PC. The wheel
>> on the right in video below waits for G27 to complete this 8s, before
>> it will do it's 'dance' and register with the system.
>>
>> https://www.youtube.com/watch?v=3DxCVpCw_yGgA
>>
>> I don't know if this is a problem, or if someone here has suggestions
>> on a better way to implement the delay...
>> ---
>>  drivers/hid/hid-lg4ff.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
>> index af3a8ec..3eee920 100644
>> --- a/drivers/hid/hid-lg4ff.c
>> +++ b/drivers/hid/hid-lg4ff.c
>> @@ -1248,6 +1248,8 @@ int lg4ff_init(struct hid_device *hid)
>>       /* Check if autocentering is available and
>>        * set the centering force to zero by default */
>>       if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
>> +             wait_queue_head_t wait;
>> +
>>               /* Formula Force EX expects different autocentering comman=
d */
>>               if ((bcdDevice >> 8) =3D=3D LG4FF_FFEX_REV_MAJ &&
>>                   (bcdDevice & 0xff) =3D=3D LG4FF_FFEX_REV_MIN)
>> @@ -1255,6 +1257,14 @@ int lg4ff_init(struct hid_device *hid)
>>               else
>>                       dev->ff->set_autocenter =3D lg4ff_set_autocenter_d=
efault;
>>
>> +             /* insert a 8s delay to allow DFGT/G25/G27/G29 wheels to r=
eturn to
> center
>> position*/ +          if (lg4ff_devices[i].product_id =3D=3D
>> USB_DEVICE_ID_LOGITECH_DFGT_WHEEL || +
> lg4ff_devices[i].product_id =3D=3D
>> USB_DEVICE_ID_LOGITECH_G25_WHEEL || +                         lg4ff_devi=
ces[i].product_id
> =3D=3D
>> USB_DEVICE_ID_LOGITECH_G27_WHEEL || +                         lg4ff_devi=
ces[i].product_id
> =3D=3D
>> USB_DEVICE_ID_LOGITECH_G29_WHEEL) { +                 init_waitqueue_hea=
d (&wait);
>> +                     wait_event_interruptible_timeout(wait, 0, msecs_to=
_jiffies(8000));
>> +             }
>>               dev->ff->set_autocenter(dev, 0);
>>       }
>

Thanks.

--=20
Dmitry
