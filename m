Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED0286409;
	Tue, 11 Aug 2026 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423598; cv=none; b=g52zOD0w4FmhNGqkftLRmwzD8Mjv0IudGyDSs5D2i6GpbJL+EDBSwk7Yb35hArK0VrP8/g9vFj5W8b2ee2mmaE+kahR/4rRgEcuv21gs7HOSRL4juFsIMFm5wUb81RS6veh4GZGmbzeOWwMcV1h+JvY4XCrv5Y5Mgya06Qpgi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423598; c=relaxed/simple;
	bh=GTkOB2Wxi5hEX2mIwzJTm5d/29Sc42ULzXtp4BpvDVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8DICEqokiDiYz1Un7a6w04BF7njYfOMHaKJ958/8eW7Odgm6vW8542k22exnTqLxQzydptOgyG027WqtePyiFMfV3tTrbK6LiWCI0bDFMKw2YkOSSsO3iRSU2+raaOKyTh6nCiy2oYOhbmei2dM8USdOEYUALobrn0mePoBhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byL5nLN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byL5nLN9"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 159D41F00A3A;
	Tue, 11 Aug 2026 04:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786423596;
	bh=4EpS7VWmzddg2JU4Yq8TnnLax8NwlqEQzTHK2msPp1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byL5nLN9p4uTRnm2l4VJcv6vJJFDdD1y470p25he8zjX+zLqOcTNTWNFI7895S44W
	 z0kimI8da0ixsHibmhCYhKPz+85CaZyZoIZ4AFIuawotNGTLvzruJOmeinclRM7LkD
	 81mN6ZSVI5LiIt0m+g/ZioTmLN9UIGsxIVumWC8xPEkw5BT2i3XICjE90yGsWWzFO6
	 lYxtroWnW88Qgd1mqllkvKjTesm4Z7uH8mTN/im8QxnmV7VECxpBFVQq4SyhXtNElF
	 wL29A1nItWjVMS7BO6XX64WruWPyKNhXYZDE+EZCP2qD+3PFi520bdflVSPRcOjToZ
	 OQT1fbMJjMytg==
Date: Tue, 11 Aug 2026 06:46:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Eliav Farber <farbere@amazon.com>, rafael@kernel.org, 
	tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, lenb@kernel.org, laurent.pinchart@ideasonboard.com, 
	linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 01/13] notifier: add device-managed registration APIs
Message-ID: <anqlfa6UADHn4qbo@monoceros>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-2-farbere@amazon.com>
 <anlUQXtxrghA8kNT@monoceros>
 <anmVwiYW6fT7XhD2@ashevche-desk.local>
 <anmWCWT_p8sIMwyf@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgdaeslknqpb7jv7"
Content-Disposition: inline
In-Reply-To: <anmWCWT_p8sIMwyf@ashevche-desk.local>


--pgdaeslknqpb7jv7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 01/13] notifier: add device-managed registration APIs
MIME-Version: 1.0

Hello Andy,

On Mon, Aug 10, 2026 at 12:12:41PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 12:11:40PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 10, 2026 at 06:37:25AM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Sun, Jul 26, 2026 at 10:17:27AM +0000, Eliav Farber wrote:
>=20
> ...
>=20
> > > > +{
> > > > +	struct atomic_notifier_chain_devres *dr;
> > > > +	int ret;
> > > > +
> > > > +	dr =3D devres_alloc(devm_atomic_notifier_chain_unregister,
> > > > +			  sizeof(*dr), GFP_KERNEL);
> > > > +	if (!dr)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret =3D atomic_notifier_chain_register(nh, n);
> > > > +	if (ret) {
> > > > +		devres_free(dr);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	dr->nh =3D nh;
> > > > +	dr->nb =3D n;
> > > > +	devres_add(dev, dr);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(devm_atomic_notifier_chain_register);
> > >=20
> > > IMHO devm_atomic_notifier_chain_register() should look as follows:
> > >=20
> > > 	ret =3D atomic_notifier_chain_register(nh, n);
> > > 	if (ret)
> > > 		return ret;
> > >=20
> > > 	return devm_add_action_or_reset(dev, devm_atomic_notifier_chain_unre=
gister, dr)
> > >=20
> > > which is much easier and includes less details from the inner workings
> > > of devm. Same for the blocking variant.
> >=20
> > Won't work. We need more than one parameter and hence the whole devres_=
alloc().

Oh indeed, justified concern.

> > Please, look closer to the code.
>=20
> And just answering ahead, no, devm_kmalloc() is not good bandaid as it ma=
kes code
> not anyhow better to read and have a downside of memory fragmentation.

My idea would be to introduce a variant of devm_add_action_or_reset()
that copies the data (in a way to prevent the fragmentation), such that
the function could look as follows:

int devm_atomic_notifier_chain_register(struct device *dev,
                                       struct atomic_notifier_head *nh,
                                       struct notifier_block *n)
{
	struct atomic_notifier_chain_devres dr =3D {
		.nh =3D nh,
		/*
		 * Maybe rename n to nb (or vice-versa) to make the
		 * names match here?
		 */
		.nb =3D n,
	};
	int ret;
=09
	ret =3D atomic_notifier_chain_register(nh, n);
	if (ret)
		return ret;
=09
	return devm_copy_data_and_add_action_or_reset(dev,
						      devm_atomic_notifier_chain_unregister,
						      &dr, sizeof(dr));
}

The name is ugly and long, but IMHO the semantics are useful and the new
devm_atomic_notifier_chain_register() looks IMHO nicer that the original
=66rom Eliav's patch.

But that would be a separate topic, so going with the currently
suggested approach is fine for me.

If you rename n to nb, you can have my ack.

Best regards
Uwe

--pgdaeslknqpb7jv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp6qQ0ACgkQj4D7WH0S
/k6ggwf/Z6S0sEQFjfzsNngJIVe2RoUmYHf1HfmknhlH/LnJGYT0OHIavL+0UQOU
B+wpvX9017EnBs2q/1eK2G+HPFlD3maUNsneSetO+JmHsM+irw3CWi7q8Dp2WPcn
ytwmRruben9C96hQPBK/rhAaLk/763FJ+0OHkJtc3Jr9reRXtEqdBtHdM5WzSX/q
ccFlhWQAlYb2myD50oTjypoiw19P+hig/s0eBOZZR9y7Zpc19Hjou6Eh6hpCOR8n
RKw8Z9tFLBn2BlxaO7WW1scfOoxSdNhvoXlj5zeQqozPxcVvmpsmS/LwY90vaCIF
WgjPbhvYs1ELYqC5MLau4yu6CUumAA==
=5gDi
-----END PGP SIGNATURE-----

--pgdaeslknqpb7jv7--
