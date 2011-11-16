From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Wed, 16 Nov 2011 11:18:00 -0800
Message-ID: <20111116191800.GA26812@core.coreip.homeip.net>
References: <201110211043.47742.heiko@sntech.de>
 <201111161202.08131.heiko@sntech.de>
 <20111116164807.GA19305@core.coreip.homeip.net>
 <201111161928.36994.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46451 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab1KPTSL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 14:18:11 -0500
Received: by ywt32 with SMTP id 32so48687ywt.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 11:18:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201111161928.36994.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 07:28:35PM +0100, Heiko St=FCbner wrote:
> Am Mittwoch 16 November 2011, 17:48:07 schrieb Dmitry Torokhov:
> > On Wed, Nov 16, 2011 at 12:02:07PM +0100, Heiko St=FCbner wrote:
> > > Hi Dmitry,
> > >=20
> > > Am Mittwoch 16 November 2011, 08:18:22 schrieb Dmitry Torokhov:
> > > > Hi Heiko,
> > > >=20
> > > > On Fri, Oct 21, 2011 at 10:43:47AM +0200, Heiko St=FCbner wrote=
:
> > > > > There exist tilt switches that simply report their tilt-state=
 via
> > > > > some gpios.
> > > > >=20
> > > > > The number and orientation of their axes can vary depending o=
n the
> > > > > switch used and the build of the device. Also two or more one=
-axis
> > > > > switches could be combined to provide multi-dimensional orien=
tation.
> > > > >=20
> > > > > One example of a device using such a switch is the family of =
Qisda
> > > > > ebook readers, where the switch provides information about th=
e
> > > > > landscape / portrait orientation of the device. The example i=
n
> > > > > Documentation/input/gpio-tilt.txt documents exactly this one-=
axis
> > > > > device.
> > > >=20
> > > > Looks very nice, just a few comments below.
> > >=20
> > > thanks for your review, comments below
> > >=20
> > > [...]
> > >=20
> > > > > +static void gpio_tilt_polled_poll(struct input_polled_dev *d=
ev)
> > > > > +{
> > > > > +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
> > > >=20
> > > > Call it tdev or tilt or tilt_dev or something? bdev is not very=
 fitting
> > > > here.
> > >=20
> > > ok, will change this
> > >=20
> > > [...]
> > >=20
> > > > > +static int __devinit gpio_tilt_polled_probe(struct platform_=
device
> > > > > *pdev) +{
> > > > > +	struct gpio_tilt_platform_data *pdata =3D pdev->dev.platfor=
m_data;
> > > > > +	struct device *dev =3D &pdev->dev;
> > > > > +	struct gpio_tilt_polled_dev *bdev;
> > > > > +	struct input_polled_dev *poll_dev;
> > > > > +	struct input_dev *input;
> > > > > +	int error, i;
> > > > > +
> > > > > +	if (!pdata || !pdata->poll_interval)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	bdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_K=
ERNEL);
> > > > > +	if (!bdev) {
> > > > > +		dev_err(dev, "no memory for private data\n");
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > > +
> > > > > +	bdev->gpios =3D kmemdup(pdata->gpios,
> > > > > +				 pdata->nr_gpios * sizeof(struct gpio),
> > > > > +				 GFP_KERNEL);
> > > > > +	if (bdev->gpios =3D=3D NULL) {
> > > > > +		dev_err(&pdev->dev, "Failed to allocate gpio data\n");
> > > > > +		error =3D -ENOMEM;
> > > > > +		goto err_free_bdev;
> > > > > +	}
> > > > > +	bdev->nr_gpios =3D pdata->nr_gpios;
> > > >=20
> > > > Do you actually need to do this? Can't you just store the point=
er to
> > > > the platform data and use it instead? Same goes for the rest of=
 items
> > > > you are cloning.
> > >=20
> > > As I understand it from previous patches, platform data should be
> > > markable as initdata which means the kernel discards it after boo=
t.
> > > Therefore it cannot be
> >=20
> > Absolutely not. Consider what happens if your driver is a module an=
d is
> > loaded after boot is complete. Or you unload and reload it;
> > platform_data has to stay there, it  later must not be marked initd=
ata
> > and freed.
>=20
> I don't claim to grasp every bit the initdata routines do :-) . But I=
 was=20
> under the impression that allowing people to make it initdata if nece=
ssary and=20
> not building stuff as modules was the correct way.

Huh? Forcing non-modular build is "the correct way"?

>=20
> Last time I submitted a regulator patch Mark Brown wrote:
>=20
> Monday 29 August 2011, 11:18:07 Mark Brown wrote
> [...]
> > This also fixes the use of platform data after probe - platform dat=
a
> > should be able to be marked as initdata which may mean that the ker=
nel
> > discards it after boot.
>=20
> The bq24022 driver in question can be build as a module.
>=20

Quoting Russell King "That's totally buggered, and that's putting it
kindly.":

http://www.spinics.net/lists/linux-input/msg16335.html

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
