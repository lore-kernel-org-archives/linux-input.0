From: Timo Teras <timo.teras@iki.fi>
Subject: Re: [PATCH 2/3] Input: rotary_encoder - fix device tree error
 handling
Date: Mon, 18 Jan 2016 16:00:42 +0200
Message-ID: <20160118160042.5165f9a5@vostro>
References: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
	<1452890030-23316-2-git-send-email-timo.teras@iki.fi>
	<20160116190243.GE9203@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33564 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbcAROAw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 09:00:52 -0500
Received: by mail-lb0-f195.google.com with SMTP id bc4so24486430lbc.0
        for <linux-input@vger.kernel.org>; Mon, 18 Jan 2016 06:00:51 -0800 (PST)
In-Reply-To: <20160116190243.GE9203@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, 16 Jan 2016 11:02:43 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, Jan 15, 2016 at 10:33:49PM +0200, Timo Ter=C3=A4s wrote:
> > of_get_gpio_flags() can fail, so pass through the error code
> > properly. Most important use case is when it returns EPROBE_DEFER
> > so that the probe gets called again later.
> >=20
> > Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
> > ---
> >  drivers/input/misc/rotary_encoder.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/input/misc/rotary_encoder.c
> > b/drivers/input/misc/rotary_encoder.c index 0f23d32..156f40f 100644
> > --- a/drivers/input/misc/rotary_encoder.c
> > +++ b/drivers/input/misc/rotary_encoder.c
> > @@ -206,7 +206,7 @@ static struct rotary_encoder_platform_data
> > *rotary_encoder_parse_dt(struct devic struct device_node *np =3D
> > dev->of_node; struct rotary_encoder_platform_data *pdata;
> >  	enum of_gpio_flags flags;
> > -	int error;
> > +	int ret; =20
>=20
> I strongly prefer variables holding error codes and not being returne=
d
> to caller in success path to be called "error".

Uh. Ok. My preference was on 'ret' or similar as the return value is
used on success path for something useful. But error be it.

> >  	if (!of_id || !np)
> >  		return NULL;
> > @@ -219,19 +219,25 @@ static struct rotary_encoder_platform_data
> > *rotary_encoder_parse_dt(struct devic of_property_read_u32(np,
> > "rotary-encoder,steps", &pdata->steps); of_property_read_u32(np,
> > "linux,axis", &pdata->axis);=20
> > -	pdata->gpio_a =3D of_get_gpio_flags(np, 0, &flags);
> > +	ret =3D of_get_gpio_flags(np, 0, &flags);
> > +	if (ret < 0)
> > +		return ERR_PTR(ret);
> > +	pdata->gpio_a =3D ret; =20
>=20
> Instead of doing this maybe we could switch to gpiod interface that
> handles polarity internally and does not depend on OF? The only issue
> is that we have a few board files in tree that use raw gpio numbers s=
o
> we'll need to convert them...

This is kinda two unrelated things... of course using gpiod_get_array()
would simplify the error path handling and other parts. And as side
effect probably fix the issue at hand too.

The only place where the platform data is used that I found is:
arch/arm/mach-pxa/raumfeld.c

So it should be relatively constrained change.

Could you perhaps also push what you already committed from me (dunno
what you decided with patch #3). If I do gpiod_* conversion, it'll
conflict with the last patch.

Thanks,
Timo
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
