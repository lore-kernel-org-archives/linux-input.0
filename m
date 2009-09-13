From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [PATCH] Input: bcm5974.c initialize raw_w, raw_x and raw_y
 before it get used
Date: Sun, 13 Sep 2009 14:01:30 +0530
Message-ID: <1252830690.3440.5.camel@ht.satnam>
References: <1252775770.3687.7.camel@ht.satnam>
	 <4AAC2DBE.9040303@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59478 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbZIMIcK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Sep 2009 04:32:10 -0400
In-Reply-To: <4AAC2DBE.9040303@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

On Sun, 2009-09-13 at 01:24 +0200, Henrik Rydberg wrote:
> Jaswinder Singh Rajput wrote:
> > raw_w, raw_x and raw_y is used uninitialized for !raw_n
>=20
> Thanks for the heads up, but actually not, since !raw_n also implies
> !(ptest > PRESSURE_LOW).
>=20

Then can we move 'if (ptest > PRESSURE_LOW && origin)' stuff to 'if
(raw_n)'. If not then my patch is correct.

> > This also fixed these compilation warnings :
> >=20
> >  CC [M]  drivers/input/mouse/bcm5974.o
> > drivers/input/mouse/bcm5974.c: In function =E2=80=98report_tp_state=
=E2=80=99:
> > drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_y=E2=80=99=
 may be used uninitialized in this function
> > drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_x=E2=80=99=
 may be used uninitialized in this function
> > drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_w=E2=80=99=
 may be used uninitialized in this function
> >=20
> > Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> > ---
> >  drivers/input/mouse/bcm5974.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bc=
m5974.c
> > index 2d8fc0b..171f345 100644
> > --- a/drivers/input/mouse/bcm5974.c
> > +++ b/drivers/input/mouse/bcm5974.c
> > @@ -345,7 +345,8 @@ static int report_tp_state(struct bcm5974 *dev,=
 int size)
> >  		/* set the integrated button if applicable */
> >  		if (c->tp_type =3D=3D TYPE2)
> >  			ibt =3D raw2int(dev->tp_data[BUTTON_TYPE2]);
> > -	}
> > +	} else
> > +		raw_w =3D raw_x =3D raw_y =3D 0;
> > =20
> >  	/* while tracking finger still valid, count all fingers */
> >  	if (ptest > PRESSURE_LOW && origin) {
>=20
> I would prefer treating raw_p on the same footing here, completing th=
e set of
> non-obviously initialized variables. It might also make sense to util=
ize the
> same initialization technique already used in the code, thus:
>=20

No, then you are wasting cpu cycles and doing double initialization for
some cases.

> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5=
974.c
> index 2d8fc0b..2f85876 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -316,7 +316,7 @@ static int report_tp_state(struct bcm5974 *dev, i=
nt size)
>  	const struct bcm5974_config *c =3D &dev->cfg;
>  	const struct tp_finger *f;
>  	struct input_dev *input =3D dev->input;
> -	int raw_p, raw_w, raw_x, raw_y, raw_n;
> +	int raw_p =3D 0, raw_w =3D 0, raw_x =3D 0, raw_y =3D 0, raw_n;
>  	int ptest =3D 0, origin =3D 0, ibt =3D 0, nmin =3D 0, nmax =3D 0;
>  	int abs_p =3D 0, abs_w =3D 0, abs_x =3D 0, abs_y =3D 0;
>=20
>=20
> I wonder how many cpu cycles in the world are spent making compilers =
happy.
>=20

It is not compiler mistake it is programming/logic mistakes. We should
be thankful to compiler to pointing mistakes made by us.

Thanks,
--
JSR

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
