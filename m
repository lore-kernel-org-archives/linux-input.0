Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D073115A2;
	Sun, 16 Aug 2026 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862840; cv=none; b=U7Xwro065xdZ5/n6sJ6YRE4ef6czrbb8qRT0iVQfWSQ/s3O9yAA7iRtGqoR83JIbAY/6i2HKBZcWLCpbu0zWhoARqnnWiS/PLXp7Jg2R2jfJneqnVXEftSlTmGWRT18rTK5hri4LajbRY8nZiqze4HjIJE/XvMlOW6Yjt9ne3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862840; c=relaxed/simple;
	bh=tuGgDjjUnd7XTMmE5p/sSXutNK7SpeFudznU3x1ov5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTQRp7BKGeS7oXKCsDvkKF/m2wEIAFYl163E9EwGuuw5wKmczO3YCUgPPggRRu5w3CfzJhFuguRT0vZAvDVbj09NUWBSxwbqeAVjk2OOPY6fNSShjrOC2dRKNFVGSqhYmUJmy0TOE6W9Jox1xvKlBfv7pHEbvAtidTjpRy/9uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vocyr0LK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vocyr0LK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6B4991F000E9;
	Sun, 16 Aug 2026 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786862839;
	bh=x2T0QVPCk/bam794xGeOwBl2jyK+bAZTLI+QcRCUKY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vocyr0LK4zCzV4g7MyqKqD6dAlpo6nZ/Zi4MtNooNvhyscxySoUVAMofIYt1oIAYC
	 hftZiwGQjnl3Ts3+XgIck48BiHSphifAp4txHV/AkawSjRJXWIWNlUydivsqChndK1
	 aWH3meu4InEjNg8tyX/+K+yEhxgZr5CFMLsaNq7mu8gisY8lDSNfS3a02A01OBWPJe
	 KYYzHGOdwWJOs0KpdAzKsQM05kgSuEnhp9dFNgzjBBUpdwkF5TFVGBzeYYw7jKhKF9
	 36l33vAtCiw4YxZOM4rFrJc2uVqXQwrAYUjiAPww06bQHT5xshG85YvazAHBJxCzTI
	 yDcrdZD6PcYgg==
Date: Sun, 16 Aug 2026 08:47:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Farber, Eliav" <farbere@amazon.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, 
	"tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"guohanjun@huawei.com" <guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "linusw@kernel.org" <linusw@kernel.org>, 
	"brgl@kernel.org" <brgl@kernel.org>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>, 
	"jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, 
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, 
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hansg@kernel.org" <hansg@kernel.org>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "W_Armin@gmx.de" <W_Armin@gmx.de>, 
	"fabio.m.de.francesco@linux.intel.com" <fabio.m.de.francesco@linux.intel.com>, "kaihengf@nvidia.com" <kaihengf@nvidia.com>, 
	"ankita@nvidia.com" <ankita@nvidia.com>, "leitao@debian.org" <leitao@debian.org>, 
	"pedro.pbg@usp.br" <pedro.pbg@usp.br>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"frederic@kernel.org" <frederic@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
Message-ID: <aoFcyiofUhsetEiq@monoceros>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-11-farbere@amazon.com>
 <anlSAqWxS7boyJBT@monoceros>
 <MN0PR18MB5870444BD9375EF4F7131851C6D82@MN0PR18MB5870.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkd4u7j63fnaijay"
Content-Disposition: inline
In-Reply-To: <MN0PR18MB5870444BD9375EF4F7131851C6D82@MN0PR18MB5870.namprd18.prod.outlook.com>


--gkd4u7j63fnaijay
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
MIME-Version: 1.0

Hello,

On Sun, Aug 16, 2026 at 05:39:47AM +0000, Farber, Eliav wrote:
> > On Sun, Jul 26, 2026 at 10:17:36AM +0000, Eliav Farber wrote:
> > >  int devm_uniwill_wmi_register_notifier(struct device *dev, struct=20
> > > notifier_block *nb)  {
> > > -	int ret;
> > > -
> > > -	ret =3D blocking_notifier_chain_register(&uniwill_wmi_chain_head, n=
b);
> > > -	if (ret < 0)
> > > -		return ret;
> > > -
> > > -	return devm_add_action_or_reset(dev, devm_uniwill_wmi_unregister_no=
tifier, nb);
> > > +	return devm_blocking_notifier_chain_register(dev,
> > > +						     &uniwill_wmi_chain_head,
> > > +						     nb);
> > >  }
> >
> > I'd remove this function and replace calls to it directly by devm_block=
ing_notifier_chain_register().
>=20
> uniwill_wmi_chain_head is static in uniwill-wmi.c and the caller is in
> uniwill-acpi.c. The wrapper encapsulates access to this module-private
> notifier head - removing it would require exposing the variable through
> the header, which breaks the current abstraction.
>=20
> I'd prefer to keep the wrapper as-is.

Sounds like a good justification, thanks for considering my suggestion.

Uwe

--gkd4u7j63fnaijay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqBXPEACgkQj4D7WH0S
/k5G9QgAiPl0SaJnsb71wiarjshHUxBTQ25ctRmpttPlhvHHEBw0CiKuC69HBhlW
x4a5BrRCQa6F8Tu9QxhAfS+3LfmK8Jxxfmk2cYWxruNUqH7u8elLQxzRTq/GlWX4
E8a1chJddKP7vbmFVM3YClG+ilryPCNVS2Xg/b+yIT+VgCRzdQjEgme3k6qagUOR
cIw6LAy1xDecauMYWU94PiXkO48m6a46dST1tmxjveaXMv4ZPJW8vCIg50XRQnMI
iuFeH4M8+m0g4eZy+4yAaSM7qcevqFFk0fJQFdlOrACDhqFthJIoxF7QFRWrIi4c
4goHTZRM+F+JcMu6mVFcA7UMd9GPOg==
=7fHf
-----END PGP SIGNATURE-----

--gkd4u7j63fnaijay--
