From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH v2 4/4] input: evdev: Make device readable only when it
 contains a complete packet.
Date: Mon, 4 Apr 2011 15:16:13 -0700
Message-ID: <BANLkTi=0q6DbXki5RhE8eakermnVixN67g@mail.gmail.com>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
 <1301727259-5185-4-git-send-email-jeffbrown@android.com> <20110404213659.GC984@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46028 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1DDWQx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 18:16:53 -0400
In-Reply-To: <20110404213659.GC984@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, djkurtz@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,
I don't think the new patch is completely correct.

On Mon, Apr 4, 2011 at 2:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I think we should target SYN_REPORT directly. SYN_CONFIG is unused an=
d
> SYN_DROPPED is not interesting till next SYN_REPORT anyway. Given the
> changes to the previous patch I have the following:

Explicitly checking for SYN_REPORT makes sense.  I wasn't sure to do
with SYN_CONFIG before so I tried to keep the condition somewhat
conservative.

Per previous comments on an older iteration of this patch, it probably
makes sense to calculate this flag once in evdev_event and pass it to
evdev_pass_event.

bool full_sync =3D (type =3D=3D EV_SYN && code =3D=3D SYN_REPORT);

> @@ -41,6 +41,7 @@ struct evdev {
> =A0struct evdev_client {
> =A0 =A0 =A0 =A0unsigned int head;
> =A0 =A0 =A0 =A0unsigned int tail;
> + =A0 =A0 =A0 unsigned int last_syn; =A0/* position of the last EV_SY=
N/SYN_REPORT */

This comment for last_syn is not quite right.  We need last_syn to
refer to the position just beyond the last sync.  Otherwise the device
will not become readable until another event is written there.  The
invariants for last_syn should be similar to those for head.

Whereas tail !=3D head means buffer non-empty, tail !=3D last_syn shoul=
d
mean buffer is readable.

It looks like we almost maintain those invariants here, except for SYN_=
DROPPED.

> =A0 =A0 =A0 =A0spinlock_t buffer_lock; /* protects access to buffer, =
head and tail */
> =A0 =A0 =A0 =A0struct fasync_struct *fasync;
> =A0 =A0 =A0 =A0struct evdev *evdev;
> @@ -72,12 +73,16 @@ static void evdev_pass_event(struct evdev_client =
*client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0client->buffer[client->tail].type =3D =
EV_SYN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0client->buffer[client->tail].code =3D =
SYN_DROPPED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0client->buffer[client->tail].value =3D=
 0;
> +

Should use client->head here so that the SYN_DROPPED is readable.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->last_syn =3D client->tail;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0spin_unlock(&client->buffer_lock);

Can use full_sync or something equivalent instead of repeating the
condition on EV_SYN / SYN_REPORT here.

> - =A0 =A0 =A0 if (event->type =3D=3D EV_SYN)
> + =A0 =A0 =A0 if (event->type =3D=3D EV_SYN && event->code =3D=3D SYN=
_REPORT) {

I don't think it's safe to modify last_syn outside of the spin lock.
This should be done above.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->last_syn =3D client->head;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kill_fasync(&client->fasync, SIGIO, PO=
LL_IN);
> + =A0 =A0 =A0 }
> =A0}

MISSING: We need to also modify evdev_event to only call
wake_up_interruptible when enqueuing a sync.  It does not make sense
to wake up waiters unless the device is about to become readable
again.

This also means we should wake after having written SYN_DROPPED.  We
might need to make evdev_pass_event return (or take by reference) a
boolean that indicates whether at least one client has become
readable.

Pseudo-code:

if (full_sync || evdev_became_readable_for_a_client_due_to_syn_dropped)
    wake_up_interruptible(&evdev->wait);

> =A0/*
> @@ -387,12 +392,12 @@ static ssize_t evdev_read(struct file *file, ch=
ar __user *buffer,
> =A0 =A0 =A0 =A0if (count < input_event_size())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> - =A0 =A0 =A0 if (client->head =3D=3D client->tail && evdev->exist &&
> + =A0 =A0 =A0 if (client->last_syn =3D=3D client->tail && evdev->exis=
t &&
> =A0 =A0 =A0 =A0 =A0 =A0(file->f_flags & O_NONBLOCK))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EAGAIN;
>
> =A0 =A0 =A0 =A0retval =3D wait_event_interruptible(evdev->wait,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->head !=3D client->tail || !evde=
v->exist);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->last_syn !=3D client->tail || !=
evdev->exist);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return retval;
>
> @@ -421,7 +426,7 @@ static unsigned int evdev_poll(struct file *file,=
 poll_table *wait)
> =A0 =A0 =A0 =A0poll_wait(file, &evdev->wait, wait);
>
> =A0 =A0 =A0 =A0mask =3D evdev->exist ? POLLOUT | POLLWRNORM : POLLHUP=
 | POLLERR;
> - =A0 =A0 =A0 if (client->head !=3D client->tail)
> + =A0 =A0 =A0 if (client->last_syn !=3D client->tail)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mask |=3D POLLIN | POLLRDNORM;
>
> =A0 =A0 =A0 =A0return mask;

It looks to me like this patch isn't based on top of your previous
patch for SYN_DROPPED.  Specifically, the SYN_DROPPED should be
inserted before the newly enqueued event but I don't see that above.

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
