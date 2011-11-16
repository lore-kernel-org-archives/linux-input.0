From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Wed, 16 Nov 2011 19:28:35 +0100
Message-ID: <201111161928.36994.heiko@sntech.de>
References: <201110211043.47742.heiko@sntech.de> <201111161202.08131.heiko@sntech.de> <20111116164807.GA19305@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:35330 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752552Ab1KPS2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 13:28:42 -0500
In-Reply-To: <20111116164807.GA19305@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Am Mittwoch 16 November 2011, 17:48:07 schrieb Dmitry Torokhov:
> On Wed, Nov 16, 2011 at 12:02:07PM +0100, Heiko St=FCbner wrote:
> > Hi Dmitry,
> >=20
> > Am Mittwoch 16 November 2011, 08:18:22 schrieb Dmitry Torokhov:
> > > Hi Heiko,
> > >=20
> > > On Fri, Oct 21, 2011 at 10:43:47AM +0200, Heiko St=FCbner wrote:
> > > > There exist tilt switches that simply report their tilt-state v=
ia
> > > > some gpios.
> > > >=20
> > > > The number and orientation of their axes can vary depending on =
the
> > > > switch used and the build of the device. Also two or more one-a=
xis
> > > > switches could be combined to provide multi-dimensional orienta=
tion.
> > > >=20
> > > > One example of a device using such a switch is the family of Qi=
sda
> > > > ebook readers, where the switch provides information about the
> > > > landscape / portrait orientation of the device. The example in
> > > > Documentation/input/gpio-tilt.txt documents exactly this one-ax=
is
> > > > device.
> > >=20
> > > Looks very nice, just a few comments below.
> >=20
> > thanks for your review, comments below
> >=20
> > [...]
> >=20
> > > > +static void gpio_tilt_polled_poll(struct input_polled_dev *dev=
)
> > > > +{
> > > > +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
> > >=20
> > > Call it tdev or tilt or tilt_dev or something? bdev is not very f=
itting
> > > here.
> >=20
> > ok, will change this
> >=20
> > [...]
> >=20
> > > > +static int __devinit gpio_tilt_polled_probe(struct platform_de=
vice
> > > > *pdev) +{
> > > > +	struct gpio_tilt_platform_data *pdata =3D pdev->dev.platform_=
data;
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	struct gpio_tilt_polled_dev *bdev;
> > > > +	struct input_polled_dev *poll_dev;
> > > > +	struct input_dev *input;
> > > > +	int error, i;
> > > > +
> > > > +	if (!pdata || !pdata->poll_interval)
> > > > +		return -EINVAL;
> > > > +
> > > > +	bdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_KER=
NEL);
> > > > +	if (!bdev) {
> > > > +		dev_err(dev, "no memory for private data\n");
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	bdev->gpios =3D kmemdup(pdata->gpios,
> > > > +				 pdata->nr_gpios * sizeof(struct gpio),
> > > > +				 GFP_KERNEL);
> > > > +	if (bdev->gpios =3D=3D NULL) {
> > > > +		dev_err(&pdev->dev, "Failed to allocate gpio data\n");
> > > > +		error =3D -ENOMEM;
> > > > +		goto err_free_bdev;
> > > > +	}
> > > > +	bdev->nr_gpios =3D pdata->nr_gpios;
> > >=20
> > > Do you actually need to do this? Can't you just store the pointer=
 to
> > > the platform data and use it instead? Same goes for the rest of i=
tems
> > > you are cloning.
> >=20
> > As I understand it from previous patches, platform data should be
> > markable as initdata which means the kernel discards it after boot.
> > Therefore it cannot be
>=20
> Absolutely not. Consider what happens if your driver is a module and =
is
> loaded after boot is complete. Or you unload and reload it;
> platform_data has to stay there, it  later must not be marked initdat=
a
> and freed.

I don't claim to grasp every bit the initdata routines do :-) . But I w=
as=20
under the impression that allowing people to make it initdata if necess=
ary and=20
not building stuff as modules was the correct way.

Last time I submitted a regulator patch Mark Brown wrote:

Monday 29 August 2011, 11:18:07 Mark Brown wrote
[...]
> This also fixes the use of platform data after probe - platform data
> should be able to be marked as initdata which may mean that the kerne=
l
> discards it after boot.

The bq24022 driver in question can be build as a module.

And there also seem to exist patches whith the sole purpose of allowing=
=20
platform_data to be initdata if neccessary [1] (the max8903-charger can=
 also=20
be built as module, but its platformdata should not be initdata then).

I'm ok either way, so in the end it's your call on how it should be han=
dled.

Heiko


[1] http://comments.gmane.org/gmane.linux.kernel/1161697
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
