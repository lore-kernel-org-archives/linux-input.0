From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 9 Jun 2015 10:32:03 -0700
Message-ID: <20150609173203.GG6338@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609131955.GA3045@type>
 <20150609164935.GD6338@dtor-ws>
 <20150609172231.GB4336@type.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f194.google.com ([209.85.223.194]:34080 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbbFIRcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 13:32:09 -0400
Content-Disposition: inline
In-Reply-To: <20150609172231.GB4336@type.youpi.perso.aquilenet.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jun 09, 2015 at 07:22:31PM +0200, Samuel Thibault wrote:
> Dmitry Torokhov, le Tue 09 Jun 2015 09:49:35 -0700, a =E9crit :
> > > > +	[LED_NUML]	=3D { "num-lock", VT_TRIGGER("kbd-numlock") },
> > > > +	[LED_CAPSL]	=3D { "caps-lock", VT_TRIGGER("kbd-capslock") },
> > > > +	[LED_SCROLLL]	=3D { "scroll-lock", VT_TRIGGER("kbd-scrollock"=
) },
> > >=20
> > > I'd tend to think we'd want to harmonize the user-visible LED nam=
es and
> > > kbd trigger names, i.e. use "numlock", "capslock" and "scrollock"=
 in
> > > both case (or something else, but the same for LED and trigger). =
In my
> > > patch I simply used the corresponding LED or kbd macro names, but=
 there
> > > is probably no strong reason to this, while there is probably a g=
ood
> > > reason to choose coherent and nice user-visible names.
> >=20
> > I can do either "num_lock - kbd-num-lock" or "numlock - kbd-numlock=
"
> > with slight preference to the 1st. What is your preference?
>=20
> I'd prefer numlock - kbd-numlock.

OK.

>=20
> > > > +static enum led_brightness input_leds_brightness_get(struct le=
d_classdev *cdev)
> > > > +{
> > > > +	struct input_led *led =3D container_of(cdev, struct input_led=
, cdev);
> > > > +	struct input_dev *input =3D led->handle->dev;
> > > > +
> > > > +	return test_bit(led->code, input->ledbit) ? LED_FULL : LED_OF=
=46;
> > >=20
> > > This always returns LED_FULL, whatever the current state of the L=
ED, is
> > > that really what we want?  Userspace will be surprised to read 25=
5 from
> > > sysfs whatever it writes to it (with actual proper effect on the =
LED).
> >=20
> > Right, I will change it to 0 and led->max_brightness (which I will =
set
> > to 1).
>=20
> Well, that won't fix the issue I'm having, see below.
>=20
> > > Simply not defining input_leds_brightness_get and letting the LED=
 core
> > > manage the value does get a proper "brightness" sysfs file behavi=
or, is
> > > there a reason not to do that?
> >=20
> > Yes, we want LED sysfs show correct result if state is altered via
> > EV_LED/LED_* event. Basically the led bit state is the source of tr=
uth
> > here.
>=20
> Ok, I understand that. But it happens that your code does not work! I=
t
> is always 255 (or will be 1 with the modifications you mention above)=
=2E
> input->ledbit is whether the LED exists or not, not its state, right?
> Did your perhaps mean input->led in input_leds_brightness_get instead=
 of
> input->ledbit?

Yep. I'll change it.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
