From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 1/2] input: gpio_keys_polled: Convert to devm-* API
Date: Tue, 29 Apr 2014 08:50:32 -0700
Message-ID: <20140429155031.GB15055@core.coreip.homeip.net>
References: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
 <20140429032600.GD7672@core.coreip.homeip.net>
 <1398746628.261956573@f341.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64893 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbaD2Puq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Apr 2014 11:50:46 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so373401pdj.38
        for <linux-input@vger.kernel.org>; Tue, 29 Apr 2014 08:50:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398746628.261956573@f341.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

On Tue, Apr 29, 2014 at 08:43:48AM +0400, Alexander Shiyan wrote:
> Mon, 28 Apr 2014 20:26:00 -0700 =D0=BE=D1=82 Dmitry Torokhov <dmitry.=
torokhov@gmail.com>:
> > Hi Alexander,
> >=20
> > On Sat, Apr 26, 2014 at 09:53:13AM +0400, Alexander Shiyan wrote:
> > > Replace existing resource handling in the driver with managed
> > > device resource, this ensures more consistent error values and
> > > simplifies error paths.
> > > kzalloc -> devm_kzalloc
> > > gpio_request_one -> devm_gpio_request_one
> > >=20
> >=20
> > If we are doing the conversion can we go all the Alexanderway (need=
s the
> > other 2 patches I just posted and CCed you)?
> >=20
> > Thanks.
> >=20
> > --=20
> > Dmitry
> >=20
> > Input: gpio_keys_polled - convert to devm-* API
> >=20
> > From: Alexander Shiyan <shc_work@mail.ru>
> >=20
> > Replace existing resource handling in the driver with managed devic=
e
> > resources, this ensures more consistent error values and simplifies=
 error
> > handling paths:
> >=20
> > kzalloc -> devm_kzalloc
> > gpio_request_one -> devm_gpio_request_one
> > input_allocate_polled_device -> devm_input_allocate_polled_device
> >=20
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> ...
> > @@ -162,8 +160,7 @@ static struct gpio_keys_platform_data *gpio_key=
s_polled_get_devtree_pdata(struct
> >  		if (of_property_read_u32(pp, "linux,code", &button->code)) {
> >  			dev_err(dev, "Button without keycode: 0x%x\n",
> >  				button->gpio);
> > -			error =3D -EINVAL;
> > -			goto err_free_pdata;
> > +			return ERR_PTR(-EINVAL);
> >  		}
>=20
> We can even use return value from of_property_read_u32() on error.
>=20
> All other looks OK.

Do you have hardware that uses gpio_keys_polled?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
