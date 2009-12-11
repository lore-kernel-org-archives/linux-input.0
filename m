From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Thu, 10 Dec 2009 16:15:56 -0800
Message-ID: <20091211001556.GE23717@core.coreip.homeip.net>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr> <20091209231516.GF10138@core.coreip.homeip.net> <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr> <20091210182844.GC23717@core.coreip.homeip.net> <4B214BCA.5080403@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:59225 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736AbZLKAP4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 19:15:56 -0500
Received: by pxi14 with SMTP id 14so295949pxi.22
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 16:16:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B214BCA.5080403@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>

On Thu, Dec 10, 2009 at 02:28:10PM -0500, Rafi Rubin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 12/10/09 13:28, Dmitry Torokhov wrote:
> > On Thu, Dec 10, 2009 at 08:37:39AM +0100, St=E9phane Chatty wrote:
> >>
> >> Le 10 d=E9c. 09 =E0 00:15, Dmitry Torokhov a =E9crit :
> >>
> >>> Hi Stephane,
> >>>
> >>> On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
> >>>> +
> >>>> +	if (emulate_touchscreen) {
> >>>> +		if (sd->first) {
> >>>> +			if (!sd->activity) {
> >>>> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
> >>>> +				sd->activity =3D 1;
> >>>> +			}
> >>>> +			input_event(input, EV_ABS, ABS_X, sd->x);
> >>>> +			input_event(input, EV_ABS, ABS_Y, sd->y);
> >>>> +		}
> >>>> +	}
> >>>
> >>> Why are you doing the above conditionally? Just report it always =
- =20
> >>> less
> >>> setup required for the user.
> >>
> >> As regards setup, the emulate_touchscreen parameter is 1 by defaul=
t so=20
> >> that users don't have to care about it. But I felt compelled to ha=
ve this=20
> >> parameter because the ongoing work on X.org suggests that there mi=
ght be=20
> >> a problem in upper layers with having duplicate information flows.=
 For=20
> >> instant, if we associate a slave pointer (MPX terminology) to ever=
y=20
> >> ABS_MT_X/ABS_MT_Y flow, the ABS_X/ABS_Y will come as an additional=
 flow=20
> >> and we'll need to do something to ignore it. Benjamin, Peter, what=
 do you=20
> >> think?
> >=20
> > I thought Henrik's idea was that driver should use either classic o=
r
> > multitouch events from the data stream but not both. This way users
> > could either use old, non-multitouch-aware drivers or newer ones wi=
thout
> > issues.
>=20
> How far are we from decent user-space support for multi-touch devices=
?
> If we can expect that to solidify in the near future, perhaps we'd be
> better off migrating away from conventional touchscreen/single point
> digitizer behavior.

I do not think would be wise. World is bigger than X.

>=20
> >>
> >> Also, some devices (especially the N-Trig) do not make it possible=
 to =20
> >> implement a single touch emulation because they have no finger tra=
cking=20
> >> (IDs change over time, you never know which finger to use and the =
cursor=20
> >> would jump from one to the other randomly). Therefore, I did not f=
eel=20
> >> like creating a new "standard" behaviour that will be broken by su=
ch=20
> >> devices.
> >=20
> > If driver can't support something then it smply won't provide such
> > events at all and users that require certain capability will simply
> > ignore devices that don't provide it.
>=20

> In the case of the n-trig digitizer (with the latest firmware), singl=
e
> touch emulation can be reproduced by a relatively simple tracking
> mechanism.  If we're talking about supporting dual mode drivers, woul=
d
> there be much objection to the cost of computation in the kernel
> driver?
>=20

It really depends on the cost, but I don't think there would be much
objection.

> >>
> >> Actually, Rafi Rubin and I have started to discuss the idea of spl=
itting=20
> >> this into two input nodes: a pure multitouch device and a pure sin=
gle=20
> >> touch emulation. I'd like to have feedback on this idea too, even =
if I=20
> >> have no time to work on it yet.
> >=20
> > If you create 2 devices basically supplying the same data then it w=
ill
> > be harder for consumers to select between them and drivers. I.e. if
> > single device transmits entire state then it is easy to write hotpl=
ug
> > policy for say X server (using udev/hal) such as:
> >=20
> > 	- this box always uses evdev for everything, or
> > 	- devices with nultitouch capabilities use new multitouch
> > 	  X driver, the rest use evdev.
> >=20
> > This will be harder if there were 2 "copies" of multitouch devices
> > because we'd have to be able to recognize "siblings" and ignore one=
 or
> > the other.
> >=20
> > Does this make sense?
>
=20
> At the moment, the evdev and wacom drivers (the only two that I've
> used for a digitizer), require specifying which device to use.  I als=
o
> have the memory (and I might just be miss-remembering) that the
> synaptics driver finds an event dev on its own.

I think this is only true in non-hotplug case.  I am running without
xorg.conf at the moment and X input hotplug seems to be working well
properly selecting the drivers and making sure that alps is driven by
Synaptics X driver while all the rest are driven by evdev.

> So as far as I see it
> a single driver should be smart enough to select the device that it
> prefers.

Right, but we are dealing with 2+ drivers. You need to somehow signal
evdev that it should not touch devices whose siblings are driven by
other drivers. But not always since sometimes siblings are to be driven
by different devices (ALPS touchpad is driven by Synaptics, sibling
representing trackpoint is driven legitimately by evdev).

>=20
> If we're worried about a discovery tool identifying both devs and
> assigning appropriate drivers to each, could we not just export names
> that indicate they are in fact the same device and let the tools
> select which to prefer?  It should be trivial for such tools to selec=
t
> sanely.
>=20

Too fragile IMO.

>=20
> That being said, I did at some point have a touchpad that was
> configured such that I got events from both mice and an event dev, an=
d
> it was really annoying.
>

Yep.
=20
> > If there is a concern about too many unused events reaching userspa=
ce -
> > then we need to implement subscription model in evdev where consume=
r can
> > specify list of events it is interested in and have input core deli=
ver
> > only those. I'll take patches ;)
>=20
> While that sounds tempting, it also could introduce a bit of a hazard=
=2E
> Programmer A masks out events he doesn't need, then programmer B
> starts coding up support for more features and is confounded by the
> lack of response, and yet a hexdump of the dev indicates the events
> are streaming.
>=20

I think you are stretching it a bit here. Yes, it is possible but peopl=
e
should really be familiar with the codebase.

>=20
> On that note, how does one convince the input or hid core to emit an
> event when the state hasn't actually changed?  I ran into that when I
> was trying to inject device swaps for interleaved streams of touch an=
d
> pen events.  Clearly I was attacking a symptom and ignoring the real
> problem, but I'm still curious.
>

There isn't. It is a feature - if state did not change there is no
reason to transmit it.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
