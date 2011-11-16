From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] Add generic GPIO-tilt driver
Date: Wed, 16 Nov 2011 12:02:07 +0100
Message-ID: <201111161202.08131.heiko@sntech.de>
References: <201110211043.47742.heiko@sntech.de> <20111116071822.GA19407@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:51490 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab1KPLCL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 06:02:11 -0500
In-Reply-To: <20111116071822.GA19407@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Am Mittwoch 16 November 2011, 08:18:22 schrieb Dmitry Torokhov:
> Hi Heiko,
>=20
> On Fri, Oct 21, 2011 at 10:43:47AM +0200, Heiko St=FCbner wrote:
> > There exist tilt switches that simply report their tilt-state via s=
ome
> > gpios.
> >=20
> > The number and orientation of their axes can vary depending on the =
switch
> > used and the build of the device. Also two or more one-axis switche=
s
> > could be combined to provide multi-dimensional orientation.
> >=20
> > One example of a device using such a switch is the family of Qisda
> > ebook readers, where the switch provides information about the
> > landscape / portrait orientation of the device. The example in
> > Documentation/input/gpio-tilt.txt documents exactly this one-axis d=
evice.
>=20
> Looks very nice, just a few comments below.
thanks for your review, comments below

[...]

> > +static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
> > +{
> > +	struct gpio_tilt_polled_dev *bdev =3D dev->private;
>=20
> Call it tdev or tilt or tilt_dev or something? bdev is not very fitti=
ng
> here.
ok, will change this

[...]

> > +static int __devinit gpio_tilt_polled_probe(struct platform_device
> > *pdev) +{
> > +	struct gpio_tilt_platform_data *pdata =3D pdev->dev.platform_data=
;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct gpio_tilt_polled_dev *bdev;
> > +	struct input_polled_dev *poll_dev;
> > +	struct input_dev *input;
> > +	int error, i;
> > +
> > +	if (!pdata || !pdata->poll_interval)
> > +		return -EINVAL;
> > +
> > +	bdev =3D kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_KERNEL)=
;
> > +	if (!bdev) {
> > +		dev_err(dev, "no memory for private data\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	bdev->gpios =3D kmemdup(pdata->gpios,
> > +				 pdata->nr_gpios * sizeof(struct gpio),
> > +				 GFP_KERNEL);
> > +	if (bdev->gpios =3D=3D NULL) {
> > +		dev_err(&pdev->dev, "Failed to allocate gpio data\n");
> > +		error =3D -ENOMEM;
> > +		goto err_free_bdev;
> > +	}
> > +	bdev->nr_gpios =3D pdata->nr_gpios;
>=20
> Do you actually need to do this? Can't you just store the pointer to
> the platform data and use it instead? Same goes for the rest of items
> you are cloning.

As I understand it from previous patches, platform data should be marka=
ble as=20
initdata which means the kernel discards it after boot. Therefore it ca=
nnot be=20
used directly in the drivers after probe and necessary informations mus=
t be=20
copied.

[...]

> > +	/* report initial state of the buttons */
> > +	bdev->last_state =3D -1;
> > +	bdev->count =3D bdev->threshold;
> > +	gpio_tilt_polled_poll(poll_dev);
>=20
> This should probably be in gpio_tilt_polled_open().
ok

Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
