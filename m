From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 9 Jun 2015 09:49:35 -0700
Message-ID: <20150609164935.GD6338@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609131955.GA3045@type>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:32946 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbbFIQtl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 12:49:41 -0400
Content-Disposition: inline
In-Reply-To: <20150609131955.GA3045@type>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jun 09, 2015 at 03:19:55PM +0200, Samuel Thibault wrote:
> Hello,
>=20
> Dmitry Torokhov, le Mon 08 Jun 2015 14:43:08 -0700, a =E9crit :
> > 1. Instead of making LED class devices part of the input device the=
y are
> > implemented as an input handler (and thus are completely separate f=
rom
> > input core).
>=20
> That's nicer indeed.  Not defining triggers per LED however does not
> permit to e.g. switch two leds of a keyboard independently of what
> produces input events.  I'm personally fine with it, I just wanted to
> mention it since this example of usage was cited at some point in the
> thread.

I might have over-though the issue a bit in the past ;) But I think I a=
m
happy with the current behavior, it separates input events and leds and
just says that you can select what tgrigges led state change. And you
shoudl still be able to do:

echo "kbd-ctrlllock" > /sys/..../input22::caps-lock/trigger
echo "heartbit" > /sys/..../input22::num-lock/trigger
echo "kbd-numlock" > /sys/..../input22::scroll-lock/trigger

But you can't say that pressing CapsLock on keyboard1 should light up
ScrollLock led on keyboard2, nor do we want it I think. If such control
is truly needed userspace can take over and managed leds as it sees fit=
,
like X does.

>=20
> > +	[LED_NUML]	=3D { "num-lock", VT_TRIGGER("kbd-numlock") },
> > +	[LED_CAPSL]	=3D { "caps-lock", VT_TRIGGER("kbd-capslock") },
> > +	[LED_SCROLLL]	=3D { "scroll-lock", VT_TRIGGER("kbd-scrollock") },
>=20
> I'd tend to think we'd want to harmonize the user-visible LED names a=
nd
> kbd trigger names, i.e. use "numlock", "capslock" and "scrollock" in
> both case (or something else, but the same for LED and trigger). In m=
y
> patch I simply used the corresponding LED or kbd macro names, but the=
re
> is probably no strong reason to this, while there is probably a good
> reason to choose coherent and nice user-visible names.

I can do either "num_lock - kbd-num-lock" or "numlock - kbd-numlock"
with slight preference to the 1st. What is your preference?

>=20
> > +static enum led_brightness input_leds_brightness_get(struct led_cl=
assdev *cdev)
> > +{
> > +	struct input_led *led =3D container_of(cdev, struct input_led, cd=
ev);
> > +	struct input_dev *input =3D led->handle->dev;
> > +
> > +	return test_bit(led->code, input->ledbit) ? LED_FULL : LED_OFF;
>=20
> This always returns LED_FULL, whatever the current state of the LED, =
is
> that really what we want?  Userspace will be surprised to read 255 fr=
om
> sysfs whatever it writes to it (with actual proper effect on the LED)=
=2E

Right, I will change it to 0 and led->max_brightness (which I will set
to 1).

> Simply not defining input_leds_brightness_get and letting the LED cor=
e
> manage the value does get a proper "brightness" sysfs file behavior, =
is
> there a reason not to do that?

Yes, we want LED sysfs show correct result if state is altered via
EV_LED/LED_* event. Basically the led bit state is the source of truth
here.

>=20
> > +	int led_no =3D 0;
>=20
> ...
>=20
> > +	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
> > +		struct input_led *led =3D &leds->leds[led_no];
>=20
> When reading this I wondered what value led_no was, perhaps the
> initialization to 0 should be moved to right before the for_each_set_=
bit
> loop, to make the code clearer.

=46air enough, will change.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
