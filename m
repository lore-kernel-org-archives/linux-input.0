From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH] PCAP touchscreen driver (for 2.6.32)
Date: Sun, 28 Jun 2009 14:45:16 -0300
Message-ID: <1246211116.20525.8.camel@brutus>
References: <1246122138.3727.12.camel@brutus>
	 <20090628163542.89473418.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QxUOsqofCotxbyp4k2Dx"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:62947 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbZF1RpV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2009 13:45:21 -0400
In-Reply-To: <20090628163542.89473418.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, openezx-devel <openezx-devel@lists.openezx.org>, linux-kernel <linux-kernel@vger.kernel.org>, Harald Welte <laforge@gnumonks.org>, Samuel Ortiz <sameo@linux.intel.com>


--=-QxUOsqofCotxbyp4k2Dx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Dom, 2009-06-28 =C3=A0s 16:35 +0200, Antonio Ospite escreveu:
> > +	pcap_ts->pcap =3D platform_get_drvdata(pdev);
> > +	platform_set_drvdata(pdev, pcap_ts);
> > +
> > +	input_dev =3D input_allocate_device();
> > +	if (!pcap_ts || !input_dev)
>=20
> Can pcap_ts be ever NULL here? This test can be simplified.

Right, it really can't be NULL. I will fix it.

> > +#ifdef CONFIG_PM
> > +static int pcap_ts_suspend(struct platform_device *pdev, pm_message_t =
state)
> > +{
> > +	struct pcap_ts *pcap_ts =3D platform_get_drvdata(pdev);
> > +
> > +	pcap_set_ts_bits(pcap_ts->pcap, PCAP_ADC_TS_REF_LOWPWR);
> > +	return 0;
> > +}
> > +
> > +static int pcap_ts_resume(struct platform_device *pdev)
> > +{
> > +	struct pcap_ts *pcap_ts =3D platform_get_drvdata(pdev);
> > +
> > +	pcap_set_ts_bits(pcap_ts->pcap,
> > +				pcap_ts->read_state << PCAP_ADC_TS_M_SHIFT);
> > +	return 0;
> > +}
> > +#endif
> > +
>=20
> define the suspend/resume callbacks as NULL in a #else here and remove
> the #ifdef CONFIG_PM below? That seems to be the most used style.
>=20
> > +static struct platform_driver pcap_ts_driver =3D {
> > +	.probe		=3D pcap_ts_probe,
> > +	.remove		=3D __devexit_p(pcap_ts_remove),
> > +#ifdef CONFIG_PM
> > +	.suspend	=3D pcap_ts_suspend,
> > +	.resume		=3D pcap_ts_resume,
> > +#endif
> > +	.driver		=3D {
> > +		.name	=3D "pcap-ts",
> > +		.owner	=3D THIS_MODULE,
> > +	},
> > +};

Ok.

Thanks for the review! :)

--=20
Daniel Ribeiro

--=-QxUOsqofCotxbyp4k2Dx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpHrB0ACgkQw3OYl0G0liSD+wCfX5p2uXlInThTtaGhI6hJ5qwQ
H7cAnjBITYWr0BRHmNGVLWurTM6pga1y
=4MN9
-----END PGP SIGNATURE-----

--=-QxUOsqofCotxbyp4k2Dx--

