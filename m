From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] Input: uinput: Fix race condition on read()
Date: Mon, 26 Mar 2012 22:28:08 +0200
Message-ID: <CANq1E4ROfdbR3apD1=RwqxKza823aJ=o9DrPpAdBqJDnuKk33Q@mail.gmail.com>
References: <1331928269-22532-1-git-send-email-dh.herrmann@googlemail.com>
	<20120319172528.GB4230@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64783 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab2CZU2K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 16:28:10 -0400
Received: by wgbdr13 with SMTP id dr13so4213008wgb.1
        for <linux-input@vger.kernel.org>; Mon, 26 Mar 2012 13:28:09 -0700 (PDT)
In-Reply-To: <20120319172528.GB4230@cathedrallabs.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aristeu Rozanski <aris@cathedrallabs.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Dmitry

On Mon, Mar 19, 2012 at 6:25 PM, Aristeu Rozanski
<aris@cathedrallabs.org> wrote:
> On Fri, Mar 16, 2012 at 09:04:29PM +0100, David Herrmann wrote:
>> Consider two threads calling read() on the same uinput-fd, both
>> non-blocking. Assume there is data-available so both will simultaneo=
usly
>> pass:
>> =A0 =A0 =A0 udev->head =3D=3D udev->tail
>> Then the first thread goes to sleep and the second one pops the mess=
age
>> from the queue. Now assume udev->head =3D=3D udev->tail. If the firs=
t thread
>> wakes up it will call wait_event_*() and sleep in the waitq. This
>> effectively turns the non-blocking FD into a blocking one.
>>
>> We fix this by never calling wait_event_*() for non-blocking FDs hen=
ce we
>> will never sleep in the waitq here.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> =A0drivers/input/misc/uinput.c | =A0 14 ++++++++------
>> =A01 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput=
=2Ec
>> index 7360568..1526814 100644
>> --- a/drivers/input/misc/uinput.c
>> +++ b/drivers/input/misc/uinput.c
>> @@ -460,13 +460,15 @@ static ssize_t uinput_read(struct file *file, =
char __user *buffer, size_t count,
>> =A0 =A0 =A0 if (udev->state !=3D UIST_CREATED)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> - =A0 =A0 if (udev->head =3D=3D udev->tail && (file->f_flags & O_NON=
BLOCK))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> -
>> - =A0 =A0 retval =3D wait_event_interruptible(udev->waitq,
>> + =A0 =A0 if (file->f_flags & O_NONBLOCK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (udev->head =3D=3D udev->tail)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D wait_event_interruptible(udev->=
waitq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udev->head !=3D udev->ta=
il || udev->state !=3D UIST_CREATED);
>> - =A0 =A0 if (retval)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 retval =3D mutex_lock_interruptible(&udev->mutex);
>> =A0 =A0 =A0 if (retval)
> makes sense, patch looks good
> Acked-by: Aristeu Rozanski <aris@ruivo.org>

Ping (and the other uinput fix ;)).

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
