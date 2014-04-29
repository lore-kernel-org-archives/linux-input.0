From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 1/2] input: gpio_keys_polled: Convert to devm-* API
Date: Tue, 29 Apr 2014 09:36:49 -0700
Message-ID: <20140429163649.GB15953@core.coreip.homeip.net>
References: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
 <1398787420.62147449@f297.i.mail.ru>
 <20140429161926.GA15953@core.coreip.homeip.net>
 <1398788659.619286286@f204.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35525 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155AbaD2Qg6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Apr 2014 12:36:58 -0400
Received: by mail-pd0-f174.google.com with SMTP id z10so432037pdj.33
        for <linux-input@vger.kernel.org>; Tue, 29 Apr 2014 09:36:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398788659.619286286@f204.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

On Tue, Apr 29, 2014 at 08:24:19PM +0400, Alexander Shiyan wrote:
> Tue, 29 Apr 2014 09:19:27 -0700 =D0=BE=D1=82 Dmitry Torokhov <dmitry.=
torokhov@gmail.com>:
> > On Tue, Apr 29, 2014 at 08:03:40PM +0400, Alexander Shiyan wrote:
> > > Tue, 29 Apr 2014 08:50:32 -0700 =D0=BE=D1=82 Dmitry Torokhov <dmi=
try.torokhov@gmail.com>:
> > > > On Tue, Apr 29, 2014 at 08:43:48AM +0400, Alexander Shiyan wrot=
e:
> > > > > Mon, 28 Apr 2014 20:26:00 -0700 =D0=BE=D1=82 Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
> > > > > > Hi Alexander,
> > > > > >=20
> > > > > > On Sat, Apr 26, 2014 at 09:53:13AM +0400, Alexander Shiyan =
wrote:
> > > > > > > Replace existing resource handling in the driver with man=
aged
> > > > > > > device resource, this ensures more consistent error value=
s and
> > > > > > > simplifies error paths.
> > > > > > > kzalloc -> devm_kzalloc
> > > > > > > gpio_request_one -> devm_gpio_request_one
> > > ...
> > > > > > @@ -162,8 +160,7 @@ static struct gpio_keys_platform_data *=
gpio_keys_polled_get_devtree_pdata(struct
> > > > > >  		if (of_property_read_u32(pp, "linux,code", &button->code=
)) {
> > > > > >  			dev_err(dev, "Button without keycode: 0x%x\n",
> > > > > >  				button->gpio);
> > > > > > -			error =3D -EINVAL;
> > > > > > -			goto err_free_pdata;
> > > > > > +			return ERR_PTR(-EINVAL);
> > > > > >  		}
> > > > >=20
> > > > > We can even use return value from of_property_read_u32() on e=
rror.
> > > > >=20
> > > > > All other looks OK.
> > > >=20
> > > > Do you have hardware that uses gpio_keys_polled?
> > >=20
> > > Yes.
> >=20
> > So did you have a chance to actually try my version(s)? I would fee=
l
> > much better if you had ;)
>=20
> Unfortunately, due to the large following weekends, I cannot do it ea=
rlier
> than 2 weeks.

That is fine, there is no rush.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
