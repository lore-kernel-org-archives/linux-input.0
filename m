From: Peter Stokes <linux@dadeos.co.uk>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 21:34:29 +0000
Message-ID: <200803042134.30339.linux@dadeos.co.uk>
References: <200802161622.43223.linux@dadeos.co.uk> <200803041855.50138.linux@dadeos.co.uk> <20080304203822.GF531@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.freeserve.com ([193.252.22.159]:4392 "EHLO
	smtp5.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591AbYCDVeg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Mar 2008 16:34:36 -0500
In-Reply-To: <20080304203822.GF531@sci.fi>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tuesday 04 March 2008 20:38:22 Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 04, 2008 at 06:55:49PM +0000, Peter Stokes wrote:
> > On Tuesday 04 March 2008 12:47:15 Ville Syrj=E4l=E4 wrote:
> > > On Sat, Feb 16, 2008 at 04:22:43PM +0000, Peter Stokes wrote:
> > > > The attached patch reconfigures the ati_remote2 driver to use
> > > > soft-autorepeat functionality and adds support for loadable key=
 maps.
> > >
> > > Why was this submitted (and even accepted) without cc:ing me?
> >
> > I am very sorry, that was my fault, I should have cc'd you on the
> > original mail.
>
> Apology accepted. No harm done :)
>

Thank you :-)

> > > > I have reconfigure the driver to use the input system's built-i=
n
> > > > autorepeat functionality as the device only appears to be able =
to
> > > > produce key repeat notifications at a fixed period. Switching t=
o the
> > > > software autorepeat functionality provides more precise configu=
ration
> > > > of the timings requested for repeat-delay and repeat-rate.
> > >
> > > The soft-autorepeat support should be split into a separate patch=
=2E I
> > > don't need such fast repeat but if it helps people I'm fine with =
it.
> >
> > My reasoning behind modifying the ati_remote2 driver to use the
> > soft-autorepeat implementation provided by the core input system wa=
s
> > based upon the following:
> >
> > * It states, in section 1.8 of
> > "Documentation/input/input-programming.txt", the following:
> >
> >   1.8 Key autorepeat
> >   ~~~~~~~~~~~~~~~~~~
> >
> >   ... is simple. It is handled by the input.c module. Hardware auto=
repeat
> > is not used, because it's not present in many devices and even wher=
e it
> > is present, it is broken sometimes (at keyboards: Toshiba notebooks=
). To
> > enable autorepeat for your device, just set EV_REP in dev->evbit. A=
ll
> > will be handled by the input system.
> >
> > * Using soft-autorepeat provides a more accurate behavior (the init=
ial
> > delay and the repeat rate behave as configured, as opposed to being
> > rounded up to the nearest multiple of the hardware's, apparently fi=
xed,
> > repeat notifications (the hardware based repeat behavior also intro=
duces
> > timing aliasing where the actual interval between successive repeat=
s is
> > inconsistent).
> >
> > * Using soft-autorepeat makes the code in ati_remote2 slightly simp=
ler.
>
> Right. I think the only downside is additional timer interrupts to
> handle the soft repeat. Probably the effect is too minimal to even
> consider.
>
> Dmitry did suggest using soft-repeat when I originally submitted the
> driver but I had no need for a faster repeat rate so I didn't change =
the
> driver to use it.
>
> > I am happy to produce a separate patch containing only the changes
> > necessary to switch the ati_remote2 driver over to use the
> > soft-autorepeat behavior, if that is indeed the consensus regarding=
 the
> > best approach to take.
>
> Yes, I'd like one patch per feature.
>

I'll do that (do need to sort out exactly how to implement it first tho=
ugh)

> > As for ensuring that the mouse buttons on this device do not have
> > auto-repeat behavior applied to them. I was very unsure of my propo=
sed
> > solution, as I attempted to express in my initial email on the subj=
ect.
> > It does however strike me that if mouse buttons (and perhaps other
> > button/key codes) should not be auto-repeated then these codes shou=
ld be
> > excluded from the auto-repeat implementation within the input core.
> > Experimentation using my Microsoft Internet Keyboard appeared to in=
dicate
> > that regular keys where repeated but the extra buttons (things like
> > launch email, launch web browser etc.) are not (my investigations
> > appeared to indicate, contrary to section 1.8 of the documentation =
quoted
> > above, that the repeat behavior was being performed by the hardware=
 and
> > not by the input system's soft-autorepeat implementation). This beh=
avior
> > appears to approximately coincide with the boundary described by th=
e
> > KEY_MIN_INTERESTING define but I had no idea whether that was merel=
y
> > coincidence.
> >
> >
> >
> >
> > I am happy to implement multiple input devices, one for the mouse, =
and
> > one for the keyboard. If my understanding is correct, this would br=
eak
> > backwards compatibility as the two devices would be exposed by the =
evdev
> > driver as two separate event devices?
> >
> > If anyone can suggest the best approach to this problem I would be =
happy
> > to develop the necessary patches to implement the chosen solution.
>
> Ah, the backwards compatibility angle. It would be rude of us to brea=
k
> the behaviour like that. It probably wouldn't affect my typical use c=
ase
> (MPlayer + DirectFB) since I typically only use the keyboard part of =
the
> remote. But if there are people using both "components" of the remote=
 they
> would have to change their configuration or in the worst case their c=
ode to
> handle such a change. Not nice at all.
>

The backwards compatibility wouldn't be a problem for me either (I'm us=
ing X=20
windows and MythTV). I felt that the original choice of keymappings=20
represents the closest match between the images physically printed on t=
he=20
keys and the descriptions contained in the standard keycode defines but=
=20
unfortunately they result in some fairly crucial keys (like 'ok' for ex=
ample)=20
being undetectable in X windows :-(=20

I suspect that that very few people are currently using this driver for=
 this=20
very reason, and upon that entirely unsubstantiated assumption I'd sugg=
est=20
that if it is deemed that the best approach is to expose the mouse and=20
keyboard functionality as two separate devices then that would probably=
 be=20
acceptable?

My personal feeling is that, if mouse buttons (and other keycodes) shou=
ld not=20
be repeated, then they should be excluded from the soft-autorepeat=20
functionality offered by the input core.

> > > > As this device is exposed as a combined keyboard and mouse, thi=
s
> > > > change somewhat depends upon the suggested modification to the =
core
> > > > soft-autorepeat functionality as outlined in my previous post t=
o the
> > > > linux-input mailing list (on 12th Feb 2008 entitled "Soft-autor=
epeat
> > > > functionality"), without that modification, the mouse buttons a=
re
> > > > autorepeated :-(
> > > >
> > > > The loadable keymap support exposes the ability to map 5 separa=
te
> > > > keycodes to each key (depending on which "mode" the remote cont=
rol is
> > > > currently in). Additionally, I have attempted to ensure that th=
e
> > > > scancodes used to map keycodes to the keys lie outside of the r=
ange
> > > > normally covered by regular keyboards so as to avoid requests t=
o
> > > > remap the keys on the remote from being intercepted by a normal
> > > > keyboard.
> > >
> > > I thought the idea of input devices was to reflect the hardware a=
nd the
> > > keymaps should be handled in userspace. If that's not the case th=
en I
> > > think the keymap support code should not be inside the driver but
> > > instead inside the input core. We don't want such invasive change=
s in
> > > every driver do we?
> >
> > If I may explain my reasoning behind proposing the changes associat=
ed
> > with the loadable keymap support. I would welcome any feedback on m=
y
> > reasoning and approach.
> >
> > My initial problem was that some of the keycodes mapped in the
> > ati_remote2 driver have values greater than 255 and as such I am un=
able
> > to obtain the input from pressing those keys in X windows (perhaps =
I'm
> > missing some required configuration of X windows somewhere?). Upon
> > further investigation into this I noticed that the input core provi=
des a
> > mechanism for altering the keymap configuration but the ati_remote2
> > driver is not compatible with it.
>
> Ah, the dreaded X angle :) A bit of googling tells me that the X guys
> don't have a real fix coming any time soon. I suppose that is one rea=
son
> for having some kind of keymap support in the input core. I personall=
y
> don't care for it but there are apprently too few people who can dige=
st
> the Xorg code so I suppose it has a compelling reason for existence.
>
> > Initially I simply modified the ati_remote2 to use the mechanism pr=
ovided
> > by the input core. Having done that, it occurred to me that the mod=
e
> > buttons of of the remote could be employed to effectively provide f=
ive
> > sets of key mappings and I thought that this might be of some use t=
o
> > someone somewhere...
> >
> > I appreciate that the implementation I have suggested is probably n=
ot in
> > line with the original intended functionality of the loadable keyma=
p
> > support in the input system. But it does get round my issue with X
> > windows....
> >
> > It also occurred to me that perhaps the multiple-keyboards should b=
e
> > exposed as separate input devices, but again, if my understanding i=
s
> > correct, that would break backwards compatibility.
> >
> > Any suggestions on better approaches would certainly be greatfully
> > relieved.
>
> I think you could implement the multiple keymaps thing rather trivial=
ly
> in user space by having a small daemon listening on the event device =
and
> loading a new keymap when a mode key is pressed. That would limit the
> changes to the driver, and it would not require any kernel changes wh=
en
> if you would need to adapt it to a device that uses a different drive=
r.
>
> I think the only problem is the grab thingy. I'm not sure if the Xorg
> evdev driver grabs the device, but if it does then the daemon wouldn'=
t
> be able to see the events. DirectFB's input driver does grab the devi=
ce
> to prevent events leaking to the console (ctrl-c combination was
> rather unpleasant without the grab). One solution would be a more
> light weight grab that would only prevent the console from receiving =
the
> events but would let other applications to see them. I remeber seeing
> some discussion around device grab in the past. I wonder if anything
> useful came of it...

When I initially implemented the loadable keymap support using the inpu=
t core=20
built in handling I hit the problem that I wanted to override the keys =
on the=20
remote control (the reason for looking into all of this) but some of th=
e=20
scancode were taken by the standard PS2 keyboard driver. I reasoned tha=
t most=20
people wouldn't want to break their regular keyboard mappings so I then=
=20
implemented my own get/setkeycode functions in order to place the remot=
e's=20
scancodes outside of the normal range produced by regular keyboards. On=
ce I'd=20
had to implement my own versions of those functions it seemed trivial t=
o=20
provide the 'layered' keyboard implementation.

I must confess I don't have an immediate requirement for this functiona=
lity it=20
just seemed an easy and potentially useful thing to provide...

My understanding of the X windows situation is that the X server protoc=
ol only=20
allows a single byte for keycodes,and as the server protocol is an netw=
ork=20
standard it's not a case of changing some code it's a case of changing =
the=20
standard (something that isn't going to happen particularly quickly!). =
Hence=20
this seemed like a reasonable, if not entirely elegant, way around it..=
=2E


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
