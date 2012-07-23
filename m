From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2 2/2] input: Add support for the Semtech SX8634
 controller
Date: Mon, 23 Jul 2012 22:15:37 +0200
Message-ID: <20120723201537.GA7626@avionic-0098.mockup.avionic-design.de>
References: <1343045927-22063-1-git-send-email-thierry.reding@avionic-design.de>
 <1343045927-22063-2-git-send-email-thierry.reding@avionic-design.de>
 <20120723164816.GA26577@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61990 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab2GWUPm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jul 2012 16:15:42 -0400
Content-Disposition: inline
In-Reply-To: <20120723164816.GA26577@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2012 at 09:48:16AM -0700, Dmitry Torokhov wrote:
> Hi Thierry,
>=20
> On Mon, Jul 23, 2012 at 02:18:47PM +0200, Thierry Reding wrote:
> > +
> > +	if (gpio_is_valid(sx->power_gpio)) {
> > +		err =3D gpio_request(sx->power_gpio, "sx8634 power");
> > +		if (err < 0) {
> > +			dev_err(&client->dev,
> > +				"failed to request power GPIO#%u: %d\n",
> > +				sx->power_gpio, err);
> > +			goto free_input_device;
> > +		}
> > +
> > +		err =3D gpio_direction_output(sx->power_gpio, 1);
> > +		if (err < 0) {
> > +			dev_err(&client->dev, "failed to enable power: %d\n",
> > +				err);
> > +			goto free_power_gpio;
> > +		}
>=20
> I think there is gpio_request_one() that will take care of tehse 2
> calls.

Right, that shortens this by half.

>=20
> > +
> > +		msleep(150);
> > +	}
> > +
> > +	err =3D sx8634_setup(sx, pdata);
> > +	if (err < 0)
> > +		goto free_power_gpio;
> > +
> > +	err =3D sysfs_create_group(&client->dev.kobj, &sx8634_attr_group);
> > +	if (err < 0)
> > +		goto free_power_gpio;
> > +
> > +	err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > +					sx8634_irq, IRQF_ONESHOT, "sx8634",
> > +					sx);
>=20
> Please do not use devm_* interface here as it make the driverr bomb in
> remove() where you unregister input device but keep interrupt handler
> active until after remove() finishes.

Okay, will do. There is devm_free_irq() but I guess it isn't worth the
overhead since the only benefit would be that it simplifies the .probe()
error unwinding a bit.

> > +#ifdef CONFIG_PM_SLEEP
> > +static int sx8634_i2c_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int sx8634_i2c_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(sx8634_i2c_pm, sx8634_i2c_suspend, sx8634_i2c=
_resume);
>=20
> Why are these stubs needed?

They're not, I'll drop them.

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDbDpAAoJEN0jrNd/PrOhFKcP/2hYtiSj/wuUdzIaP5ZgqxZG
qzLghZ9abdZMvg3tcv5ZINafbGX26X2oCHsv+aQOU6c/NZBOmcrbMkj8ULZ4OIY5
8upUn+7PvXVh7JzpzH31EuHuL/HH9/vO8ZE14fVXPcsv+OYZx3lDWIZtqmA5l3LQ
G0zLkjMCLkRsoUBz9TIIE/L3sJXBN4Ej0/e9lK5SmkNn/Mg1CWPB0WxBPf2QCp/V
eLq75gZdf2E38r3tZxu5aTHSqmsgQiqhyBqOTr/kFl+dQFL18DsDQLtN5cRWzoDN
twk+lRI7b1KHYB7/Vkc0pVrL7p0NHX/gI0y7jDZzHfNKGSY1oreUgr5ySX4z3/15
Wg16nmPlDzxX/m+aQXhxVXicsf9b/PCZKKBnpPZqime/OvjWaVsMYrdz60w0l/CO
WCNo7pxlrNIaW2J8eLSIXW1xXOC0Jeh/KuB7frGcV13fp10PKHDfg67NfpGO7Oof
8bgtbYUlQot04b0fBVoSeceR6RD0LZrVoMddQS6ZqFSXmkUAacc1/Oienb91b8bX
JpxGI1x9W9La0n5YE1zy7hBuTiMDZTPrrhvEp4h50GmVK15yT32wlPxTx3zxDdYR
j2m5tw3Ec3WpM20iBB1wTa3ldZzgzr1I6/c7Y98aoysIhUezqoZWuZOE88djUoi7
OhWfEMo0mnrw96bfrNdl
=nAMZ
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
