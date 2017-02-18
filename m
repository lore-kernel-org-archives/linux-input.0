From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Input: tsc2007 - switch to using input_set_capability()
Date: Sat, 18 Feb 2017 15:58:39 +0100
Message-ID: <6EE891F1-A20E-4AB3-934C-09B35FF7DE30@goldelico.com>
References: <20170217225627.GA27132@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:14703 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdBRO6s (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Feb 2017 09:58:48 -0500
In-Reply-To: <20170217225627.GA27132@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>

Hi Dmitry,

> Am 17.02.2017 um 23:56 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> Do not manipulate evbit/keybit directly, use helper for that.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> drivers/input/touchscreen/tsc2007_core.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/tsc2007_core.c =
b/drivers/input/touchscreen/tsc2007_core.c
> index fdf81a2b989a..98dbefc3357d 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -364,8 +364,7 @@ static int tsc2007_probe(struct i2c_client =
*client,
>=20
> 	input_set_drvdata(input_dev, ts);
>=20
> -	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> -	input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);

basically a good improvement, but removing the BIT_MASK(EV_ABS) makes =
problems
when replacing the next lines

>=20
> 	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, =
0);
> 	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, =
0);

by touchscreen_parse_properties() as done by my patch set.

The problem is that touchscreen_parse_properties() does not call =
input_set_abs_params()
but touchscreen_set_params(). This does not call some =
input_set_capability(dev, EV_ABS, axis)
but rather checks that it has been set before! Hence we only see =
warnings in the log
and no input event properties (BTN_TOUCH works but without position =
information).

So we either must explicitly input_set_capability(dev, EV_ABS, axis) for =
all three
axises or remove the test in touchscreen_set_params and call
input_set_capability(dev, EV_ABS, axis); in the end.

This patch improves the existing driver but breaks my tsc2007 patch set =
in a location
that my patch set does not even touch (touchscreen_set_params).

Scratching my head how to come out of this...

BR and thanks,
Nikolaus

