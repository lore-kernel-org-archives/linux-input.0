From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Fri, 11 Dec 2009 10:03:18 +1000
Message-ID: <20091211000318.GE13607@barra.bne.redhat.com>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr>
 <20091209231516.GF10138@core.coreip.homeip.net>
 <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr>
 <20091210182844.GC23717@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:40652 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760493AbZLKAEm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 19:04:42 -0500
Content-Disposition: inline
In-Reply-To: <20091210182844.GC23717@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>

On Thu, Dec 10, 2009 at 10:28:44AM -0800, Dmitry Torokhov wrote:
> On Thu, Dec 10, 2009 at 08:37:39AM +0100, St=E9phane Chatty wrote:
> >
> > Le 10 d=E9c. 09 =E0 00:15, Dmitry Torokhov a =E9crit :
> >
> >> Hi Stephane,
> >>
> >> On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
> >>> +
> >>> +	if (emulate_touchscreen) {
> >>> +		if (sd->first) {
> >>> +			if (!sd->activity) {
> >>> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
> >>> +				sd->activity =3D 1;
> >>> +			}
> >>> +			input_event(input, EV_ABS, ABS_X, sd->x);
> >>> +			input_event(input, EV_ABS, ABS_Y, sd->y);
> >>> +		}
> >>> +	}
> >>
> >> Why are you doing the above conditionally? Just report it always -=
 =20
> >> less
> >> setup required for the user.
> >
> > As regards setup, the emulate_touchscreen parameter is 1 by default=
 so=20
> > that users don't have to care about it. But I felt compelled to hav=
e this=20
> > parameter because the ongoing work on X.org suggests that there mig=
ht be=20
> > a problem in upper layers with having duplicate information flows. =
=46or=20
> > instant, if we associate a slave pointer (MPX terminology) to every=
=20
> > ABS_MT_X/ABS_MT_Y flow, the ABS_X/ABS_Y will come as an additional =
flow=20
> > and we'll need to do something to ignore it. Benjamin, Peter, what =
do you=20
> > think?
>=20
> I thought Henrik's idea was that driver should use either classic or
> multitouch events from the data stream but not both. This way users
> could either use old, non-multitouch-aware drivers or newer ones with=
out
> issues.

are we talking about kernel drivers or userspace drivers here?

not handling ABS_MT_X, ABS_MT_Y properly in evdev is a bug (well,
not-yet-implemented feature) but if the kernel hands out both ABS_X and
ABS_MT_X that makes it difficult to determine which event is a valid on=
e and
which one can be ignored.

> > Actually, Rafi Rubin and I have started to discuss the idea of spli=
tting=20
> > this into two input nodes: a pure multitouch device and a pure sing=
le=20
> > touch emulation. I'd like to have feedback on this idea too, even i=
f I=20
> > have no time to work on it yet.
>=20
> If you create 2 devices basically supplying the same data then it wil=
l
> be harder for consumers to select between them and drivers. I.e. if
> single device transmits entire state then it is easy to write hotplug
> policy for say X server (using udev/hal) such as:
>=20
> 	- this box always uses evdev for everything, or
> 	- devices with nultitouch capabilities use new multitouch
> 	  X driver, the rest use evdev.
>=20
> This will be harder if there were 2 "copies" of multitouch devices
> because we'd have to be able to recognize "siblings" and ignore one o=
r
> the other.

not only that, but it's now quite easy to create devices as-needed with=
in
the X driver and control creation/deletion of these devices as required=
 by
underlying physical device. If the driver does that, it has knowledge o=
f the
other devices it created and thus better control of the features these
provide.

having multiple devices provided by the kernel removes this ability, yo=
u'd
have to manually link them together.

Cheers,
  Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
