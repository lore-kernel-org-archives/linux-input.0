From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] Input: serio_raw - ensure we don't block in non-blocking read
Date: Fri, 13 Apr 2012 18:50:22 +0200
Message-ID: <CANq1E4TOG0wgzJ43px74204k9KgRWpDxRPJhC45BiAERTcwsxg@mail.gmail.com>
References: <20120403202432.GA18564@core.coreip.homeip.net>
	<20120411072300.GA15759@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51420 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab2DMQuY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 12:50:24 -0400
In-Reply-To: <20120411072300.GA15759@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Che-Liang Chiou <clchiou@chromium.org>, linux-kernel@vger.kernel.org

Hi Dmitry

On Wed, Apr 11, 2012 at 9:23 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Apr 03, 2012 at 01:24:33PM -0700, Dmitry Torokhov wrote:
>> Avoid calling wait_event_interruptible() if client requested non-blo=
cking
>> read, since it is not guaranteed that another thread will not consum=
e
>> event after we checked if serio_raw->head !=3D serio_raw->tail.
>>
>> Also ensure we do not return 0 but keep waiting instead in blocking =
case,
>> when another thread steals "our" byte.
>>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>
> Anyone? It would be nice if someone could review my patches as well,
> otherwise we may end up with breakages...

I cannot test the driver as I don't have the devices, but I reviewed
it and it looks fine.

> Thanks.

Regards
David

>> ---
>> =A0drivers/input/serio/serio_raw.c | =A0 43 ++++++++++++++++++++++--=
--------------
>> =A01 files changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/s=
erio_raw.c
>> index 4494233..094d6fb 100644
>> --- a/drivers/input/serio/serio_raw.c
>> +++ b/drivers/input/serio/serio_raw.c
>> @@ -165,31 +165,38 @@ static ssize_t serio_raw_read(struct file *fil=
e, char __user *buffer,
>> =A0 =A0 =A0 struct serio_raw *serio_raw =3D client->serio_raw;
>> =A0 =A0 =A0 char uninitialized_var(c);
>> =A0 =A0 =A0 ssize_t read =3D 0;
>> - =A0 =A0 int retval;
>> + =A0 =A0 int error =3D 0;
>>
>> - =A0 =A0 if (serio_raw->dead)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (serio_raw->dead)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> - =A0 =A0 if (serio_raw->head =3D=3D serio_raw->tail && (file->f_fla=
gs & O_NONBLOCK))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (serio_raw->head =3D=3D serio_raw->tail=
 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (file->f_flags & O_NONBLOCK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>>
>> - =A0 =A0 retval =3D wait_event_interruptible(serio_raw->wait,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_raw->head !=3D serio=
_raw->tail || serio_raw->dead);
>> - =A0 =A0 if (retval)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (count =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 if (serio_raw->dead)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (read < count && serio_raw_fetch_byt=
e(serio_raw, &c)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (put_user(c, buffer++))=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D =
-EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 while (read < count && serio_raw_fetch_byte(serio_raw, &c)=
) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (put_user(c, buffer++)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (read)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 read++;
>> - =A0 =A0 }
>>
>> - =A0 =A0 return read ?: retval;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(file->f_flags & O_NONBLOCK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D wait_event_inter=
ruptible(serio_raw->wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 serio_raw->head !=3D serio_raw->tail ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 serio_raw->dead);
>> + =A0 =A0 } while (!error);
>> +
>> +out:
>> + =A0 =A0 return read ?: error;
>> =A0}
>>
>> =A0static ssize_t serio_raw_write(struct file *file, const char __us=
er *buffer,
>> --
>> 1.7.7.6
>>
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
