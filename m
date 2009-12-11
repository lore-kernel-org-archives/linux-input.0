From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Thu, 10 Dec 2009 16:19:22 -0800
Message-ID: <20091211001922.GF23717@core.coreip.homeip.net>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr> <20091209231516.GF10138@core.coreip.homeip.net> <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr> <20091210182844.GC23717@core.coreip.homeip.net> <20091211000318.GE13607@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35709 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420AbZLKATU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 19:19:20 -0500
Received: by pzk1 with SMTP id 1so300374pzk.33
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 16:19:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091211000318.GE13607@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>

On Fri, Dec 11, 2009 at 10:03:18AM +1000, Peter Hutterer wrote:
> On Thu, Dec 10, 2009 at 10:28:44AM -0800, Dmitry Torokhov wrote:
> > On Thu, Dec 10, 2009 at 08:37:39AM +0100, St=E9phane Chatty wrote:
> > >
> > > Le 10 d=E9c. 09 =E0 00:15, Dmitry Torokhov a =E9crit :
> > >
> > >> Hi Stephane,
> > >>
> > >> On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
> > >>> +
> > >>> +	if (emulate_touchscreen) {
> > >>> +		if (sd->first) {
> > >>> +			if (!sd->activity) {
> > >>> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
> > >>> +				sd->activity =3D 1;
> > >>> +			}
> > >>> +			input_event(input, EV_ABS, ABS_X, sd->x);
> > >>> +			input_event(input, EV_ABS, ABS_Y, sd->y);
> > >>> +		}
> > >>> +	}
> > >>
> > >> Why are you doing the above conditionally? Just report it always=
 - =20
> > >> less
> > >> setup required for the user.
> > >
> > > As regards setup, the emulate_touchscreen parameter is 1 by defau=
lt so=20
> > > that users don't have to care about it. But I felt compelled to h=
ave this=20
> > > parameter because the ongoing work on X.org suggests that there m=
ight be=20
> > > a problem in upper layers with having duplicate information flows=
=2E For=20
> > > instant, if we associate a slave pointer (MPX terminology) to eve=
ry=20
> > > ABS_MT_X/ABS_MT_Y flow, the ABS_X/ABS_Y will come as an additiona=
l flow=20
> > > and we'll need to do something to ignore it. Benjamin, Peter, wha=
t do you=20
> > > think?
> >=20
> > I thought Henrik's idea was that driver should use either classic o=
r
> > multitouch events from the data stream but not both. This way users
> > could either use old, non-multitouch-aware drivers or newer ones wi=
thout
> > issues.
>=20
> are we talking about kernel drivers or userspace drivers here?
>=20
> not handling ABS_MT_X, ABS_MT_Y properly in evdev is a bug (well,
> not-yet-implemented feature) but if the kernel hands out both ABS_X a=
nd
> ABS_MT_X that makes it difficult to determine which event is a valid =
one and
> which one can be ignored.
>=20

No, it is pretty simple - all events are valid, otherwise it is kernel
driver bug. Now, as userspace consumer, if you know how to handle
multitouch protocol then use it, ignore ABS_X/ABS_Y. Otherwise you'd be
dropping ABS_MT_* events and naturally handling ABS_X/ABS_Y.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
