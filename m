From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] input: tegra-kbc: add NULL check on of_match_device()
 return value
Date: Fri, 7 Jul 2017 11:30:41 +0200
Message-ID: <20170707093041.GC15652@ulmo.fritz.box>
References: <20170707062758.GA17584@embeddedgus>
 <ec9b399b-ad14-21eb-9a2e-649f0dd1d489@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36612 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdGGJap (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Jul 2017 05:30:45 -0400
Content-Disposition: inline
In-Reply-To: <ec9b399b-ad14-21eb-9a2e-649f0dd1d489@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 08:42:32AM +0100, Jon Hunter wrote:
>=20
> On 07/07/17 07:27, Gustavo A. R. Silva wrote:
> > Check return value from call to of_match_device()
> > in order to prevent a NULL pointer dereference.
> >=20
> > In case of NULL print error message and return -ENODEV
> >=20
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> > ---
> >  drivers/input/keyboard/tegra-kbc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboar=
d/tegra-kbc.c
> > index 0c07e10..742c5ac 100644
> > --- a/drivers/input/keyboard/tegra-kbc.c
> > +++ b/drivers/input/keyboard/tegra-kbc.c
> > @@ -617,6 +617,10 @@ static int tegra_kbc_probe(struct platform_device =
*pdev)
> >  	const struct of_device_id *match;
> > =20
> >  	match =3D of_match_device(tegra_kbc_of_match, &pdev->dev);
> > +	if (!match) {
> > +		dev_err(&pdev->dev, "failed to match device\n");
> > +		return -ENODEV;
> > +	}
>=20
> Given that Tegra always uses device-tree, I believe that this cannot
> happen and so this additional check is not needed.

I think you can make it happen if you manually create the platform
device with a name matching that of the driver. But you really shouldn't
be doing that, so might as well let it crash and burn so that people
realize their mistake early.

Errors are easily overlooked, crashes are not.

Thierry

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAllfVMAACgkQ3SOs138+
s6HPlQ//V+n0Gg44rZD6xNHx6cUAroHhMD9Cu8mQYgzxBaGLf2O9FinXBVRnRYke
shWby7xuse/IdvorbU8zUMNCzFIaIPtm8zS095NQIypp0TmYr7v+Jx8b9KzlP/sQ
2ny1dBnIMnMrFtVXtzG7cb/v67S8yHVbmuW9RCDxRXJUoIsC7sQCTTZpvBEnNRMI
c/4g7G7FeY17oxJBnsAQZp4L2suCW+iVoCCfNqqXTRVmRnAfDJs56VuQhB5Sikvh
Xkrc4i0KnVA9NiVGREHJEVQ4RGe2n3aGMB1/II4RpSvtOZMk1eF6d34qLxKCf0Kx
S/I6ADy0/Yxq3ajzdMLKV+1WjYeOVoUTiYgr2S4XGpEBPZQAai1yA3xK5nucx7aI
CPa1gldE2a+H5xQtfIHoX7N/E0GeEnfaO6EeLJF7GNiHYS6cgLnKrjqwuXi8Sc84
h7NR//SWbQ7odsbvIPm1NARbnSM77CrsALRfnv0y/7EM10mBDtxBq9r/Nl90yYAU
2PtsaDrToddFXncrjldnTHX4Y4BX1berGwZkMfREGGNcuExJaiVo5N+slWhiQagB
R0wFXU9QWPMNcUagZbUQiJq5WTnYhmUlsyXi32sH5cxFykFKGVGtY+EYymL/zRuD
51wfijVbKddncB+LAMGZ2HsHKZhD13yZTK9kzFXeL0YhRXIjDWI=
=WYh6
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
