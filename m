From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - correct MSC_SCAN events for force_release
 keys
Date: Thu, 23 Oct 2014 16:44:59 -0700
Message-ID: <20141023234459.GB9463@dtor-ws>
References: <2075303.cGkXBhvpNe@pebbles.site>
 <2149226.863NAkGi8a@pebbles.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38710 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbaJWXpF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 19:45:05 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so2018931pad.39
        for <linux-input@vger.kernel.org>; Thu, 23 Oct 2014 16:45:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2149226.863NAkGi8a@pebbles.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: linux-input@vger.kernel.org

On Sat, Oct 18, 2014 at 12:48:59AM +0200, Stefan Br=FCns wrote:
> On Sunday, September 28, 2014 11:13:24 PM you wrote:
> > Without the change either no scancode would be reported on release
> > of force_release keys, or - if the key is marked as force_release
> > erroneously - the release event and the scancode would be reported
> > in separate reports to the input layer.
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > ---
> >  drivers/input/keyboard/atkbd.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboar=
d/atkbd.c
> > index 2dd1d0d..6375ae6 100644
> > --- a/drivers/input/keyboard/atkbd.c
> > +++ b/drivers/input/keyboard/atkbd.c
> > @@ -456,8 +456,9 @@ static irqreturn_t atkbd_interrupt(struct serio=
 *serio, unsigned char data,
> > =20
> >  	keycode =3D atkbd->keycode[code];
> > =20
> > -	if (keycode !=3D ATKBD_KEY_NULL)
> > -		input_event(dev, EV_MSC, MSC_SCAN, code);
> > +	if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)=
))
> > +		if (keycode !=3D ATKBD_KEY_NULL)
> > +			input_event(dev, EV_MSC, MSC_SCAN, code);
> > =20
> >  	switch (keycode) {
> >  	case ATKBD_KEY_NULL:
> > @@ -511,6 +512,7 @@ static irqreturn_t atkbd_interrupt(struct serio=
 *serio, unsigned char data,
> >  		input_sync(dev);
> > =20
> >  		if (value && test_bit(code, atkbd->force_release_mask)) {
> > +			input_event(dev, EV_MSC, MSC_SCAN, code);
> >  			input_report_key(dev, keycode, 0);
> >  			input_sync(dev);
> >  		}
> >=20
>=20
> Ping!
>=20
> Kind regards,

I do not see the original patch mail, could you please resend (and CC
me)?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
