From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Wed, 16 Nov 2011 08:48:07 -0800
Message-ID: <20111116164807.GA19305@core.coreip.homeip.net>
References: <201110211043.47742.heiko@sntech.de>
 <20111116071822.GA19407@core.coreip.homeip.net>
 <201111161202.08131.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53982 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab1KPQsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 11:48:22 -0500
Received: by pzk36 with SMTP id 36so19319509pzk.1
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 08:48:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201111161202.08131.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 12:02:07PM +0100, Heiko St=FCbner wrote:
> Hi Dmitry,
>=20
> Am Mittwoch 16 November 2011, 08:18:22 schrieb Dmitry Torokhov:
> > Hi Heiko,
> >=20
> > On Fri, Oct 21, 2011 at 10:43:47AM +0200, Heiko St=FCbner wrote:
> > > There exist tilt switches that simply report their tilt-state via=
 some
> > > gpios.
> > >=20
> > > The number and orientation of their axes can vary depending on th=
e switch
> > > used and the build of the device. Also two or more one-axis switc=
hes
> > > could be combined to provide multi-dimensional orientation.
> > >=20
> > > One example of a device using such a switch is the family of Qisd=
a
> > > ebook readers, where the switch provides information about the
> > > landscape / portrait orientation of the device. The example in
> > > Documentation/input/gpio-tilt.txt documents exactly this one-axis=
 device.
> >=20
> > Looks very nice, just a few comments below.
> thanks for your review, comments below
>=20
> [...]
>=20
> > > +static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
> > > +{
> > > +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
> >=20
> > Call it tdev or tilt or tilt_dev or something? bdev is not very fit=
ting
> > here.
> ok, will change this
>=20
> [...]
>=20
> > > +static int __devinit gpio_tilt_polled_probe(struct platform_devi=
ce
> > > *pdev) +{
> > > +	struct gpio_tilt_platform_data *pdata =3D pdev->dev.platform_da=
ta;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct gpio_tilt_polled_dev *bdev;
> > > +	struct input_polled_dev *poll_dev;
> > > +	struct input_dev *input;
> > > +	int error, i;
> > > +
> > > +	if (!pdata || !pdata->poll_interval)
> > > +		return -EINVAL;
> > > +
> > > +	bdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_KERNE=
L);
> > > +	if (!bdev) {
> > > +		dev_err(dev, "no memory for private data\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	bdev->gpios =3D kmemdup(pdata->gpios,
> > > +				 pdata->nr_gpios * sizeof(struct gpio),
> > > +				 GFP_KERNEL);
> > > +	if (bdev->gpios =3D=3D NULL) {
> > > +		dev_err(&pdev->dev, "Failed to allocate gpio data\n");
> > > +		error =3D -ENOMEM;
> > > +		goto err_free_bdev;
> > > +	}
> > > +	bdev->nr_gpios =3D pdata->nr_gpios;
> >=20
> > Do you actually need to do this? Can't you just store the pointer t=
o
> > the platform data and use it instead? Same goes for the rest of ite=
ms
> > you are cloning.
>=20
> As I understand it from previous patches, platform data should be mar=
kable as=20
> initdata which means the kernel discards it after boot. Therefore it =
cannot be=20

Absolutely not. Consider what happens if your driver is a module and is
loaded after boot is complete. Or you unload and reload it;
platform_data has to stay there, it  later must not be marked initdata
and freed.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
