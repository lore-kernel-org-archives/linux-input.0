From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Thu, 27 Aug 2009 19:03:56 -0300
Message-ID: <20090827190356.6f8ac17b@pedra.chehab.org>
References: <20090827045710.2d8a7010@pedra.chehab.org>
	<20090827183636.GG26702@sci.fi>
	<20090827204731.14035526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47030 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbZH0WEA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2009 18:04:00 -0400
In-Reply-To: <20090827204731.14035526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ville =?ISO-8859-1?B?U3lyauRs5A==?= <syrjala@sci.fi>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

Em Thu, 27 Aug 2009 13:15:12 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> On Thu, Aug 27, 2009 at 09:36:36PM +0300, Ville Syrj=E4l=E4 wrote:
> > On Thu, Aug 27, 2009 at 04:57:10AM -0300, Mauro Carvalho Chehab wro=
te:
> > > After years of analyzing the existing code and receiving/merging =
patches
> > > related to IR, and taking a looking at the current scenario, it i=
s clear to me
> > > that something need to be done, in order to have some standard wa=
y to map and
> > > to give precise key meanings for each used media keycode found on
> > > include/linux/input.h.
> > >=20
> > > Just as an example, I've parsed the bigger keymap file we have
> > > (linux/media/common/ir-common.c). Most IR's have less than 40 key=
s, most are
> > > common between several different models. Yet, we've got almost 50=
0 different
> > > mappings there (and I removed from my parser all the "obvious" ke=
ys that there
> > > weren't any comment about what is labeled for that key on the IR)=
=2E
> > >=20
> > > The same key name is mapped differently, depending only at the wi=
sh of the
> > > patch author, as shown at:
> > >=20
> > > 	http://linuxtv.org/wiki/index.php/Ir-common.c
> > >=20
> > > It doesn't come by surprise, but currently, almost all media play=
er
> > > applications don't care to properly map all those keys.
> > >=20
> > > I've tried to find comments and/or descriptions about each media =
keys defined
> > > at input.h without success. Just a few keys are commented at the =
file itself.
> > > (or maybe I've just seek them at the wrong places).
> > >=20
> > > So, I took the initiative of doing a proposition for standardizin=
g those keys
> > > at:
> > >=20
> > > 	http://linuxtv.org/wiki/index.php/Proposal
> >=20
> > I welcome this effort. It would be nice to have some kind of consis=
tent
> > behaviour between devices. But just limiting the effort to IR devic=
es
> > doesn't make sense. It shouldn't matter how the device is connected=
=2E
> >=20
> > FASTWORWARD,REWIND,FORWARD and BACK aren't very clear. To me it wou=
ld
> > make most sense if FASTFORWARD and REWIND were paired and FORWARD a=
nd
> > BACK were paired. I actually have those two a bit confused in
> > ati_remote2 too where I used FASTFORWARD and BACK. I suppose it sho=
uld
> > be REWIND instead.
> >=20
> > Also I should probably use ZOOM for the maximize/restore button (it=
's
> > FRONT now), and maybe SETUP instead of ENTER for another. It has a
> > picture of a checkbox, Windows software apparently shows a setup me=
nu
> > when it's pressed.
> >=20
> > There are also a couple of buttons where no keycode really seems to
> > match. One is the mouse button drag. I suppose I could implement th=
e
> > drag lock feature in the driver but I'm not sure if that's a good i=
dea.
> > It would make that button special and unmappable. Currently I have =
that
> > mapped to EDIT IIRC.
>=20
> Unmappable keys should probably emit KEY_UNKNOWN. When I last talked
> with Richard Hughes there was an idea that userspace may detect
> KEY_UNKNOWN and alert user that key needs to be mapped since it lacks
> standard assignment. EV_MSC/MSC_SCAN was supposed to aid in fuguring =
out
> what key it was so that usersoace can issue proper EVIOCSKEYCODE...

This seems to be a good idea, for those keys that aren't at rc5 spec.

> >=20
> > The other oddball button has a picture of a stopwatch (I think, it'=
s
> > not very clear). Currently it uses COFFEE, but maybe TIMER or somet=
hing
> > like that should be added. The Windows software's manual just say i=
t
> > toggles TV-on-demand, but I have no idea what that actually is.
> >=20
>=20
> I'd start by looking at HID usage tables and borrowing [missing]
> definitions from there. Patches commenting on intended use of input
> keycodes are always welcome.

After we've agreed on a common base, I'll send a patch documenting the =
keys as
used on IR. It would be good if you could take some time and see if I'm=
 not
abusing of any key at the current proposal[1]. Some of the used keys ma=
y
already be mapped to do something else at kde, gnome or x11.

[1] http://linuxtv.org/wiki/index.php/Proposal



Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
