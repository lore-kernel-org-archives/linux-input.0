From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 22:38:22 +0200
Message-ID: <20080304203822.GF531@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi> <200803041855.50138.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:35236 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758722AbYCDUiY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 15:38:24 -0500
Content-Disposition: inline
In-Reply-To: <200803041855.50138.linux@dadeos.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stokes <linux@dadeos.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 04, 2008 at 06:55:49PM +0000, Peter Stokes wrote:
> On Tuesday 04 March 2008 12:47:15 Ville Syrj=E4l=E4 wrote:
> > On Sat, Feb 16, 2008 at 04:22:43PM +0000, Peter Stokes wrote:
> > > The attached patch reconfigures the ati_remote2 driver to use
> > > soft-autorepeat functionality and adds support for loadable key m=
aps.
> >
> > Why was this submitted (and even accepted) without cc:ing me?
> >
>=20
> I am very sorry, that was my fault, I should have cc'd you on the ori=
ginal=20
> mail.

Apology accepted. No harm done :)

> > > I have reconfigure the driver to use the input system's built-in
> > > autorepeat functionality as the device only appears to be able to=
 produce
> > > key repeat notifications at a fixed period. Switching to the soft=
ware
> > > autorepeat functionality provides more precise configuration of t=
he
> > > timings requested for repeat-delay and repeat-rate.
> >
> > The soft-autorepeat support should be split into a separate patch. =
I don't
> > need such fast repeat but if it helps people I'm fine with it.
> >
>=20
> My reasoning behind modifying the ati_remote2 driver to use the =20
> soft-autorepeat implementation provided by the core input system was =
based=20
> upon the following:
>=20
> * It states, in section 1.8 of "Documentation/input/input-programming=
=2Etxt",=20
> the following:
>=20
>   1.8 Key autorepeat
>   ~~~~~~~~~~~~~~~~~~
>=20
>   ... is simple. It is handled by the input.c module. Hardware autore=
peat is
>   not used, because it's not present in many devices and even where i=
t is
>   present, it is broken sometimes (at keyboards: Toshiba notebooks). =
To enable
>   autorepeat for your device, just set EV_REP in dev->evbit. All will=
 be
>   handled by the input system.
>=20
> * Using soft-autorepeat provides a more accurate behavior (the initia=
l delay=20
> and the repeat rate behave as configured, as opposed to being rounded=
 up to=20
> the nearest multiple of the hardware's, apparently fixed, repeat=20
> notifications (the hardware based repeat behavior also introduces tim=
ing=20
> aliasing where the actual interval between successive repeats is=20
> inconsistent).
>=20
> * Using soft-autorepeat makes the code in ati_remote2 slightly simple=
r.

Right. I think the only downside is additional timer interrupts to
handle the soft repeat. Probably the effect is too minimal to even
consider.

Dmitry did suggest using soft-repeat when I originally submitted the
driver but I had no need for a faster repeat rate so I didn't change th=
e
driver to use it.

> I am happy to produce a separate patch containing only the changes ne=
cessary=20
> to switch the ati_remote2 driver over to use the soft-autorepeat beha=
vior, if=20
> that is indeed the consensus regarding the best approach to take.

Yes, I'd like one patch per feature.

> As for ensuring that the mouse buttons on this device do not have aut=
o-repeat=20
> behavior applied to them. I was very unsure of my proposed solution, =
as I=20
> attempted to express in my initial email on the subject. It does howe=
ver=20
> strike me that if mouse buttons (and perhaps other button/key codes) =
should=20
> not be auto-repeated then these codes should be excluded from the aut=
o-repeat=20
> implementation within the input core. Experimentation using my Micros=
oft=20
> Internet Keyboard appeared to indicate that regular keys where repeat=
ed but=20
> the extra buttons (things like launch email, launch web browser etc.)=
 are not=20
> (my investigations appeared to indicate, contrary to section 1.8 of t=
he=20
> documentation quoted above, that the repeat behavior was being perfor=
med by=20
> the hardware and not by the input system's soft-autorepeat implementa=
tion).=20
> This behavior appears to approximately coincide with the boundary des=
cribed=20
> by the KEY_MIN_INTERESTING define but I had no idea whether that was =
merely=20
> coincidence.



>=20
> I am happy to implement multiple input devices, one for the mouse, an=
d one for=20
> the keyboard. If my understanding is correct, this would break backwa=
rds=20
> compatibility as the two devices would be exposed by the evdev driver=
 as two=20
> separate event devices?
>=20
> If anyone can suggest the best approach to this problem I would be ha=
ppy to=20
> develop the necessary patches to implement the chosen solution.

Ah, the backwards compatibility angle. It would be rude of us to break
the behaviour like that. It probably wouldn't affect my typical use cas=
e
(MPlayer + DirectFB) since I typically only use the keyboard part of th=
e
remote. But if there are people using both "components" of the remote t=
hey
would have to change their configuration or in the worst case their cod=
e to
handle such a change. Not nice at all.

> > > As this device is exposed as a combined keyboard and mouse, this =
change
> > > somewhat depends upon the suggested modification to the core
> > > soft-autorepeat functionality as outlined in my previous post to =
the
> > > linux-input mailing list (on 12th Feb 2008 entitled "Soft-autorep=
eat
> > > functionality"), without that modification, the mouse buttons are
> > > autorepeated :-(
> > >
> > > The loadable keymap support exposes the ability to map 5 separate
> > > keycodes to each key (depending on which "mode" the remote contro=
l is
> > > currently in). Additionally, I have attempted to ensure that the
> > > scancodes used to map keycodes to the keys lie outside of the ran=
ge
> > > normally covered by regular keyboards so as to avoid requests to =
remap
> > > the keys on the remote from being intercepted by a normal keyboar=
d.
> >
> > I thought the idea of input devices was to reflect the hardware and=
 the
> > keymaps should be handled in userspace. If that's not the case then=
 I think
> > the keymap support code should not be inside the driver but instead=
 inside
> > the input core. We don't want such invasive changes in every driver=
 do
> > we?
>=20
> If I may explain my reasoning behind proposing the changes associated=
 with the=20
> loadable keymap support. I would welcome any feedback on my reasoning=
 and=20
> approach.
>=20
> My initial problem was that some of the keycodes mapped in the ati_re=
mote2=20
> driver have values greater than 255 and as such I am unable to obtain=
 the=20
> input from pressing those keys in X windows (perhaps I'm missing some=
=20
> required configuration of X windows somewhere?). Upon further investi=
gation=20
> into this I noticed that the input core provides a mechanism for alte=
ring the=20
> keymap configuration but the ati_remote2 driver is not compatible wit=
h it.

Ah, the dreaded X angle :) A bit of googling tells me that the X guys
don't have a real fix coming any time soon. I suppose that is one reaso=
n
for having some kind of keymap support in the input core. I personally
don't care for it but there are apprently too few people who can digest
the Xorg code so I suppose it has a compelling reason for existence.

> Initially I simply modified the ati_remote2 to use the mechanism prov=
ided by=20
> the input core. Having done that, it occurred to me that the mode but=
tons of=20
> of the remote could be employed to effectively provide five sets of k=
ey=20
> mappings and I thought that this might be of some use to someone some=
where...
>=20
> I appreciate that the implementation I have suggested is probably not=
 in line=20
> with the original intended functionality of the loadable keymap suppo=
rt in=20
> the input system. But it does get round my issue with X windows....
>=20
> It also occurred to me that perhaps the multiple-keyboards should be =
exposed=20
> as separate input devices, but again, if my understanding is correct,=
 that=20
> would break backwards compatibility.
>=20
> Any suggestions on better approaches would certainly be greatfully re=
lieved.

I think you could implement the multiple keymaps thing rather trivially
in user space by having a small daemon listening on the event device an=
d
loading a new keymap when a mode key is pressed. That would limit the
changes to the driver, and it would not require any kernel changes when
if you would need to adapt it to a device that uses a different driver.

I think the only problem is the grab thingy. I'm not sure if the Xorg=20
evdev driver grabs the device, but if it does then the daemon wouldn't
be able to see the events. DirectFB's input driver does grab the device=
=20
to prevent events leaking to the console (ctrl-c combination was
rather unpleasant without the grab). One solution would be a more
light weight grab that would only prevent the console from receiving th=
e
events but would let other applications to see them. I remeber seeing
some discussion around device grab in the past. I wonder if anything
useful came of it...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
