From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 1/2] input: gpio_keys_polled: Convert to devm-* API
Date: Mon, 5 May 2014 21:18:18 -0700
Message-ID: <20140506041818.GA32144@core.coreip.homeip.net>
References: <1398491594-2004-1-git-send-email-shc_work@mail.ru>
 <1398788659.619286286@f204.i.mail.ru>
 <20140429163649.GB15953@core.coreip.homeip.net>
 <1398789659.346407871@f204.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61026 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162AbaEFESV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 00:18:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so3483312pad.16
        for <linux-input@vger.kernel.org>; Mon, 05 May 2014 21:18:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398789659.346407871@f204.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org

On Tue, Apr 29, 2014 at 08:40:59PM +0400, Alexander Shiyan wrote:
> Tue, 29 Apr 2014 09:36:49 -0700 =D0=BE=D1=82 Dmitry Torokhov <dmitry.=
torokhov@gmail.com>:
> > On Tue, Apr 29, 2014 at 08:24:19PM +0400, Alexander Shiyan wrote:
> ...
> > > > > > > > On Sat, Apr 26, 2014 at 09:53:13AM +0400, Alexander Shi=
yan wrote:
> > > > > > > > > Replace existing resource handling in the driver with=
 managed
> > > > > > > > > device resource, this ensures more consistent error v=
alues and
> > > > > > > > > simplifies error paths.
> > > > > > > > > kzalloc -> devm_kzalloc
> > > > > > > > > gpio_request_one -> devm_gpio_request_one
> > > > > ...
> > > > > > > > @@ -162,8 +160,7 @@ static struct gpio_keys_platform_da=
ta *gpio_keys_polled_get_devtree_pdata(struct
> > > > > > > >  		if (of_property_read_u32(pp, "linux,code", &button->=
code)) {
> > > > > > > >  			dev_err(dev, "Button without keycode: 0x%x\n",
> > > > > > > >  				button->gpio);
> > > > > > > > -			error =3D -EINVAL;
> > > > > > > > -			goto err_free_pdata;
> > > > > > > > +			return ERR_PTR(-EINVAL);
> > > > > > > >  		}
> > > > > > >=20
> > > > > > > We can even use return value from of_property_read_u32() =
on error.
> > > > > > >=20
> > > > > > > All other looks OK.
> > > > > >=20
> > > > > > Do you have hardware that uses gpio_keys_polled?
> > > > >=20
> > > > > Yes.
> > > >=20
> > > > So did you have a chance to actually try my version(s)? I would=
 feel
> > > > much better if you had ;)
> > >=20
> > > Unfortunately, due to the large following weekends, I cannot do i=
t earlier
> > > than 2 weeks.
> >=20
> > That is fine, there is no rush.
>=20
> OK. In this case it would be nice to have a separate branch with poll=
-series
> and this patch. Can you make it?

I just pushed new input-polldev branch containing input polldev changes
and your patches to gpio-keys and gpio-keys-polled. It is based on 3.14=
=2E

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
