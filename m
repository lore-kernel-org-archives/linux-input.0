From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/4] input: evdev: Make device readable only when it
 contains a complete packet.
Date: Mon, 4 Apr 2011 15:46:11 -0700
Message-ID: <20110404224611.GA2783@core.coreip.homeip.net>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
 <1301727259-5185-4-git-send-email-jeffbrown@android.com>
 <20110404213659.GC984@core.coreip.homeip.net>
 <BANLkTi=0q6DbXki5RhE8eakermnVixN67g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=0q6DbXki5RhE8eakermnVixN67g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: rydberg@euromail.se, djkurtz@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 04, 2011 at 03:16:13PM -0700, Jeffrey Brown wrote:
> Hi Dmitry,
> I don't think the new patch is completely correct.
>=20
> On Mon, Apr 4, 2011 at 2:36 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > I think we should target SYN_REPORT directly. SYN_CONFIG is unused =
and
> > SYN_DROPPED is not interesting till next SYN_REPORT anyway. Given t=
he
> > changes to the previous patch I have the following:
>=20
> Explicitly checking for SYN_REPORT makes sense.  I wasn't sure to do
> with SYN_CONFIG before so I tried to keep the condition somewhat
> conservative.
>=20
> Per previous comments on an older iteration of this patch, it probabl=
y
> makes sense to calculate this flag once in evdev_event and pass it to
> evdev_pass_event.
>=20
> bool full_sync =3D (type =3D=3D EV_SYN && code =3D=3D SYN_REPORT);

I am not sure what is cheaper - 2 conditionals or stack manipulation
needed to push another argument if we happed to be register-starved.

>=20
> > @@ -41,6 +41,7 @@ struct evdev {
> > =A0struct evdev_client {
> > =A0 =A0 =A0 =A0unsigned int head;
> > =A0 =A0 =A0 =A0unsigned int tail;
> > + =A0 =A0 =A0 unsigned int last_syn; =A0/* position of the last EV_=
SYN/SYN_REPORT */
>=20
> This comment for last_syn is not quite right.  We need last_syn to
> refer to the position just beyond the last sync.  Otherwise the devic=
e
> will not become readable until another event is written there.  The
> invariants for last_syn should be similar to those for head.

Hm, yes, comment is incorrect. Given this fact I do not like the name
anymore either (nor do I like 'end'). Need to think about something
better.

>=20
> Whereas tail !=3D head means buffer non-empty, tail !=3D last_syn sho=
uld
> mean buffer is readable.
>=20
> It looks like we almost maintain those invariants here, except for SY=
N_DROPPED.
>=20
> > =A0 =A0 =A0 =A0spinlock_t buffer_lock; /* protects access to buffer=
, head and tail */
> > =A0 =A0 =A0 =A0struct fasync_struct *fasync;
> > =A0 =A0 =A0 =A0struct evdev *evdev;
> > @@ -72,12 +73,16 @@ static void evdev_pass_event(struct evdev_clien=
t *client,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0client->buffer[client->tail].type =3D=
 EV_SYN;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0client->buffer[client->tail].code =3D=
 SYN_DROPPED;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0client->buffer[client->tail].value =3D=
 0;
> > +
>=20
> Should use client->head here so that the SYN_DROPPED is readable.

It is readable, but we do not want to signal on it.

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->last_syn =3D client->tail;
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0spin_unlock(&client->buffer_lock);
>=20
> Can use full_sync or something equivalent instead of repeating the
> condition on EV_SYN / SYN_REPORT here.
>=20
> > - =A0 =A0 =A0 if (event->type =3D=3D EV_SYN)
> > + =A0 =A0 =A0 if (event->type =3D=3D EV_SYN && event->code =3D=3D S=
YN_REPORT) {
>=20
> I don't think it's safe to modify last_syn outside of the spin lock.
> This should be done above.

This is the only writer, plus we are running under event_lock with
interrupts off, so it is safe.

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->last_syn =3D client->head;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kill_fasync(&client->fasync, SIGIO, =
POLL_IN);
> > + =A0 =A0 =A0 }
> > =A0}
>=20
> MISSING: We need to also modify evdev_event to only call
> wake_up_interruptible when enqueuing a sync.  It does not make sense
> to wake up waiters unless the device is about to become readable
> again.

Right, I'll add it.

>=20
> This also means we should wake after having written SYN_DROPPED.  We
> might need to make evdev_pass_event return (or take by reference) a
> boolean that indicates whether at least one client has become
> readable.

Why? Why would we not want to wait till the next SYNC to deliver
DROPPED?

>=20
> Pseudo-code:
>=20
> if (full_sync || evdev_became_readable_for_a_client_due_to_syn_droppe=
d)
>     wake_up_interruptible(&evdev->wait);
>=20
> > =A0/*
> > @@ -387,12 +392,12 @@ static ssize_t evdev_read(struct file *file, =
char __user *buffer,
> > =A0 =A0 =A0 =A0if (count < input_event_size())
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> > - =A0 =A0 =A0 if (client->head =3D=3D client->tail && evdev->exist =
&&
> > + =A0 =A0 =A0 if (client->last_syn =3D=3D client->tail && evdev->ex=
ist &&
> > =A0 =A0 =A0 =A0 =A0 =A0(file->f_flags & O_NONBLOCK))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EAGAIN;
> >
> > =A0 =A0 =A0 =A0retval =3D wait_event_interruptible(evdev->wait,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->head !=3D client->tail || !ev=
dev->exist);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->last_syn !=3D client->tail ||=
 !evdev->exist);
> > =A0 =A0 =A0 =A0if (retval)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return retval;
> >
> > @@ -421,7 +426,7 @@ static unsigned int evdev_poll(struct file *fil=
e, poll_table *wait)
> > =A0 =A0 =A0 =A0poll_wait(file, &evdev->wait, wait);
> >
> > =A0 =A0 =A0 =A0mask =3D evdev->exist ? POLLOUT | POLLWRNORM : POLLH=
UP | POLLERR;
> > - =A0 =A0 =A0 if (client->head !=3D client->tail)
> > + =A0 =A0 =A0 if (client->last_syn !=3D client->tail)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mask |=3D POLLIN | POLLRDNORM;
> >
> > =A0 =A0 =A0 =A0return mask;
>=20
> It looks to me like this patch isn't based on top of your previous
> patch for SYN_DROPPED.  Specifically, the SYN_DROPPED should be
> inserted before the newly enqueued event but I don't see that above.

Yes it does - please check the chunk for evdevPass_event again.

--=20
Dmitry
