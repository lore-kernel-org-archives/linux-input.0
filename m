From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Wed, 16 Nov 2011 12:40:40 -0800
Message-ID: <201111161240.40673.dmitry.torokhov@gmail.com>
References: <201110211043.47742.heiko@sntech.de> <20111116191800.GA26812@core.coreip.homeip.net> <201111162056.44813.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60664 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab1KPUk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 15:40:59 -0500
Received: by iage36 with SMTP id e36so1130762iag.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 12:40:58 -0800 (PST)
In-Reply-To: <201111162056.44813.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

On Wednesday, November 16, 2011 11:56:43 AM Heiko St=FCbner wrote:
> Am Mittwoch 16 November 2011, 20:18:00 schrieben Sie:
> > On Wed, Nov 16, 2011 at 07:28:35PM +0100, Heiko St=FCbner wrote:
> > > Am Mittwoch 16 November 2011, 17:48:07 schrieb Dmitry Torokhov:
> > > > On Wed, Nov 16, 2011 at 12:02:07PM +0100, Heiko St=FCbner wrote=
:
> > > > > Hi Dmitry,
> > > > >=20
> > > > > Am Mittwoch 16 November 2011, 08:18:22 schrieb Dmitry Torokho=
v:
> > > > > > Hi Heiko,
> > > > > >=20
> > > > > > On Fri, Oct 21, 2011 at 10:43:47AM +0200, Heiko St=FCbner w=
rote:
> > > > > > > There exist tilt switches that simply report their
> > > > > > > tilt-state via some gpios.
> > > > > > >=20
> > > > > > > The number and orientation of their axes can vary dependi=
ng
> > > > > > > on the switch used and the build of the device. Also two =
or
> > > > > > > more one-axis switches could be combined to provide
> > > > > > > multi-dimensional orientation.
> > > > > > >=20
> > > > > > > One example of a device using such a switch is the family=
 of
> > > > > > > Qisda ebook readers, where the switch provides informatio=
n
> > > > > > > about the landscape / portrait orientation of the device.
> > > > > > > The example in Documentation/input/gpio-tilt.txt document=
s
> > > > > > > exactly this one-axis device.
> > > > > >=20
> > > > > > Looks very nice, just a few comments below.
> > > > >=20
> > > > > thanks for your review, comments below
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > > +static void gpio_tilt_polled_poll(struct input_polled_de=
v
> > > > > > > *dev) +{
> > > > > > > +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
> > > > > >=20
> > > > > > Call it tdev or tilt or tilt_dev or something? bdev is not
> > > > > > very fitting here.
> > > > >=20
> > > > > ok, will change this
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > > +static int __devinit gpio_tilt_polled_probe(struct
> > > > > > > platform_device *pdev) +{
> > > > > > > +	struct gpio_tilt_platform_data *pdata =3D
> > > > > > > pdev->dev.platform_data; +	struct device *dev =3D &pdev->=
dev;
> > > > > > > +	struct gpio_tilt_polled_dev *bdev;
> > > > > > > +	struct input_polled_dev *poll_dev;
> > > > > > > +	struct input_dev *input;
> > > > > > > +	int error, i;
> > > > > > > +
> > > > > > > +	if (!pdata || !pdata->poll_interval)
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	bdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev),
> > > > > > > GFP_KERNEL); +	if (!bdev) {
> > > > > > > +		dev_err(dev, "no memory for private data\n");
> > > > > > > +		return -ENOMEM;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	bdev->gpios =3D kmemdup(pdata->gpios,
> > > > > > > +				 pdata->nr_gpios * sizeof(struct gpio),
> > > > > > > +				 GFP_KERNEL);
> > > > > > > +	if (bdev->gpios =3D=3D NULL) {
> > > > > > > +		dev_err(&pdev->dev, "Failed to allocate gpio=20
data\n");
> > > > > > > +		error =3D -ENOMEM;
> > > > > > > +		goto err_free_bdev;
> > > > > > > +	}
> > > > > > > +	bdev->nr_gpios =3D pdata->nr_gpios;
> > > > > >=20
> > > > > > Do you actually need to do this? Can't you just store the
> > > > > > pointer to the platform data and use it instead? Same goes
> > > > > > for the rest of items you are cloning.
> > > > >=20
> > > > > As I understand it from previous patches, platform data shoul=
d
> > > > > be markable as initdata which means the kernel discards it
> > > > > after boot. Therefore it cannot be
> > > >=20
> > > > Absolutely not. Consider what happens if your driver is a modul=
e
> > > > and is loaded after boot is complete. Or you unload and reload
> > > > it; platform_data has to stay there, it  later must not be mark=
ed
> > > > initdata and freed.
> > >=20
> > > I don't claim to grasp every bit the initdata routines do :-) . B=
ut
> > > I was under the impression that allowing people to make it initda=
ta
> > > if necessary and not building stuff as modules was the correct wa=
y.
> >=20
> > Huh? Forcing non-modular build is "the correct way"?
> >=20
> > > Last time I submitted a regulator patch Mark Brown wrote:
> > >=20
> > > Monday 29 August 2011, 11:18:07 Mark Brown wrote
> > > [...]
> > >=20
> > > > This also fixes the use of platform data after probe - platform
> > > > data should be able to be marked as initdata which may mean tha=
t
> > > > the kernel discards it after boot.
> > >=20
> > > The bq24022 driver in question can be build as a module.
> >=20
> > Quoting Russell King "That's totally buggered, and that's putting i=
t
> > kindly.":
> >=20
> > http://www.spinics.net/lists/linux-input/msg16335.html
> :
> :-), still strange to see two differing opinions

No, one is just wrong. I guess we need to revert patch you mentioned.
Unless we prohibit modules and hotplug platform data should stay.

>=20
> But I will get rid of the cloned platform data.
>=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
