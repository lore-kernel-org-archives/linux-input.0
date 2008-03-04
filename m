From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Wed, 5 Mar 2008 00:17:49 +0200
Message-ID: <20080304221749.GH531@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk> <200803041855.50138.linux@dadeos.co.uk> <20080304203822.GF531@sci.fi> <200803042134.30339.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:53193 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756597AbYCDWRv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 17:17:51 -0500
Content-Disposition: inline
In-Reply-To: <200803042134.30339.linux@dadeos.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stokes <linux@dadeos.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Jiri Kosina <jkosina@suse.cz>

On Tue, Mar 04, 2008 at 09:34:29PM +0000, Peter Stokes wrote:
> On Tuesday 04 March 2008 20:38:22 Ville Syrj=E4l=E4 wrote:
> > On Tue, Mar 04, 2008 at 06:55:49PM +0000, Peter Stokes wrote:
> > > I am happy to produce a separate patch containing only the change=
s
> > > necessary to switch the ati_remote2 driver over to use the
> > > soft-autorepeat behavior, if that is indeed the consensus regardi=
ng the
> > > best approach to take.
> >
> > Yes, I'd like one patch per feature.
> >
>=20
> I'll do that (do need to sort out exactly how to implement it first t=
hough)

Right.

> > > As for ensuring that the mouse buttons on this device do not have
> > > auto-repeat behavior applied to them. I was very unsure of my pro=
posed
> > > solution, as I attempted to express in my initial email on the su=
bject.
> > > It does however strike me that if mouse buttons (and perhaps othe=
r
> > > button/key codes) should not be auto-repeated then these codes sh=
ould be
> > > excluded from the auto-repeat implementation within the input cor=
e.
> > > Experimentation using my Microsoft Internet Keyboard appeared to =
indicate
> > > that regular keys where repeated but the extra buttons (things li=
ke
> > > launch email, launch web browser etc.) are not (my investigations
> > > appeared to indicate, contrary to section 1.8 of the documentatio=
n quoted
> > > above, that the repeat behavior was being performed by the hardwa=
re and
> > > not by the input system's soft-autorepeat implementation). This b=
ehavior
> > > appears to approximately coincide with the boundary described by =
the
> > > KEY_MIN_INTERESTING define but I had no idea whether that was mer=
ely
> > > coincidence.
> > >
> > >
> > >
> > >
> > > I am happy to implement multiple input devices, one for the mouse=
, and
> > > one for the keyboard. If my understanding is correct, this would =
break
> > > backwards compatibility as the two devices would be exposed by th=
e evdev
> > > driver as two separate event devices?
> > >
> > > If anyone can suggest the best approach to this problem I would b=
e happy
> > > to develop the necessary patches to implement the chosen solution=
=2E
> >
> > Ah, the backwards compatibility angle. It would be rude of us to br=
eak
> > the behaviour like that. It probably wouldn't affect my typical use=
 case
> > (MPlayer + DirectFB) since I typically only use the keyboard part o=
f the
> > remote. But if there are people using both "components" of the remo=
te they
> > would have to change their configuration or in the worst case their=
 code to
> > handle such a change. Not nice at all.
> >
>=20
> The backwards compatibility wouldn't be a problem for me either (I'm =
using X=20
> windows and MythTV). I felt that the original choice of keymappings=20
> represents the closest match between the images physically printed on=
 the=20
> keys and the descriptions contained in the standard keycode defines b=
ut=20
> unfortunately they result in some fairly crucial keys (like 'ok' for =
example)=20
> being undetectable in X windows :-(=20
>=20
> I suspect that that very few people are currently using this driver f=
or this=20
> very reason, and upon that entirely unsubstantiated assumption I'd su=
ggest=20
> that if it is deemed that the best approach is to expose the mouse an=
d=20
> keyboard functionality as two separate devices then that would probab=
ly be=20
> acceptable?
>=20
> My personal feeling is that, if mouse buttons (and other keycodes) sh=
ould not=20
> be repeated, then they should be excluded from the soft-autorepeat=20
> functionality offered by the input core.

I think that repeating buttons are a good thing in some cases (autofire=
=20
in games for example). Then again such games could implement autofire
themselves.

However I don't see why the repeat vs. no repeat case should depend on
the device reporting or not reporting keyboard keys. I don't see any re=
al
connection with a device having some keyboard keys and sending repeat
events for buttons.

Let's say you have a HID keyboard which does in fact have an integrated
trackball/whatever (at least keyboard with scroll wheels exists so addi=
ng
a complete trackball doesn't seem that far fetched) but instead of havi=
ng
separate end points for each "device" it would just have one endpoint.
That device would experience the same problem that my HID mouse has.

> > I think you could implement the multiple keymaps thing rather trivi=
ally
> > in user space by having a small daemon listening on the event devic=
e and
> > loading a new keymap when a mode key is pressed. That would limit t=
he
> > changes to the driver, and it would not require any kernel changes =
when
> > if you would need to adapt it to a device that uses a different dri=
ver.
> >
> > I think the only problem is the grab thingy. I'm not sure if the Xo=
rg
> > evdev driver grabs the device, but if it does then the daemon would=
n't
> > be able to see the events. DirectFB's input driver does grab the de=
vice
> > to prevent events leaking to the console (ctrl-c combination was
> > rather unpleasant without the grab). One solution would be a more
> > light weight grab that would only prevent the console from receivin=
g the
> > events but would let other applications to see them. I remeber seei=
ng
> > some discussion around device grab in the past. I wonder if anythin=
g
> > useful came of it...
>=20
> When I initially implemented the loadable keymap support using the in=
put core=20
> built in handling I hit the problem that I wanted to override the key=
s on the=20
> remote control (the reason for looking into all of this) but some of =
the=20
> scancode were taken by the standard PS2 keyboard driver. I reasoned t=
hat most=20
> people wouldn't want to break their regular keyboard mappings so I th=
en=20
> implemented my own get/setkeycode functions in order to place the rem=
ote's=20
> scancodes outside of the normal range produced by regular keyboards. =
Once I'd=20
> had to implement my own versions of those functions it seemed trivial=
 to=20
> provide the 'layered' keyboard implementation.
>=20
> I must confess I don't have an immediate requirement for this functio=
nality it=20
> just seemed an easy and potentially useful thing to provide...
>=20
> My understanding of the X windows situation is that the X server prot=
ocol only=20
> allows a single byte for keycodes,and as the server protocol is an ne=
twork=20
> standard it's not a case of changing some code it's a case of changin=
g the=20
> standard (something that isn't going to happen particularly quickly!)=
=2E Hence=20
> this seemed like a reasonable, if not entirely elegant, way around it=
=2E..

http://bugs.freedesktop.org/show_bug.cgi?id=3D11227
has some ideas about compressing the keycodes to the 8-255 range for
each device by using device specific keymaps.

However, since that seems unlikely to happen, and the input core alread=
y
has support for keymaps I'm fine with adding the set/getkeycode stuff.
What I'd like to drop is the support for five different keymaps since
AFAICS that could be handled in a more generic way in user space.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
