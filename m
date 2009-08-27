From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Thu, 27 Aug 2009 13:15:12 -0700
Message-ID: <20090827204731.14035526EC9@mailhub.coreip.homeip.net>
References: <20090827045710.2d8a7010@pedra.chehab.org> <20090827183636.GG26702@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090827183636.GG26702@sci.fi>
Sender: linux-media-owner@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 27, 2009 at 09:36:36PM +0300, Ville Syrj=E4l=E4 wrote:
> On Thu, Aug 27, 2009 at 04:57:10AM -0300, Mauro Carvalho Chehab wrote=
:
> > After years of analyzing the existing code and receiving/merging pa=
tches
> > related to IR, and taking a looking at the current scenario, it is =
clear to me
> > that something need to be done, in order to have some standard way =
to map and
> > to give precise key meanings for each used media keycode found on
> > include/linux/input.h.
> >=20
> > Just as an example, I've parsed the bigger keymap file we have
> > (linux/media/common/ir-common.c). Most IR's have less than 40 keys,=
 most are
> > common between several different models. Yet, we've got almost 500 =
different
> > mappings there (and I removed from my parser all the "obvious" keys=
 that there
> > weren't any comment about what is labeled for that key on the IR).
> >=20
> > The same key name is mapped differently, depending only at the wish=
 of the
> > patch author, as shown at:
> >=20
> > 	http://linuxtv.org/wiki/index.php/Ir-common.c
> >=20
> > It doesn't come by surprise, but currently, almost all media player
> > applications don't care to properly map all those keys.
> >=20
> > I've tried to find comments and/or descriptions about each media ke=
ys defined
> > at input.h without success. Just a few keys are commented at the fi=
le itself.
> > (or maybe I've just seek them at the wrong places).
> >=20
> > So, I took the initiative of doing a proposition for standardizing =
those keys
> > at:
> >=20
> > 	http://linuxtv.org/wiki/index.php/Proposal
>=20
> I welcome this effort. It would be nice to have some kind of consiste=
nt
> behaviour between devices. But just limiting the effort to IR devices
> doesn't make sense. It shouldn't matter how the device is connected.
>=20
> FASTWORWARD,REWIND,FORWARD and BACK aren't very clear. To me it would
> make most sense if FASTFORWARD and REWIND were paired and FORWARD and
> BACK were paired. I actually have those two a bit confused in
> ati_remote2 too where I used FASTFORWARD and BACK. I suppose it shoul=
d
> be REWIND instead.
>=20
> Also I should probably use ZOOM for the maximize/restore button (it's
> FRONT now), and maybe SETUP instead of ENTER for another. It has a
> picture of a checkbox, Windows software apparently shows a setup menu
> when it's pressed.
>=20
> There are also a couple of buttons where no keycode really seems to
> match. One is the mouse button drag. I suppose I could implement the
> drag lock feature in the driver but I'm not sure if that's a good ide=
a.
> It would make that button special and unmappable. Currently I have th=
at
> mapped to EDIT IIRC.

Unmappable keys should probably emit KEY_UNKNOWN. When I last talked
with Richard Hughes there was an idea that userspace may detect
KEY_UNKNOWN and alert user that key needs to be mapped since it lacks
standard assignment. EV_MSC/MSC_SCAN was supposed to aid in fuguring ou=
t
what key it was so that usersoace can issue proper EVIOCSKEYCODE...

>=20
> The other oddball button has a picture of a stopwatch (I think, it's
> not very clear). Currently it uses COFFEE, but maybe TIMER or somethi=
ng
> like that should be added. The Windows software's manual just say it
> toggles TV-on-demand, but I have no idea what that actually is.
>=20

I'd start by looking at HID usage tables and borrowing [missing]
definitions from there. Patches commenting on intended use of input
keycodes are always welcome.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
