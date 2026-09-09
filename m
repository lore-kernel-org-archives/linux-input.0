Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7D57981C;
	Wed,  9 Sep 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960491; cv=none; b=sbGJtJKUzITG8HQiD37BmuI0YcvgNJdtB8BEHEdH8YtdMxAxGU+yrLLzSVGZhcybL+ds8VxF4vzziUUw7aagUolz5ztOduTngKV24b6LJYRG76Kp51O42YoIGGQUBPqySOrnwvRHdJKGC/stcSWXXMQwIWVq+cDjjUwfw7JPgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960491; c=relaxed/simple;
	bh=/hlzJNzei2knOn1RYcaTNkb4UoqZbwgVsH5KNit1MHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9oVulXpzlgva3wYektP1omFy5KrfwNhigc0FV54Q53VOzqWgsd0r3jGIGX3PaycuLNCZR0eWMlwUqeR3UhveKhUZuZB2i/NWzGD4kJFGI5eHRcWAROQ6sZOuT9jw9i/cCeQTeJtLiM/iQvC/NR8n+U/vsoU9KhNk+REVdkfZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR5D3nm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR5D3nm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C301F00A3A;
	Wed,  9 Sep 2026 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960486;
	bh=/hlzJNzei2knOn1RYcaTNkb4UoqZbwgVsH5KNit1MHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eR5D3nm1CPgbjmHPZ0Vv7T4vdNRF/43OgybS94gl2A9fsyrl4gGmKe6vwaT3jfTzX
	 +jD4I9IGrYtGuGXb5/A7jnHJvsDKGHllhymRTLq9kCq/SQi87n+n9y8sD4xk8HYc4W
	 1FMZTsqHXMX6M3yTH47nD27tyCXLTKlR5oFEGKYxbRLJ27lUqEnoIOljlrumgyldGk
	 vQ0EiMkovKU1SvLxEK2ji2FQp/hgc7rRh1M5u3fknsEg1fK7g7esz94rpEqvklnBCa
	 BYmZFTXxMbawW0CHZITqBgDveaise1uxWGeZVkrhXq8mgPMzdHFvBAlr06emaY0HNc
	 eC2FsYwPx3u3A==
Date: Wed, 9 Sep 2026 14:27:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
Message-ID: <76d70b0a-a3c1-4051-84c9-77afb715c4a8@sirena.org.uk>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E7vTznbJl/k8Ppdd"
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
X-Cookie: Postage will be paid by addressee.


--E7vTznbJl/k8Ppdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 03:21:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>=20
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.

Acked-by: Mark Brown <broonie@kernel.org>

--E7vTznbJl/k8Ppdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqhXtwACgkQJNaLcl1U
h9DKkgf/RLbTE5UB6RL3Q66U8VBY9ivEji//LxLXmZDVRMWW85M/tZkuimYXhr1H
qRZzWzsDpkIZhMa5DFLZxJGgVhSyRq9lmv40QYt8TboWu0+dKRy4nuB95+RSTNWh
fjmkSjHkD/A3ELOP2Q/9B/cCFXsbGXHwS8eXeJVkuaDa1BSP3E7o1l338kofZy5F
KyFWqJgxYKL/U82xSTvj04+NKj++SorlCIGShW9hgF11hhNTRHMwW8uF2pksnopN
W8URlMgbSAEsELUabpsbzCFqwtnOJZU2y2vWAICyNt491Nctuj5oUx6D3c0HFsnZ
z8z8A5SciRK3sUB/+Uh4thfPneAMHA==
=lTKT
-----END PGP SIGNATURE-----

--E7vTznbJl/k8Ppdd--
