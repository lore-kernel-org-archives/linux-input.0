From: Peter Stokes <linux@dadeos.co.uk>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 18:55:49 +0000
Message-ID: <200803041855.50138.linux@dadeos.co.uk>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.freeserve.com ([193.252.22.152]:16723 "EHLO
	smtp5.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648AbYCDSzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Mar 2008 13:55:55 -0500
In-Reply-To: <20080304124715.GK8473@sci.fi>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tuesday 04 March 2008 12:47:15 Ville Syrj=E4l=E4 wrote:
> On Sat, Feb 16, 2008 at 04:22:43PM +0000, Peter Stokes wrote:
> > The attached patch reconfigures the ati_remote2 driver to use
> > soft-autorepeat functionality and adds support for loadable key map=
s.
>
> Why was this submitted (and even accepted) without cc:ing me?
>

I am very sorry, that was my fault, I should have cc'd you on the origi=
nal=20
mail.

> > I have reconfigure the driver to use the input system's built-in
> > autorepeat functionality as the device only appears to be able to p=
roduce
> > key repeat notifications at a fixed period. Switching to the softwa=
re
> > autorepeat functionality provides more precise configuration of the
> > timings requested for repeat-delay and repeat-rate.
>
> The soft-autorepeat support should be split into a separate patch. I =
don't
> need such fast repeat but if it helps people I'm fine with it.
>

My reasoning behind modifying the ati_remote2 driver to use the =20
soft-autorepeat implementation provided by the core input system was ba=
sed=20
upon the following:

* It states, in section 1.8 of "Documentation/input/input-programming.t=
xt",=20
the following:

  1.8 Key autorepeat
  ~~~~~~~~~~~~~~~~~~

  ... is simple. It is handled by the input.c module. Hardware autorepe=
at is
  not used, because it's not present in many devices and even where it =
is
  present, it is broken sometimes (at keyboards: Toshiba notebooks). To=
 enable
  autorepeat for your device, just set EV_REP in dev->evbit. All will b=
e
  handled by the input system.

* Using soft-autorepeat provides a more accurate behavior (the initial =
delay=20
and the repeat rate behave as configured, as opposed to being rounded u=
p to=20
the nearest multiple of the hardware's, apparently fixed, repeat=20
notifications (the hardware based repeat behavior also introduces timin=
g=20
aliasing where the actual interval between successive repeats is=20
inconsistent).

* Using soft-autorepeat makes the code in ati_remote2 slightly simpler.

I am happy to produce a separate patch containing only the changes nece=
ssary=20
to switch the ati_remote2 driver over to use the soft-autorepeat behavi=
or, if=20
that is indeed the consensus regarding the best approach to take.

As for ensuring that the mouse buttons on this device do not have auto-=
repeat=20
behavior applied to them. I was very unsure of my proposed solution, as=
 I=20
attempted to express in my initial email on the subject. It does howeve=
r=20
strike me that if mouse buttons (and perhaps other button/key codes) sh=
ould=20
not be auto-repeated then these codes should be excluded from the auto-=
repeat=20
implementation within the input core. Experimentation using my Microsof=
t=20
Internet Keyboard appeared to indicate that regular keys where repeated=
 but=20
the extra buttons (things like launch email, launch web browser etc.) a=
re not=20
(my investigations appeared to indicate, contrary to section 1.8 of the=
=20
documentation quoted above, that the repeat behavior was being performe=
d by=20
the hardware and not by the input system's soft-autorepeat implementati=
on).=20
This behavior appears to approximately coincide with the boundary descr=
ibed=20
by the KEY_MIN_INTERESTING define but I had no idea whether that was me=
rely=20
coincidence.

I am happy to implement multiple input devices, one for the mouse, and =
one for=20
the keyboard. If my understanding is correct, this would break backward=
s=20
compatibility as the two devices would be exposed by the evdev driver a=
s two=20
separate event devices?

If anyone can suggest the best approach to this problem I would be happ=
y to=20
develop the necessary patches to implement the chosen solution.
=20

> > As this device is exposed as a combined keyboard and mouse, this ch=
ange
> > somewhat depends upon the suggested modification to the core
> > soft-autorepeat functionality as outlined in my previous post to th=
e
> > linux-input mailing list (on 12th Feb 2008 entitled "Soft-autorepea=
t
> > functionality"), without that modification, the mouse buttons are
> > autorepeated :-(
> >
> > The loadable keymap support exposes the ability to map 5 separate
> > keycodes to each key (depending on which "mode" the remote control =
is
> > currently in). Additionally, I have attempted to ensure that the
> > scancodes used to map keycodes to the keys lie outside of the range
> > normally covered by regular keyboards so as to avoid requests to re=
map
> > the keys on the remote from being intercepted by a normal keyboard.
>
> I thought the idea of input devices was to reflect the hardware and t=
he
> keymaps should be handled in userspace. If that's not the case then I=
 think
> the keymap support code should not be inside the driver but instead i=
nside
> the input core. We don't want such invasive changes in every driver d=
o
> we?

If I may explain my reasoning behind proposing the changes associated w=
ith the=20
loadable keymap support. I would welcome any feedback on my reasoning a=
nd=20
approach.

My initial problem was that some of the keycodes mapped in the ati_remo=
te2=20
driver have values greater than 255 and as such I am unable to obtain t=
he=20
input from pressing those keys in X windows (perhaps I'm missing some=20
required configuration of X windows somewhere?). Upon further investiga=
tion=20
into this I noticed that the input core provides a mechanism for alteri=
ng the=20
keymap configuration but the ati_remote2 driver is not compatible with =
it.

Initially I simply modified the ati_remote2 to use the mechanism provid=
ed by=20
the input core. Having done that, it occurred to me that the mode butto=
ns of=20
of the remote could be employed to effectively provide five sets of key=
=20
mappings and I thought that this might be of some use to someone somewh=
ere...

I appreciate that the implementation I have suggested is probably not i=
n line=20
with the original intended functionality of the loadable keymap support=
 in=20
the input system. But it does get round my issue with X windows....

It also occurred to me that perhaps the multiple-keyboards should be ex=
posed=20
as separate input devices, but again, if my understanding is correct, t=
hat=20
would break backwards compatibility.

Any suggestions on better approaches would certainly be greatfully reli=
eved.

Thank you for taking the time to read my rather long-winded email ;-)

Best regards

Peter Stokes


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
