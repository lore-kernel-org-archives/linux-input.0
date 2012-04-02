From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH RESEND 2/2] Input: uinput: Avoid returning 0 on read()
Date: Mon, 2 Apr 2012 10:35:33 +0200
Message-ID: <CANq1E4TV+mgZXPYL3MnVM-=9GoptmE2eW1uc0+vYC8wQEUdamg@mail.gmail.com>
References: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
	<20120331060033.GA12307@core.coreip.homeip.net>
	<CANq1E4TJ3DPKjx7WBFFJUzLL-pZESYtKL6UadvdYBjE+vm_2uw@mail.gmail.com>
	<20120402074815.GA24313@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53441 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2DBIfe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 04:35:34 -0400
Received: by wibhq7 with SMTP id hq7so2447415wib.1
        for <linux-input@vger.kernel.org>; Mon, 02 Apr 2012 01:35:33 -0700 (PDT)
In-Reply-To: <20120402074815.GA24313@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

Hi Dmitry

On Mon, Apr 2, 2012 at 9:48 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Mar 31, 2012 at 10:39:49AM +0200, David Herrmann wrote:
>> Hi Dmitry
>>
>> On Sat, Mar 31, 2012 at 8:00 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi David,
>> >
>> <snip>
>> > I agree that we should return -EINVAL when buffer is too small. I
>> > however do not like the whole "try_again" business; I think it is
>> > perfectly fine to return 0 for blocking reads, we just want to ret=
urn
>> > -EAGAIN for nonblocking.
>>
>> The read() manpage says that return-code 0 means the fd got closed.
>> Does the VFS layer forward the return-code untouched to user-space o=
r
>> why do you think returning 0 is fine? At least my uinput user-space
>> apps handle read()=3D=3D0 as failure.
>
> Hmm, according to the spec:
>
> http://pubs.opengroup.org/onlinepubs/009695399/functions/read.html
>
> it returns 0 to signal end of file, which does not make sense for
> character devices, only regular files. I think I could also claim
> that returning 0 when an event is "stolen" because "The behavior of
> multiple concurrent reads on the same pipe, FIFO, or terminal device =
is
> unspecified."

You're right. Then my applications didn't adhere to that correctly,
sorry. Anyway, I agree that fixing it to never return 0 does at least
prevent useless context-switches.

> However I do not think that fixing it should be too hard, even taking
> into account the special case of count =3D=3D 0 outlined in the spec.
> Below is the updated versions of the first 2 patches.
>
> Thanks.
>
> --
> Dmitry
>
>
> Input: uinput - return -EINVAL when read buffer size is too small
>
> From: David Herrmann <dh.herrmann@googlemail.com>
>
> Let's check whether the user-supplied buffer is actually big enough a=
nd
> return -EINVAL if it is not. This differs from current behavior, whic=
h
> caused 0 to be returned and actually does not make any sense, as
> broken application will simply repeat the read getting into endless
> loop.
>
> Note that we treat 0 as a special case, according to the standard:
>
> "Before any action described below is taken, and if nbyte is zero,
> the read() function may detect and return errors as described below.
> In the absence of errors, or if error detection is not performed,
> the read() function shall return zero and have no other results."
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Still looks fine. Thanks.

> ---
>
> =A0drivers/input/misc/uinput.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.=
c
> index 7360568..0386064 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -457,6 +457,9 @@ static ssize_t uinput_read(struct file *file, cha=
r __user *buffer, size_t count,
> =A0 =A0 =A0 =A0struct uinput_device *udev =3D file->private_data;
> =A0 =A0 =A0 =A0int retval =3D 0;
>
> + =A0 =A0 =A0 if (count !=3D 0 && count < input_event_size())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0 =A0if (udev->state !=3D UIST_CREATED)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
>
> Input: uinput - fix race that can block nonblocking read
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Consider two threads calling read() on the same uinput-fd, both
> non-blocking. Assume there is data-available so both will simultaneou=
sly
> pass:
> =A0 =A0 =A0 =A0udev->head =3D=3D udev->tail
>
> Then the first thread goes to sleep and the second one pops the messa=
ge
> from the queue. Now assume udev->head =3D=3D udev->tail. If the first=
 thread
> wakes up it will call wait_event_*() and sleep in the waitq. This
> effectively turns the non-blocking FD into a blocking one.
>
> We fix this by attempting to fetch events from the queue first and on=
ly
> if we fail to retrieve any events we either return -EAGAIN (in case o=
f
> non-blocing read) or wait until there are more events.
>
> This also fixes incorrect return code (we were returning 0 instead of
> =A0-EAGAIN for non-blocking reads) when an event is "stolen" by anoth=
er
> thread. Blocking reads will now continue to wait instead of returning=
 0
> in this scenario.
>
> Count of 0 continues to be a special case, as per spec: we will check=
 for
> device existence and whether there are events in the queue, but no ev=
ents
> will be actually retrieved.
>
> Reported-by: David Herrmann <dh.herrmann@googlemail.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Ah, you replaced my goto try_again; with a do/while loop. Looks much
nicer now. Thanks!
I can't see any races anymore so I am fine with it.

Thank you!
David

> ---
>
> =A0drivers/input/misc/uinput.c | =A0 70 +++++++++++++++++++++++++----=
--------------
> =A01 files changed, 41 insertions(+), 29 deletions(-)
>
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.=
c
> index 0386064..75e5502 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -452,45 +452,57 @@ static ssize_t uinput_write(struct file *file, =
const char __user *buffer, size_t
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> -static ssize_t uinput_read(struct file *file, char __user *buffer, s=
ize_t count, loff_t *ppos)
> +static ssize_t uinput_events_to_user(struct uinput_device *udev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0char __user *buffer, size_t count)
> +{
> + =A0 =A0 =A0 size_t read =3D 0;
> + =A0 =A0 =A0 int error =3D 0;
> +
> + =A0 =A0 =A0 while (udev->head !=3D udev->tail &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 read + input_event_size() <=3D count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (input_event_to_user(buffer + read,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &udev->buff[udev->tail])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udev->tail =3D (udev->tail + 1) % UINPU=
T_BUFFER_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 read +=3D input_event_size();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return read ?: error;
> +}
> +
> +static ssize_t uinput_read(struct file *file, char __user *buffer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t count, lo=
ff_t *ppos)
> =A0{
> =A0 =A0 =A0 =A0struct uinput_device *udev =3D file->private_data;
> - =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 ssize_t retval;
>
> =A0 =A0 =A0 =A0if (count !=3D 0 && count < input_event_size())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 if (udev->state !=3D UIST_CREATED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D mutex_lock_interruptible(&ud=
ev->mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>
> - =A0 =A0 =A0 if (udev->head =3D=3D udev->tail && (file->f_flags & O_=
NONBLOCK))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (udev->state !=3D UIST_CREATED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (udev->head =3D=3D udev->tail &=
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(file->f_flags & O_N=
ONBLOCK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D uinput_event=
s_to_user(udev, buffer, count);
>
> - =A0 =A0 =A0 retval =3D wait_event_interruptible(udev->waitq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udev->head !=3D udev->t=
ail || udev->state !=3D UIST_CREATED);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&udev->mutex);
>
> - =A0 =A0 =A0 retval =3D mutex_lock_interruptible(&udev->mutex);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> -
> - =A0 =A0 =A0 if (udev->state !=3D UIST_CREATED) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 while (udev->head !=3D udev->tail && retval + input_eve=
nt_size() <=3D count) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (input_event_to_user(buffer + retval=
, &udev->buff[udev->tail])) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EFAULT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udev->tail =3D (udev->tail + 1) % UINPU=
T_BUFFER_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval +=3D input_event_size();
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>
> - out:
> - =A0 =A0 =A0 mutex_unlock(&udev->mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D wait_event_interruptible(ude=
v->waitq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udev->head !=3D udev->tail ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udev->state !=3D UIST_CREATED);
> + =A0 =A0 =A0 } while (retval =3D=3D 0);
>
> =A0 =A0 =A0 =A0return retval;
> =A0}
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
