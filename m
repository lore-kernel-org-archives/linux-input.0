From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Tue, 08 Dec 2009 15:03:30 +0200
Message-ID: <1260277410.19669.84.camel@localhost>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	 <87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz>
	 <20091208042251.GB11147@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65367 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbZLHNEv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 08:04:51 -0500
In-Reply-To: <20091208042251.GB11147@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2009-12-07 at 20:22 -0800, Dmitry Torokhov wrote:
> On Sun, Dec 06, 2009 at 09:47:04AM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> >=20
> > > But runtime-pm.txt says for example:
> > >=20
> > >     Generally, remote wake-up should be enabled for all input dev=
ices
> > >     put into a low power state at run time.
> > >=20
> > > But in this case the requirement is to suppress input events from=
 a
> > > given device, effectively muting and putting it into low power st=
ate,
> > > even though it's still open by some other parties.  Runtime PM, o=
n the
> > > other hand tries not to interfere with the normal usage of the de=
vice.
> > >=20
> > > Later:
> > >=20
> > > (3) ->runtime_idle() and ->runtime_suspend() can only be executed=
 for a
> > >     device the usage counter of which is equal to zero _and_ [...=
]
> > >=20
> > > which underlines the difference again: the usage counter (defined=
 by
> > > common sense) won't be zero in our case, because the device is
> > > constantly kept open, while we want to mute it, putting it into a=
 low
> > > power state.=20
> > ...
> > > Actually, this could be implemented by the various users cooperat=
ing in
> > > closing the device, letting it go to sleep automatically.  But th=
is
> > > requires strictly cooperating parties and is more complicated tha=
t
> > > flipping some master switch of the device.  We're looking for thi=
s
> > > master switch, before needlessly building our own.
> >=20
> > Please just close the device properly. I do not think we want 100
> > different 'please mute keys A and G', 'please mute middle mouse but=
ton',
> > ... interfaces anywhere near mainline.
> >=20
>=20
> I do not think it is practical to simply close the device, given that
> there may be several applications that have it open. I constantly see
> embedded guys adding custom knobs to the devices allowing them to shu=
t
> off the device when not in use. Kind of runtame PM but user-initiated=
=2E
>=20
> I would really love to have it implemented in the driver core so the
> interface is the same for all drivers (that support this future).
>=20
> > Or just do it as local patch.
>=20
> I also see that gpio-keys is quite different in the sence that it can
> shut off buttons selectively. I fact, at the moment every button can =
be
> considered a separate device... But that would be too much overhead.
>=20
> They could probably split the keys into 2 groups (critical that shoul=
d
> be always active) and not critical, that could be shut off, but I thi=
nk
> they want teh flexibility of controlling this at runtime instead of
> doing it in board data.

I suggested including this into the "abstract input device" model, but
you refuse this. But I still think it is a good idea.

Indeed, if we look at an input device as at something abstract which ha=
s
many keys, why we cannot assume that separate keys can be
enabled/disabled? Just imagine you have a very advanced keybord :-) And
we simply implement an ioctl which enables/disables a specific key. The
generic layers just pass this ioctl down to the lower lever drivers. If
the specific input device or driver support it - fine, if not - it
returns -EINVAL or something like that.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
