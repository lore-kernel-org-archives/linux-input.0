From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Fix sudden warps in mousedev
Date: Sun, 25 Mar 2007 11:19:30 -0700
Message-ID: <20070325111930.f6428509.zaitcev@redhat.com>
References: <20070324001610.724a820a.zaitcev@redhat.com>
	<200703250134.03416.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703250134.03416.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, zaitcev@redhat.com
List-Id: linux-input@vger.kernel.org

On Sun, 25 Mar 2007 01:34:02 -0400, Dmitry Torokhov <dtor@insightbb.com> =
wrote:

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Without this, a touchpad may report an unchanged =
position,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * then a sync. The input_event() eats the position =
report, but
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * lets the sync through. We increment pkt_count and=
 leave=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * a stale position in the ring. If a future referen=
ce to fx(2)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * hits the stale position, a large dx is reported, =
and the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * pointer warps across the screen.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev =3D mousedev->handle.dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fx(0) =3D dev->abs[ABS_X];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fy(0) =3D dev->abs[ABS_Y];
>=20
> I do not like input hanlders poking into input devices... Can't we just
> reset pkt_count at the beginning of the touch to get rid of stale data?

The pkt_count is zero at the moment of assignment above.

Please look at the included trace again:

> > Event: time 1174703243.305535, type 1 (Key), code 330 (Touch), value =
1
> >           <---- touch!=3D0 now, we're on
> > Event: time 1174703243.305538, type 3 (Absolute), code 24 (Pressure),=
 value 31
> > Event: time 1174703243.305541, -------------- Report Sync -----------=
-
> >           <---- We increment the pkt_count, leaving value of 3687 in =
old_y
> > Event: time 1174703243.342452, type 3 (Absolute), code 0 (X), value 4=
747
> > Event: time 1174703243.342455, type 3 (Absolute), code 1 (Y), value 1=
988
> >           <----- Later to be fy(1), not used for warping purposes :-)
> > Event: time 1174703243.342459, -------------- Report Sync -----------=
-
> > Event: time 1174703243.356225, type 3 (Absolute), code 0 (X), value 4=
749
> > Event: time 1174703243.356237, type 3 (Absolute), code 1 (Y), value 1=
987
> >           <----- warp here, by the difference of 3687 and 1987, plus
> >                  some small frac_dy value. Easily jumps half the scre=
en.
> > Event: time 1174703243.356246, -------------- Report Sync -----------=
-

The assignment happens at .305535. The pkt_count is zero, and fy(0) conta=
ins
stale data (ovewritten by the assignment). The touchpad reports a positio=
n
next with input_report_abs(). If the position were different, we'd receiv=
e
an event between .305535 and .305538 and it would be stored in fy(0).

However, if position is the same, as in this case, input_report eats it.
At .305541 we increment pkt_count. The fy(0) location becomes fy(1) at
this point. Without the assignment it contains the stale position.

I can explore alternatives, but for now using dev->abs[] seems to be most
expedient.

-- Pete
