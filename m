From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv4] mfd: cpcap: implement irq sense helper
Date: Tue, 28 Mar 2017 16:54:15 +0200
Message-ID: <20170328145415.td4xeqxedem5yjen@earth>
References: <20170323142337.4c4d6lnhqtugbb2r@dell>
 <20170324084240.23251-1-sre@kernel.org>
 <20170328102716.gz7agm7kx3gz56jt@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwtv2pqwvr3fitbj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328102716.gz7agm7kx3gz56jt@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--vwtv2pqwvr3fitbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, Mar 28, 2017 at 11:27:16AM +0100, Lee Jones wrote:
> > +int cpcap_sense_virq(struct regmap *regmap, int virq)
> > +{
> > +	struct regmap_irq_chip_data *d =3D irq_get_chip_data(virq);
> > +	int base =3D regmap_irq_chip_get_base(d);
>=20
> What base is this?

This function takes an Linux irq number. That number is a virtual
irq number, which has nothing to do with the hardware. For example
a platform could look like this:

linux irq   device          base   device irq
---------------------------------------------
0-63        SoC             0      0-63
64-127      SoC-GPIO        64     0-63
128-191     CPCAP           128    0-63

For the above example the function would map 128-191 to 0-63 as
used by the device.

> Could it be used to avoid some calculations in cpcap_sense_irq()?

No.

> > +	return cpcap_sense_irq(regmap, virq - base);
> > +}
> > +EXPORT_SYMBOL_GPL(cpcap_sense_virq);

-- Sebastian

--vwtv2pqwvr3fitbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljaeRQACgkQ2O7X88g7
+prBDg/9G49cvEoxpqBzJiuShFcafXY7FOUfajFITNkC9Fc4UXoIpIi0Qom7zyfB
sOQNSD0fnGsVGDKv6vh5mdvsGxSTiFqT2gTpi4Adtz5u0UH559wdoqmu3mI/84zi
M87dcW9Vfi2zNI4kdrY+VPAP1C4j22+IjgRVU4FS6niXSgIsiNZWBEgYV0Dv3CdP
+YjN7IqWn1CNSvQMQAWcki43uJ5MzHJhhR3EUCVEv4hgtl5WpF/YJlyZtQ9ewuZ8
xSkSZ2BovSjTGDRLJBsATEcvauZY7mOU79qWduywT7koHscComvVnCfoJUYZQlr4
zx476/QQaLDjlmf3Lpd8G4sEow28OXZ4CWtSvVnVxN2As6OVNMVgNXyoweqObz2x
wvDikyx+l3zNLVPdn47gPdnhh8tUyJcse0Ms7YNA1c7lKLsho1lMdanDnQ/d49LW
F7qjBDtVpR2DREGfrLQ6FdEPsEB3zCJ48eD4sI17mpH6BUwJY6+U3nxtUpnR0vpR
L0NiTh0KyIi1J7/7FAeLjGC1eWE0imMUfeeXoftCNBX0U+hFUnxjeDJZlxmbURKk
yzvXTRG3JtAIi7PEVdOvmLK5ObKZdD03XwhkCTs4QSLnbMwoTF3HbyCHpS8dPTR5
gCleWgaM9U5TytH4Nt9evtdH05/w9seV6IYOpf+jTYlWJc9vmfI=
=9Mps
-----END PGP SIGNATURE-----

--vwtv2pqwvr3fitbj--
