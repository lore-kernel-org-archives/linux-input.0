From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/4] input: evdev: Make device readable only when it
 contains a complete packet.
Date: Tue, 5 Apr 2011 09:38:55 -0700
Message-ID: <20110405163855.GC4183@core.coreip.homeip.net>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
 <1301727259-5185-4-git-send-email-jeffbrown@android.com>
 <20110404213659.GC984@core.coreip.homeip.net>
 <BANLkTi=0q6DbXki5RhE8eakermnVixN67g@mail.gmail.com>
 <20110404224611.GA2783@core.coreip.homeip.net>
 <BANLkTinLcXsZpHm3_uzRUEdrJQsbozgghA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50925 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab1DEQjB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 12:39:01 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinLcXsZpHm3_uzRUEdrJQsbozgghA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: rydberg@euromail.se, djkurtz@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 04, 2011 at 05:34:09PM -0700, Jeffrey Brown wrote:
> Dmitry,
>=20
> On Mon, Apr 4, 2011 at 3:46 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Apr 04, 2011 at 03:16:13PM -0700, Jeffrey Brown wrote:
> >> bool full_sync =3D (type =3D=3D EV_SYN && code =3D=3D SYN_REPORT);
> >
> > I am not sure what is cheaper - 2 conditionals or stack manipulatio=
n
> > needed to push another argument if we happed to be register-starved=
=2E
>=20
> Not a question of the computational cost.  It was mostly done to avoi=
d
> repeating the same predicate in multiple places.  This was one of the
> suggested improvements to my earlier patch.
>=20
> >> This comment for last_syn is not quite right. =A0We need last_syn =
to
> >> refer to the position just beyond the last sync. =A0Otherwise the =
device
> >> will not become readable until another event is written there. =A0=
The
> >> invariants for last_syn should be similar to those for head.
> >
> > Hm, yes, comment is incorrect. Given this fact I do not like the na=
me
> > anymore either (nor do I like 'end'). Need to think about something
> > better.
>=20
> Heh, I faced this very same dilemma.  I tried 'last_sync',
> 'readable_tail', 'read_end', and others before settling on 'end' and =
a
> descriptive comment.

'packet_head' maybe? Similar to the head but for whole event packet?

>=20
> >> Should use client->head here so that the SYN_DROPPED is readable.
> >
> > It is readable, but we do not want to signal on it.
>=20
> I think we do want to signal on it.  We should signal whenever the
> device becomes readable.
>=20
> Signaling on dropped is useful in the case where a misbehaving device
> driver fails to ever call input_sync.  If that happens, we might
> enqueue a dropped event and then never wake up the client which makes
> the issue hard to diagnose.
>=20
> >> I don't think it's safe to modify last_syn outside of the spin loc=
k.
> >> This should be done above.
> >
> > This is the only writer, plus we are running under event_lock with
> > interrupts off, so it is safe.
>=20
> The value will be read concurrently by evdev_fetch_next_event.  So if
> this were safe, then we wouldn't need the spin lock at all.

Before we started changing tail to advance to SYN_DROPPED position we
could probably drop the buffer lock and sprinkle memory barriers (to
ensure, for example, that buffer is written before advancing head).

Now we do need to protect buffer and head/tail but the new field can be
updated outside the lock.

>=20
> At the very least for the sake of consistency, I think we should keep
> the buffer manipulations within the guarded region.
>=20

OK, we can do that too. As I said, we are running with interrupts off
and with even_lock acquired so we can pull update to the new field alon=
g
with kill_fasync inside the buffer lock.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
